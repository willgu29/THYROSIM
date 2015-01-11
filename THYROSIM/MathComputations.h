//
//  MathComputations.h
//  THYROSIM
//
//  Created by William Gu on 10/21/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreData.h"

struct Opaque;

@interface MathComputations : NSObject
{
    struct Opaque* opaque;
}


@property (nonatomic, strong) StoreData *outputData;
@property (nonatomic) int myNumber;

-(void)example;
-(void)addEverything:(NSInteger)numberGraph andNumber:(NSInteger)number;


-(instancetype)init;

@end
