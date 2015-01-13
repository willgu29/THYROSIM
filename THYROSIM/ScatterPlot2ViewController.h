//
//  ScatterPlot2ViewController.h
//  THYROSIM
//
//  Created by William Gu on 12/7/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface ScatterPlot2ViewController : UIViewController <CPTPlotDataSource>

@property (nonatomic, strong) CPTGraphHostingView *hostView;
@property (nonatomic, strong) NSArray *T3Values;
@property (nonatomic) int intervalHours;


-(instancetype)init;

@end
