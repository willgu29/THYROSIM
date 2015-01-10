//
//  ScatterPlot3ViewController.h
//  THYROSIM
//
//  Created by William Gu on 12/7/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface ScatterPlot3ViewController : UIViewController <CPTPlotDataSource>

@property (nonatomic, strong) CPTGraphHostingView *hostView;

@end
