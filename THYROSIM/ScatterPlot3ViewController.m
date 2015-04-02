//
//  ScatterPlot3ViewController.m
//  THYROSIM
//
//  Created by William Gu on 12/7/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "ScatterPlot3ViewController.h"
#import "CorePlot-CocoaTouch.h"

@interface ScatterPlot3ViewController ()
{
}
@end

@implementation ScatterPlot3ViewController

-(instancetype)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

-(void)viewDidAppear:(BOOL)animated
{
}


- (void)didReceiveMemoryWarning {
}


#pragma mark - Chart behavior
-(void)initPlot
{
    [self configureHost];
    [self configureGraph];
    [self myConfigure];
//    [self configurePlots];
//    [self configureAxes];
}


-(void)myConfigure
{
}

-(void)configureHost
{
}

-(void)configureGraph
{
   
}

-(void)configurePlots
{
}

-(void)configureAxes
{
}

#pragma mark - CPTPlotDataSource Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return _intervalHours;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx
{
    switch (fieldEnum) {
        case CPTScatterPlotFieldX:
            //place x data
            return [NSNumber numberWithInteger:idx];
            
        case CPTScatterPlotFieldY:
            //place y data
            return [self.TSHValues objectAtIndex:idx];
            break;
    }
    return [NSDecimalNumber zero];
    
}
@end
