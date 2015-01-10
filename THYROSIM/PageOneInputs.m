//
//  PageOneInputs.m
//  THYROSIM
//
//  Created by William Gu on 10/11/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "PageOneInputs.h"

@implementation PageOneInputs

-(void)logAllData
{
    NSLog(@"T4S: %ld",(long)_t4Secretion);
    NSLog(@"T4A: %ld",(long)_t4Absorption);
    NSLog(@"T3S: %ld",(long)_t3Secretion);
    NSLog(@"T3A: %ld",(long)_t3Absorption);
    NSLog(@"RIC: %d", _recalculateInitialConditions);
    NSLog(@"COLOR: %d", _simluationResultColorIsBlue);
    NSLog(@"\n");

}

@end
