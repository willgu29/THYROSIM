//
//  Inputs.h
//  THYROSIM
//
//  Created by William Gu on 10/20/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Inputs : NSObject

@property (nonatomic, strong) NSString *inputName;
@property (nonatomic) NSInteger doseAmount;
@property (nonatomic) NSInteger startTime;
@property (nonatomic) NSInteger endTime;

@property (nonatomic) NSInteger doseInterval; //day (omit if is infusion type)

-(BOOL)missingData;

@end
