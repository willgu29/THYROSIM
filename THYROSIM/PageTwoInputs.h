//
//  PageTwoInputs.h
//  THYROSIM
//
//  Created by William Gu on 10/11/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageTwoInputs : NSObject

@property (strong, nonatomic) NSMutableArray *inputArray; //of numbers
@property (strong, nonatomic) NSMutableArray *filledArray; //of inputs

@property (strong, nonatomic) NSMutableArray *inputArray2; //of numbers
@property (strong, nonatomic) NSMutableArray *filledArray2; //of inputs


-(instancetype)init;
-(void)logAllData;

@end
