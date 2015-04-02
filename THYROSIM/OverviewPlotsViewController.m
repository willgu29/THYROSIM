//
//  ScatterPlotViewController.m
//  THYROSIM
//
//  Created by William Gu on 11/12/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "OverviewPlotsViewController.h"
#import "TabGraphViewController.h"
#import "CorePlot-CocoaTouch.h"

@interface OverviewPlotsViewController ()
{
}
@end


@implementation OverviewPlotsViewController

@synthesize hostingview1 = hostingview1_;
@synthesize hostingview2 = hostingview2_;
@synthesize hostingview3 = hostingview3_;


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
    NSLog(@"Scatter Plots");
    [super viewDidAppear:animated];
    [self initPlot];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Chart behavior
-(void)initPlot
{
    [self configureHost];
    [self myConfigure];
    //    [self configureAxes];
}

-(void)configureHost
{
    
    CGRect frame1 = CGRectMake(0, 50, self.view.window.bounds.size.width, (self.view.window.bounds.size.height-80)/3);
    CGRect frame2 = CGRectMake(0, 200, self.view.window.bounds.size.width, (self.view.window.bounds.size.height-80)/3);
    CGRect frame3 = CGRectMake(0, 350, self.view.window.bounds.size.width, (self.view.window.bounds.size.height-80)/3);
    
    self.hostingview1 = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:frame1];//self.view.bounds];
    self.hostingview1.allowPinchScaling = YES;
    [self.view addSubview:self.hostingview1];
    
    self.hostingview2 = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:frame2];//self.view.bounds];
    self.hostingview2.allowPinchScaling = YES;
    [self.view addSubview:self.hostingview2];
    
    self.hostingview3 = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:frame3];//self.view.bounds];
    self.hostingview3.allowPinchScaling = YES;
    [self.view addSubview:self.hostingview3];
    
}

-(void) myConfigure
{
    CPTGraph* graph1  = [[CPTXYGraph alloc] initWithFrame:hostingview1_.bounds];
    graph1.identifier = @"T4";
    CPTGraph* graph2  = [[CPTXYGraph alloc] initWithFrame:hostingview2_.bounds];
    graph2.identifier = @"T3";
    CPTGraph* graph3  = [[CPTXYGraph alloc] initWithFrame:hostingview3_.bounds];
    graph3.identifier = @"TSH";
    
    hostingview1_.hostedGraph = graph1;
    hostingview2_.hostedGraph = graph2;
    hostingview3_.hostedGraph = graph3;
    
    CPTXYAxisSet* set1;
    CPTXYAxisSet* set2;
    CPTXYAxisSet* set3;
    
    [self configureGraph:(graph1) ];
    [self configureGraph:(graph2) ];
    [self configureGraph:(graph3) ];
    
    [self configureAxes:set1 field:(graph1)];
    [self configureAxes:set2 field:(graph2)];
    [self configureAxes:set3 field:(graph3)];
    
    
}

-(void)configureGraph:( CPTGraph *) graph
{
    // 1 - Create the graph
    NSString *title;
    CPTScatterPlot *plot = [[CPTScatterPlot alloc] init];

    CPTScatterPlot *high = [[CPTScatterPlot alloc] init];
    
    
    if ([graph.identifier isEqual: @"T4"])
    {
        
        graph = [[CPTXYGraph alloc] initWithFrame:self.hostingview1.bounds];
        [graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];//kCPTSlateTheme
        self.hostingview1.hostedGraph = graph;
        title = @"T4 Values";
        plot.identifier = @"T4";
        high.identifier = @"T4h";
        high.areaBaseValue = CPTDecimalFromDouble(45);
        
    }
    
    else if ([graph.identifier isEqual: @"T3"])
    {
        graph = [[CPTXYGraph alloc] initWithFrame:self.hostingview2.bounds];
        [graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];//kCPTSlateTheme
        self.hostingview2.hostedGraph = graph;
        title = @"T3 Values";
           plot.identifier = @"T3";
        high.identifier = @"T3h";
        high.areaBaseValue = CPTDecimalFromDouble(0.75);
        
    }
    
    else
    {
        graph = [[CPTXYGraph alloc] initWithFrame:self.hostingview3.bounds];
        [graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];//kCPTSlateTheme
        self.hostingview3.hostedGraph = graph;
        title = @"TSH Values";
           plot.identifier = @"TSH";
        high.identifier = @"TSHh";
        high.areaBaseValue = CPTDecimalFromDouble(0.3);
    }
    
    // 2 - Set graph title
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

    CPTColor *Color = [CPTColor blueColor];
    CPTColor *green = [CPTColor grayColor];
    // Creates the blue lines for line graph
    plot.dataSource = self;
    high.dataSource = self;
    
    [graph addPlot:high toPlotSpace:plotSpace];
    high.areaFill = [CPTFill fillWithColor:green];
    [graph addPlot:plot toPlotSpace:plotSpace];
    
    [plotSpace scaleToFitPlots:[NSArray arrayWithObjects:plot, nil]];
    
    CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
    [xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];
    plotSpace.xRange = xRange;
    CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
    [yRange expandRangeByFactor:CPTDecimalFromCGFloat(1.2f)];
    plotSpace.yRange = yRange;
    
    // 4 - Create styles and symbols
    CPTMutableLineStyle *LineStyle = [plot.dataLineStyle mutableCopy];
    LineStyle.lineWidth = 1.5;
    LineStyle.lineColor = Color;
    plot.dataLineStyle = LineStyle;
    CPTMutableLineStyle *SymbolLineStyle = [CPTMutableLineStyle lineStyle];
    SymbolLineStyle.lineColor = Color;
    CPTPlotSymbol *Symbol = [CPTPlotSymbol ellipsePlotSymbol];
    Symbol.fill = [CPTFill fillWithColor:Color];
    Symbol.lineStyle = SymbolLineStyle;
    Symbol.size = CGSizeMake(2.0f, 2.0f);
    plot.plotSymbol = Symbol;
}

