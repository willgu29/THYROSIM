//
//  ScatterPlotViewController.m
//  THYROSIM
//
//  Created by William Gu on 11/12/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "ScatterPlotViewController.h"
#import "TabGraphViewController.h"

@interface ScatterPlotViewController ()


@end

@implementation ScatterPlotViewController

@synthesize hostView = hostView_;

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

-(IBAction)backButton:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"Scatter Plot 1");
    [super viewDidAppear:animated];
    [self initPlot];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Chart behavior
-(void)initPlot
{
    [self configureHost];
    [self configureGraph];
//    [self configurePlots];
//    [self configureAxes];
    [self myConfigure];
}

-(void)myConfigure
{
    // 1 - Get graph and plot space
    CPTGraph *graph = self.hostView.hostedGraph;
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    // 2 - Create the three plots
    CPTScatterPlot *aaplPlot = [[CPTScatterPlot alloc] init];
    aaplPlot.dataSource = self;
    aaplPlot.identifier = @"APPL";
    CPTColor *aaplColor = [CPTColor blueColor];
    [graph addPlot:aaplPlot toPlotSpace:plotSpace];
    
    
    
    // 3 - Set up plot space
    [plotSpace scaleToFitPlots:[NSArray arrayWithObjects:aaplPlot, nil]];
    CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
    [xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];
    plotSpace.xRange = xRange;
    CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
    [yRange expandRangeByFactor:CPTDecimalFromCGFloat(1.2f)];
    plotSpace.yRange = yRange;
    // 4 - Create styles and symbols
    CPTMutableLineStyle *aaplLineStyle = [aaplPlot.dataLineStyle mutableCopy];
    aaplLineStyle.lineWidth = 2.0;
    aaplLineStyle.lineColor = aaplColor;
    aaplPlot.dataLineStyle = aaplLineStyle;
    CPTMutableLineStyle *aaplSymbolLineStyle = [CPTMutableLineStyle lineStyle];
    aaplSymbolLineStyle.lineColor = aaplColor;
    CPTPlotSymbol *aaplSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    aaplSymbol.fill = [CPTFill fillWithColor:aaplColor];
    aaplSymbol.lineStyle = aaplSymbolLineStyle;
    aaplSymbol.size = CGSizeMake(6.0f, 6.0f);
    //    aaplPlot.plotSymbol = aaplSymbol;
    
    // 1 - Create styles
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor whiteColor];
    axisTitleStyle.fontName = @"Helvetica-Bold";
    axisTitleStyle.fontSize = 12.0f;
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 2.0f;
    axisLineStyle.lineColor = [CPTColor whiteColor];
    CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
    axisTextStyle.color = [CPTColor whiteColor];
    axisTextStyle.fontName = @"Helvetica-Bold";
    axisTextStyle.fontSize = 11.0f;
    CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor whiteColor];
    tickLineStyle.lineWidth = 2.0f;
    CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor blackColor];
    tickLineStyle.lineWidth = 1.0f;
    // 2 - Get axis set
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
    
    NSNumber* max = [_T4Values valueForKeyPath:@"@max.self"];
    NSNumber* min = [_T4Values valueForKeyPath:@"@min.self"];
    //    double newNumber = (min.doubleValue + max.doubleValue)/2;
    double newNumber = (min.doubleValue*.9999);
    axisSet.xAxis.orthogonalCoordinateDecimal = CPTDecimalFromDouble(newNumber);
    
    
    // 3 - Configure x-axis
    CPTAxis *x = axisSet.xAxis;
    x.title = @"Hours";
    x.titleTextStyle = axisTitleStyle;
    x.titleOffset = 15.0f;
    x.axisLineStyle = axisLineStyle;
    x.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
    x.labelTextStyle = axisTextStyle;
    x.majorTickLineStyle = axisLineStyle;
    x.majorTickLength = 4.0f;
    x.tickDirection = CPTSignNegative;
    
    
    // 4 - Configure y-axis
    CPTAxis *y = axisSet.yAxis;
    y.title = @"Values";
    y.titleTextStyle = axisTitleStyle;
    y.titleOffset = -40.0f;
    y.axisLineStyle = axisLineStyle;
    y.majorGridLineStyle = gridLineStyle;
    y.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
    y.labelTextStyle = axisTextStyle;
    y.labelOffset = 16.0f;
    y.majorTickLineStyle = axisLineStyle;
    y.majorTickLength = 4.0f;
    y.minorTickLength = 2.0f;
    y.tickDirection = CPTSignPositive;
    
    NSNumberFormatter *plotFormatter = [[NSNumberFormatter alloc] init];
    [plotFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [plotFormatter setMaximumFractionDigits:4];
    [plotFormatter setFormatWidth:2];
    [plotFormatter setPositiveFormat:@"####.####"];
    
    x.labelFormatter = plotFormatter;
    y.labelFormatter = plotFormatter;
    
    // Auto scale the plot space to fit the plot data
    [plotSpace scaleToFitPlots:[graph allPlots]];
    
    // Expand the ranges to put some space around the plot
    [xRange expandRangeByFactor:CPTDecimalFromDouble(1.2)];
    [yRange expandRangeByFactor:CPTDecimalFromDouble(1.2)];
    plotSpace.xRange = xRange;
    plotSpace.yRange = yRange;
    
    [xRange expandRangeByFactor:CPTDecimalFromDouble(1.025)];
    xRange.location = plotSpace.xRange.location;
    [yRange expandRangeByFactor:CPTDecimalFromDouble(1.05)];
    x.visibleAxisRange = xRange;
    y.visibleAxisRange = yRange;
    
    [xRange expandRangeByFactor:CPTDecimalFromDouble(3.0)];
    [yRange expandRangeByFactor:CPTDecimalFromDouble(3.0)];
    plotSpace.globalXRange = xRange;
    plotSpace.globalYRange = yRange;
    
}

