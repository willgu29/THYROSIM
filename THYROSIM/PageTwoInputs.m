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
    _inputArray2 = [[NSMutableArray alloc] init];
}

-(void)createFilledArray
{
    _filledArray = [[NSMutableArray alloc] init];
    _filledArray2 = [[NSMutableArray alloc] init];
}

-(void)logAllData
{
    for (Inputs *input in _filledArray)
    {
        NSLog(@"NAME: %@", input.inputName);
        NSLog(@"Dose Amount: %ld", (long)input.doseAmount);
        NSLog(@"ST: %ld", (long)input.startTime);
        NSLog(@"ET: %ld", (long)input.endTime);
        NSLog(@"DI: %ld", (long)input.doseInterval);
        NSLog(@"\n");

    }
}

-(void)logAllData2
{
    for (Inputs *input in _filledArray2)
    {
        NSLog(@"NAME: %@", input.inputName);
        NSLog(@"Dose Amount: %ld", (long)input.doseAmount);
        NSLog(@"ST: %ld", (long)input.startTime);
        NSLog(@"ET: %ld", (long)input.endTime);
        NSLog(@"DI: %ld", (long)input.doseInterval);
        NSLog(@"\n");
        
    }
}


@end
