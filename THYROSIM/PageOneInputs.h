//
//  PageOneInputs.h
//  THYROSIM
//
//  Created by William Gu on 10/11/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageOneInputs : NSObject

@property (nonatomic) NSInteger t4Secretion;
@property (nonatomic) NSInteger t4Absorption;
@property (nonatomic) NSInteger t3Secretion;
@property (nonatomic) NSInteger t3Absorption;

@property (nonatomic) NSInteger simulationTimeDays;


@property (nonatomic) BOOL recalculateInitialConditions;
@property (nonatomic) BOOL simluationResultColorIsBlue; //else black

-(instancetype)init;
-(void)logAllData;

@end