-(void)configureHost
{
    CGRect frame = CGRectMake(0, 40, self.view.window.bounds.size.width, self.view.window.bounds.size.height-80);
    
    self.hostView = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:frame];//self.view.bounds];
    self.hostView.allowPinchScaling = YES;
    [self.view addSubview:self.hostView];
}

-(void)configureGraph
{
    // 1 - Create the graph
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
    [graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];//kCPTSlateTheme
    self.hostView.hostedGraph = graph;
    // 2 - Set graph title
    NSString *title = @"T4 Values";
    graph.title = title;
    // 3 - Create and set text style
    CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
    titleStyle.color = [CPTColor whiteColor];
    titleStyle.fontName = @"Helvetica-Bold";
    titleStyle.fontSize = 16.0f;
    graph.titleTextStyle = titleStyle;
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph.titleDisplacement = CGPointMake(0.0f, 10.0f);
    // 4 - Set padding for plot area
    [graph.plotAreaFrame setPaddingLeft:30.0f];
    [graph.plotAreaFrame setPaddingBottom:30.0f];
    // 5 - Enable user interactions for plot space
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
}

-(void)configurePlots
{
    // 1 - Get graph and plot space
    CPTGraph *graph = self.hostView.hostedGraph;
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    
    
   
    
    // 2 - Create the three plots
    CPTScatterPlot *aaplPlot = [[CPTScatterPlot alloc] init];
    aaplPlot.dataSource = self;
    aaplPlot.identifier = @"APPL";
    CPTColor *aaplColor = [CPTColor blueColor];
    [graph addPlot:aaplPlot toPlotSpace:plotSpace];
    [plotSpace scaleToFitPlots:[NSArray arrayWithObjects:aaplPlot, nil]];
    
//    NSNumberFormatter *plotFormatter = [[NSNumberFormatter alloc] init];
//    [plotFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
//    [plotFormatter setMaximumFractionDigits:2];
//    [plotFormatter setFormatWidth:2];
//    [plotFormatter setPositiveFormat:@"###.##"];
//     aaplPlot.labelFormatter = plotFormatter;

    
//    CPTPlotRange *xRangeMe = [[CPTPlotRange alloc] initWithLocation:[NSNumber numberWithInt:0].decimalValue length:[NSNumber numberWithInt:_intervalHours].decimalValue];
//    
//    
//    NSNumber* min = [_T4Values valueForKeyPath:@"@min.self"];
//    NSNumber* max = [_T4Values valueForKeyPath:@"@max.self"];
//
//    CPTPlotRange *yRangeMe = [[CPTPlotRange alloc] initWithLocation:min.decimalValue length:max.decimalValue];
//
//    CPTMutablePlotRange *xRange = xRangeMe.mutableCopy;
//    CPTMutablePlotRange *yRange = yRangeMe.mutableCopy;
//
//    
//    [xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];
//    plotSpace.xRange = xRange;
//    [yRange expandRangeByFactor:CPTDecimalFromCGFloat(1.2f)];
//    plotSpace.yRange = yRange;
//
//
    CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
    [xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];
    plotSpace.xRange = xRange;
    CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
    [yRange expandRangeByFactor:CPTDecimalFromCGFloat(1.2f)];
    plotSpace.yRange = yRange;
    // 4 - Create styles and symbols
    CPTMutableLineStyle *aaplLineStyle = [aaplPlot.dataLineStyle mutableCopy];
    aaplLineStyle.lineWidth = 1.5;
    aaplLineStyle.lineColor = aaplColor;
    aaplPlot.dataLineStyle = aaplLineStyle;
    CPTMutableLineStyle *aaplSymbolLineStyle = [CPTMutableLineStyle lineStyle];
    aaplSymbolLineStyle.lineColor = aaplColor;
    CPTPlotSymbol *aaplSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    aaplSymbol.fill = [CPTFill fillWithColor:aaplColor];
    aaplSymbol.lineStyle = aaplSymbolLineStyle;
    aaplSymbol.size = CGSizeMake(6.0f, 6.0f);
//    aaplPlot.plotSymbol = aaplSymbol;

}

