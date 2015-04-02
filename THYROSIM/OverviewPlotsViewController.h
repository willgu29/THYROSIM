//
//  OverviewPlotsViewController.h
//  THYROSIM
//
//  Created by William Gu on 1/16/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface OverviewPlotsViewController : UIViewController <CPTPlotDataSource>

@property (nonatomic, strong) CPTGraphHostingView *hostingview1;
@property (nonatomic, strong) CPTGraphHostingView *hostingview2;
@property (nonatomic, strong) CPTGraphHostingView *hostingview3;

@property (nonatomic, strong) NSArray *T4Values;
@property (nonatomic, strong) NSArray *T3Values;
@property (nonatomic, strong) NSArray *TSHValues;

@property (nonatomic) int hourinterval;

-(instancetype) init;

@end
