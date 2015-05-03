//
//  OverviewPlotsViewController.h
//  THYROSIM
//
//  Created by William Gu on 1/16/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface OverviewPlotsViewController : UIViewController <CPTPlotDataSource, CPTPlotDelegate>

@property (nonatomic, strong) CPTGraphHostingView *hostingview1;
@property (nonatomic, strong) CPTGraphHostingView *hostingview2;
@property (nonatomic, strong) CPTGraphHostingView *hostingview3;
@property (nonatomic, strong) CPTGraph *graph1;
@property (nonatomic, strong) CPTGraph *graph2;
@property (nonatomic, strong) CPTGraph *graph3;

@property (nonatomic, strong) CPTPlot *check;
@property (nonatomic, strong) NSArray *T4Values;
@property (nonatomic, strong) NSArray *T3Values;
@property (nonatomic, strong) NSArray *TSHValues;

@property (nonatomic, strong) NSArray *T4Values_2;
@property (nonatomic, strong) NSArray *T3Values_2;
@property (nonatomic, strong) NSArray *TSHValues_2;

@property (nonatomic) int hourinterval;



@property (nonatomic) BOOL touchPlot1Selected;
@property (nonatomic) BOOL touchPlot2Selected;
@property (nonatomic) BOOL touchPlot3Selected;

@property (nonatomic) NSUInteger index1selected;
@property (nonatomic) NSUInteger index2selected;
@property (nonatomic) NSUInteger index3selected;


@property (nonatomic) UITextField *T4_1;
@property (nonatomic) UITextField *T3_1;
@property (nonatomic) UITextField *TSH_1;

@property (nonatomic) UITextField *T4_2;
@property (nonatomic) UITextField *T3_2;
@property (nonatomic) UITextField *TSH_2;

-(instancetype) init;

@end
