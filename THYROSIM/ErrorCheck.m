//
//  ErrorCheck.m
//  THYROSIM
//
//  Created by William Gu on 1/14/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "ErrorCheck.h"
#import "ErrorEnums.h"
#import "Inputs.h"

@implementation ErrorCheck

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

-(int)errorCheckAll
{
    int pageOneErrorID = [self pageOneErrorChecks];
    int pageTwoErrorID = [self pageTwoErrorChecks];
    
    if (pageOneErrorID != PAGE_ONE_GOOD)
    {
        return pageOneErrorID;
    }
    if (pageTwoErrorID != PAGE_TWO_GOOD)
    {
        return pageTwoErrorID;
    }
    return ALL_GOOD_PROCEED;
}

-(int)pageOneErrorChecks
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    if (delegate.dataObject.pageOneData.t4Secretion < 0 || delegate.dataObject.pageOneData.t4Secretion > 200)
    {
        return PAGE_ONE_T4S_ERROR;
    }
    if (delegate.dataObject.pageOneData.t4Absorption < 0 || delegate.dataObject.pageOneData.t4Absorption > 100)
    {
        return PAGE_ONE_T4A_ERROR;
    }
    if (delegate.dataObject.pageOneData.t3Secretion < 0 || delegate.dataObject.pageOneData.t3Secretion > 200)
    {
        return PAGE_ONE_T3S_ERROR;
    }
    if (delegate.dataObject.pageOneData.t3Absorption < 0 || delegate.dataObject.pageOneData.t3Absorption > 100)
    {
        return PAGE_ONE_T3A_ERROR;
    }
    if (delegate.dataObject.pageOneData.simulationTimeDays < 1 || delegate.dataObject.pageOneData.simulationTimeDays > 50)
    {
        return PAGE_ONE_SIMULDAYS_ERROR;
    }
    
    return PAGE_ONE_GOOD;
}


-(int)pageTwoErrorChecks
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    int dosingCheck = -99;
    int infusionCheck = -99;
    
    for (int i = 0; i < [delegate.dataObject.pageTwoData.filledArray count]; i++)
    {
        Inputs *currentInput = [delegate.dataObject.pageTwoData.filledArray objectAtIndex:i];
        if (currentInput.inputID == 5 || currentInput.inputID == 6)
        {
            infusionCheck = [self errorCheckInfusion:currentInput];
            if (infusionCheck != PAGE_TWO_INFUSION_GOOD)
            {
                return infusionCheck;
            }
            else
            {
                continue;
            }
        }
        dosingCheck = [self errorCheckDose:currentInput];
        if (dosingCheck != PAGE_TWO_DOSING_GOOD)
        {
            return dosingCheck;
        }
    }
    return PAGE_TWO_GOOD;
}

-(int)errorCheckDose:(Inputs *)currentInput
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    if (currentInput.startTime < 0 || currentInput.startTime > currentInput.endTime || currentInput.endTime > delegate.dataObject.pageOneData.simulationTimeDays)
    {
        return PAGE_TWO_TIME_ERROR;
    }
    if (currentInput.doseInterval == 0 || currentInput.doseInterval > (currentInput.endTime - currentInput.startTime))
    {
        return PAGE_TWO_DOSING_INTERVAL_ERROR;
    }
    
    return PAGE_TWO_DOSING_GOOD;
}

-(int)errorCheckInfusion:(Inputs *)currentInput
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    if (currentInput.startTime < 0 || currentInput.endTime > delegate.dataObject.pageOneData.simulationTimeDays || currentInput.startTime >= currentInput.endTime)
    {
        return PAGE_TWO_TIME_ERROR;
    }
    return PAGE_TWO_INFUSION_GOOD;
}

@end
