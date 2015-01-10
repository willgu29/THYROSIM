//
//  MathComputations.m
//  THYROSIM
//
//  Created by William Gu on 10/21/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "MathComputations.h"

const NSInteger DIVISOR = 10;

@implementation MathComputations

-(instancetype)init
{
    self = [super init];
    if (self)
    {
      
    }
    return self;
}

-(void)addEverything:(NSInteger)numberGraph andNumber:(NSInteger)number
{
    //Add everything
    if (numberGraph == 1)
    {
        [self.outputData.graphOneData addObject:[NSNumber numberWithInt:number]];
    }
    else if (numberGraph == 2)
    {
        [self.outputData.graphTwoData addObject:[NSNumber numberWithInt:number]];
    }
    else if (numberGraph == 3)
    {
        [self.outputData.graphThreeData addObject:[NSNumber numberWithInt:number]];
    }
    else
    {
        NSLog(@"HELP");
    }
}

-(NSInteger)divide:(NSInteger)myNumber
{
    return myNumber/DIVISOR;
}

-(NSInteger)add:(NSInteger)digitOne numberTwo:(NSInteger)digitTwo
{
    return (digitOne + digitTwo);
}

@end
