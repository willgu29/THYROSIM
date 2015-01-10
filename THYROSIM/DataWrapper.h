//
//  DataWrapper.h
//  THYROSIM
//
//  Created by William Gu on 10/11/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageOneInputs.h"
#import "PageTwoInputs.h"

@interface DataWrapper : NSObject

@property (nonatomic, strong) PageOneInputs *pageOneData;
@property (nonatomic, strong) PageTwoInputs *pageTwoData;

-(NSMutableArray *)getPageTwoInputArray;
-(instancetype)init;

@end
