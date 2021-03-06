//
//  MathComputations.m
//  THYROSIM
//
//  Created by William Gu on 10/21/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//


#import "MathComputations.h"
#import "AppDelegate.h"
#import "Inputs.h"

#import "MathSolver.hpp"

@interface MathComputations()
{
    int countValue;
}
@end
struct Opaque
{
    storeData *storeDataInstance;
};
@implementation MathComputations

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _T4Values = [[NSMutableArray alloc] init];
        _T3Values = [[NSMutableArray alloc] init];
        _TSHValues = [[NSMutableArray alloc] init];
    }
    return self;
}

-(storeData*)initOpaque
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    float t4S = delegate.dataObject.pageOneData.t4Secretion;
    float t4A = delegate.dataObject.pageOneData.t4Absorption;
    float t3S = delegate.dataObject.pageOneData.t3Secretion;
    float t3A = delegate.dataObject.pageOneData.t3Absorption;
    float simulTime = delegate.dataObject.pageOneData.simulationTimeDays;
    Opaque  opaque;
    opaque.storeDataInstance = new storeData(simulTime, t4S, t4A, t3S, t3A);
    return opaque.storeDataInstance;
}

-(void)getShitDone:(BOOL)runtwo //I.E. get graph results
{
    //These have been moved to initOpaque
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    float t4S = delegate.dataObject.pageOneData.t4Secretion;
//    float t4A = delegate.dataObject.pageOneData.t4Absorption;
//    float t3S = delegate.dataObject.pageOneData.t3Secretion;
//    float t3A = delegate.dataObject.pageOneData.t3Absorption;
//    float simulTime = delegate.dataObject.pageOneData.simulationTimeDays;
//    [self convertToPrimitive];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
  
    storeData* storeDataInstance = [self initOpaque];
    
    storeDataInstance->getTheNumbers([self convertToPrimitive:runtwo], countValue, delegate.dataObject.pageOneData.recalculateInitialConditions);
    
    
    for (int i = 0; i< storeDataInstance->getnum_hours(); i++)
    {
//        NSLog(@"%f", storeDataInstance->getT4()[i]);
//        NSLog(@"%f", storeDataInstance->getT3()[i]);
//        NSLog(@"%f", storeDataInstance->getTSH()[i]);
        [_T4Values addObject:[NSNumber numberWithFloat:storeDataInstance->getT4()[i]]];
        [_T3Values addObject:[NSNumber numberWithFloat:storeDataInstance->getT3()[i]]];
        [_TSHValues addObject:[NSNumber numberWithFloat:storeDataInstance->getTSH()[i]]];
        
    }
    _intervalHours = storeDataInstance->getnum_hours();

    //No longer use struct opaque ****
//    opaque->storeDataInstance = new storeData(simulTime, t4S, t4A, t3S, t3A);
//    opaque->storeDataInstance->getTheNumbers([self convertToPrimitive], countValue);
 
    
//    
//    for (int i = 0; i< opaque->storeDataInstance->getnum_hours(); i++)
//    {
//        NSLog(@"%f", opaque->storeDataInstance->getT4()[i]);
//        NSLog(@"%f", opaque->storeDataInstance->getT3()[i]);
//        NSLog(@"%f", opaque->storeDataInstance->getTSH()[i]);
//    }
}

-(float *)convertToPrimitive:(BOOL)runtwo
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSArray *inputArray;
    
    if (runtwo)
    {
            inputArray = delegate.dataObject.pageTwoData.filledArray2;
    }
    else
    {
            inputArray = delegate.dataObject.pageTwoData.filledArray;
    }

    
    int count = [inputArray count]*5;
    
    float *cArray = new float[count];
    
    for (int i = 0; i < count; i++)
    {
        Inputs *inputObject = [inputArray objectAtIndex:i/5];
        cArray[i] = inputObject.inputID;
        i++;
        cArray[i] = inputObject.doseAmount;
        i++;
        cArray[i] = inputObject.doseInterval;
        i++;
        cArray[i] = inputObject.startTime;
        i++;
        cArray[i] = inputObject.endTime;
    }
    
    countValue = count;
    
    return cArray;
    
}


//#pragma mark - Extras
//
//-(void)addEverything:(NSInteger)numberGraph andNumber:(NSInteger)number
//{
//    //Add everything
//    if (numberGraph == 1)
//    {
//        [self.outputData.graphOneData addObject:[NSNumber numberWithInt:number]];
//    }
//    else if (numberGraph == 2)
//    {
//        [self.outputData.graphTwoData addObject:[NSNumber numberWithInt:number]];
//    }
//    else if (numberGraph == 3)
//    {
//        [self.outputData.graphThreeData addObject:[NSNumber numberWithInt:number]];
//    }
//    else
//    {
//        NSLog(@"HELP");
//    }
//}


@end