-(void)configureAxes
{
    // 1 - Create styles
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor whiteColor];
    axisTitleStyle.fontName = @"Helvetica-Bold";
    axisTitleStyle.fontSize = 12.0f;
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 2.0f;
    axisLineStyle.lineColor = [CPTColor whiteColor];
    CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
    axisTextStyle.color = [CPTColor whiteColor];
    axisTextStyle.fontName = @"Helvetica-Bold";
    axisTextStyle.fontSize = 11.0f;
    CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor whiteColor];
    tickLineStyle.lineWidth = 2.0f;
    CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor blackColor];
    tickLineStyle.lineWidth = 1.0f;
    // 2 - Get axis set
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
    // 3 - Configure x-axis
    CPTAxis *x = axisSet.xAxis;
    x.title = @"Hours";
    x.titleTextStyle = axisTitleStyle;
    x.titleOffset = 15.0f;
    x.axisLineStyle = axisLineStyle;
    x.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
    x.labelTextStyle = axisTextStyle;
    x.majorTickLineStyle = axisLineStyle;
    x.majorTickLength = 4.0f;
    x.tickDirection = CPTSignNegative;
    
    
//    CGFloat dateCount = _intervalHours;
//    NSMutableSet *xLabels = [NSMutableSet setWithCapacity:dateCount];
//    NSMutableSet *xLocations = [NSMutableSet setWithCapacity:dateCount];
//    for (int i = 0; i< _intervalHours; i++) {
//        NSString *numberHour = [NSString stringWithFormat:@"%d", i];
//        CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:numberHour textStyle:x.labelTextStyle];
//        CGFloat location = i;
//        label.tickLocation = CPTDecimalFromCGFloat(location);
//        label.offset = x.majorTickLength;
//        if (label) {
//            [xLabels addObject:label];
//            [xLocations addObject:[NSNumber numberWithFloat:location]];
//        }
//    }
////    
//    x.axisLabels = xLabels;
//    x.majorTickLocations = xLocations;
//    
    // 4 - Configure y-axis
    CPTAxis *y = axisSet.yAxis;
    y.title = @"Values";
    y.titleTextStyle = axisTitleStyle;
    y.titleOffset = -30.0f;
    y.axisLineStyle = axisLineStyle;
    y.majorGridLineStyle = gridLineStyle;
    y.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
    y.labelTextStyle = axisTextStyle;
    y.labelOffset = 16.0f;
    y.majorTickLineStyle = axisLineStyle;
    y.majorTickLength = 4.0f;
    y.minorTickLength = 2.0f;
    y.tickDirection = CPTSignPositive;
    
    
    NSNumber* min = [_T4Values valueForKeyPath:@"@min.self"];
    NSNumber* max = [_T4Values valueForKeyPath:@"@max.self"];
    