-(void)configureAxes:(CPTXYAxisSet *)axisSet field:(CPTGraph *)graph
{
    NSNumber* min;
    if ([graph.identifier isEqual: @"T4"])
    {
        NSLog(@"h");
        min = [_T4Values valueForKeyPath:@"@min.self"];
        axisSet = (CPTXYAxisSet *) self.hostingview1.hostedGraph.axisSet;
    }
    
    if ([graph.identifier isEqual: @"T3"])
    {
        NSLog(@"h");
        min = [_T3Values valueForKeyPath:@"@min.self"];
        axisSet = (CPTXYAxisSet *) self.hostingview2.hostedGraph.axisSet;
    }
    
    if ([graph.identifier isEqual: @"TSH"])
    {
        NSLog(@"h");
        min = [_TSHValues valueForKeyPath:@"@min.self"];
        axisSet = (CPTXYAxisSet *) self.hostingview3.hostedGraph.axisSet;
    }

    double newNumber = (min.doubleValue*.9999);
    axisSet.xAxis.orthogonalCoordinateDecimal =CPTDecimalFromDouble(newNumber);

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
    x.majorGridLineStyle = gridLineStyle;
    x.majorIntervalLength = CPTDecimalFromInteger(1);
    
    CGFloat dateCount = _hourinterval;
    NSMutableSet *xLabels = [NSMutableSet setWithCapacity:dateCount];
    NSMutableSet *xLocations = [NSMutableSet setWithCapacity:dateCount];
    for (int i = 0; i< _hourinterval; i+=24) {
        NSString *numberHour = [NSString stringWithFormat:@"%d", i];
        CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:numberHour textStyle:x.labelTextStyle];
        CGFloat location = i;
        label.tickLocation = CPTDecimalFromCGFloat(location);
        label.offset = x.majorTickLength;
        if (label) {
            [xLabels addObject:label];
            [xLocations addObject:[NSNumber numberWithFloat:location]];
        }
    }
    //
    x.axisLabels = xLabels;
    x.majorTickLocations = xLocations;
    x.labelingPolicy        = CPTAxisLabelingPolicyNone;
    
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
}

#pragma mark - CPTPlotDataSource methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plotnumberofRecords
{
    return _hourinterval;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx
{
    
    switch (fieldEnum) {
        case CPTScatterPlotFieldX:
            //place x data
            return [NSNumber numberWithInteger:idx];
            
        case CPTScatterPlotFieldY:
        {
            if ([plot.identifier  isEqual: @"T3"])
            {
                //place y data
                return [self.T3Values objectAtIndex:idx];
                break;
            }
            
            if ([plot.identifier isEqual: @"T4"])
            {
                //place y data
                return [self.T4Values objectAtIndex:idx];
                break;
            }
            if ([plot.identifier isEqual: @"TSH"])
            {
                //place y data
                return [self.TSHValues objectAtIndex:idx];
                break;
            }
            
            if ([plot.identifier  isEqual: @"T3h"])
            {
                //place y data
                return [NSNumber numberWithDouble:1.8];
                break;
            }
            
            if ([plot.identifier isEqual: @"T4h"])
            {
                //place y data
                return [NSNumber numberWithDouble:120];
                break;
            }
            
            if ([plot.identifier isEqual: @"TSHh"])
            {
                //place y data
                return [NSNumber numberWithDouble:4.7];
                break;
            }
        }
    }
    return [NSDecimalNumber zero];
    
}

-(void)addConstraints:(CPTXYGraph *) graph field: (CPTRangePlot *) range
{
    
    
}

@end









 /*
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

//@end
