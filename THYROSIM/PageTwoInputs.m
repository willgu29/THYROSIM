//
//  PageTwoInputs.m
//  THYROSIM
//
//  Created by William Gu on 10/11/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "PageTwoInputs.h"
#import "Inputs.h"

@implementation PageTwoInputs


-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self createInputArray];
        [self createFilledArray];
    }
    return self;
}

-(void)createInputArray
{
    _inputArray = [[NSMutableArray alloc] init];
}

-(void)createFilledArray
{
    _filledArray = [[NSMutableArray alloc] init];
}

-(void)logAllData
{
    for (Inputs *input in _filledArray)
    {
        NSLog(@"NAME: %@", input.inputName);
        NSLog(@"Dose Amount: %d", input.doseAmount);
        NSLog(@"ST: %d", input.startTime);
        NSLog(@"ET: %d", input.endTime);
        NSLog(@"DI: %d", input.doseInterval);
        NSLog(@"\n");

    }
}


@end
