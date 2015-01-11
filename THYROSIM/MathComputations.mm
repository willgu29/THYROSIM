//
//  MathComputations.m
//  THYROSIM
//
//  Created by William Gu on 10/21/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//


#import "MathComputations.h"
#import "AppDelegate.h"
#import "Inputs.h"

#import "MathSolver.hpp"



const NSInteger DIVISOR = 10;

@interface MathComputations()
{
    int countValue;
}

@property (nonatomic, strong) NSArray *qDot; //Array of floats

@end


struct Opaque
{
    ODE myODE;
};


@implementation MathComputations

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _qDot = [[NSArray alloc] init];
    }
    return self;
}

-(void)pageOneInputs
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    float t4S = delegate.dataObject.pageOneData.t4Secretion;
    float t4A = delegate.dataObject.pageOneData.t4Absorption;
    float t3S = delegate.dataObject.pageOneData.t3Secretion;
    float t3A = delegate.dataObject.pageOneData.t3Absorption;
    float simulTime = delegate.dataObject.pageOneData.simulationTimeDays;
//    [self convertToPrimitive];
  
    
    
    getTheNumbers(simulTime, t4S, t4A, t3S, t3A, [self convertToPrimitive], countValue);
    
}

-(float *)convertToPrimitive
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSArray *inputArray = delegate.dataObject.pageTwoData.filledArray;
    
    int count = [inputArray count]*5;
    
    float *cArray = new float[count];
    
    for (int i = 0; i < count; i++)
    {
        Inputs *inputObject = [inputArray objectAtIndex:i/5];
        cArray[i] = inputObject.inputID;
        i++;
        cArray[i] = inputObject.doseAmount;
        i++;
        cArray[i] = inputObject.doseInterval;
        i++;
        cArray[i] = inputObject.startTime;
        i++;
        cArray[i] = inputObject.endTime;
    }
    
    countValue = count;
    
    return cArray;
    
}

-(void)pageTwoInputs
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    
    
}

-(void)equationCode
{
    _qDot = [self computeFloats];
    
    //Equation code (rk45, etc.)
   
    
}

-(NSArray *)computeFloats
{
    NSArray *myArray = [[NSArray alloc] init];
    return myArray;
}




#pragma mark - Extras

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


@end