//    double majorIncrement = 1;
//    double minorIncrement = 0.2;
////    CGFloat yMax = (max.doubleValue*1.1);
//    CGFloat yMax = max.doubleValue*1.1;
//    
//    NSMutableSet *yLabels = [NSMutableSet set];
//    NSMutableSet *yMajorLocations = [NSMutableSet set];
//    NSMutableSet *yMinorLocations = [NSMutableSet set];
//    for (double j = min.intValue; j <= yMax; j += minorIncrement) {
//        double mod = fmod(j, majorIncrement);
//        if (YES) { //mod == 0
//            CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%f", j] textStyle:y.labelTextStyle];
//            NSString *formatedDouble = [NSString stringWithFormat:@"%.02f",j];
//            NSDecimal location = CPTDecimalFromString(formatedDouble);
//            
//            label.tickLocation = [NSDecimalNumber decimalNumberWithDecimal:location].decimalValue;
//            label.offset = -y.majorTickLength - y.labelOffset;
//            if (label) {
//                [yLabels addObject:label];
//            }
//            [yMajorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:location]];
//        } else {
//            [yMinorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:CPTDecimalFromDouble(j)]];
//        }
//    }
//    

//    y.axisLabels = yLabels;
//    y.majorTickLocations = yMajorLocations;
//    y.minorTickLocations = yMinorLocations;
//    
//    
    
    
//    //MY STUFF
//    CPTPlotRange *xRangeMe = [[CPTPlotRange alloc] initWithLocation:[NSNumber numberWithInt:0].decimalValue length:[NSNumber numberWithInt:_intervalHours].decimalValue];
//    
////    NSNumber* min = [_T4Values valueForKeyPath:@"@min.self"];
////    NSNumber* max = [_T4Values valueForKeyPath:@"@max.self"];
////    
//    CPTPlotRange *yRangeMe = [[CPTPlotRange alloc] initWithLocation:min.decimalValue length:max.decimalValue];
//    
//    CPTMutablePlotRange *xRange = xRangeMe.mutableCopy;
//    CPTMutablePlotRange *yRange = yRangeMe.mutableCopy;
//    
//    
//    [xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];
//    [yRange expandRangeByFactor:CPTDecimalFromCGFloat(1.2f)];
//   
//
//    
//    y.visibleRange = yRange;
//    x.visibleRange = xRange;
//    
//    
//    [x filteredMajorTickLocations:x.majorTickLocations];
//    [y filteredMajorTickLocations:y.majorTickLocations];
//    [x filteredMinorTickLocations:x.minorTickLocations];
//    [y filteredMinorTickLocations:y.minorTickLocations];
    
    
    NSNumberFormatter *plotFormatter = [[NSNumberFormatter alloc] init];
    [plotFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [plotFormatter setMaximumFractionDigits:4];
    [plotFormatter setFormatWidth:2];
    [plotFormatter setPositiveFormat:@"####.####"];
    
    x.labelFormatter = plotFormatter;
    y.labelFormatter = plotFormatter;   
    
    
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
            return [self.T4Values objectAtIndex:idx];
            break;
    }
    return [NSDecimalNumber zero];
    
}



//[plotSpace pointingDeviceDownEvent:<#(UIEvent *)#> atPoint:<#(CGPoint)#>



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
