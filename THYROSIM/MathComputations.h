//
//  MathComputations.h
//  THYROSIM
//
//  Created by William Gu on 10/21/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreData.h"

@interface MathComputations : NSObject

@property (nonatomic, strong) StoreData *outputData;
@property (nonatomic) int myNumber;

-(void)example;
-(void)addEverything:(NSInteger)numberGraph andNumber:(NSInteger)number;
-(NSInteger)divide:(NSInteger)myNumber;
-(NSInteger)add:(NSInteger)digitOne numberTwo:(NSInteger)digitTwo;

-(instancetype)init;

@end
