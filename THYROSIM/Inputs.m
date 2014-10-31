//
//  Inputs.m
//  THYROSIM
//
//  Created by William Gu on 10/20/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "Inputs.h"

@implementation Inputs

-(BOOL)missingData
{
    //CHECK
    if (_inputName == nil || _doseAmount == 0 || _endTime == 0 ||_startTime == 0)
    {
        return YES;
    }
    return NO;
}

@end
