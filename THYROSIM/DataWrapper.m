//
//  DataWrapper.m
//  THYROSIM
//
//  Created by William Gu on 10/11/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "DataWrapper.h"

@implementation DataWrapper

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _pageOneData = [[PageOneInputs alloc] init];
        _pageTwoData = [[PageTwoInputs alloc] init];
        
        _pageTwoDatarunTwo = [[PageTwoInputs alloc] init];
    }
    return self;
}


@end
