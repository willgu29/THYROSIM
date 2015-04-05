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
#import "PageTwoViewController.h"
#import "QuickStartViewController.h"

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
        
        
        _T4_1 = [[UITextField alloc]initWithFrame:CGRectMake(30, 175, 100, 20)];
        [_T4_1 setBorderStyle:UITextBorderStyleRoundedRect];
        _T4_1.text = @"Run 1";
        [_T4_1 sizeToFit ];
        _T4_1.layer.zPosition = 1;
        [self.view addSubview:_T4_1];
        
        _T4_2 = [[UITextField alloc]initWithFrame:CGRectMake(210, 175, 100, 20)];
        [_T4_2 setBorderStyle:UITextBorderStyleRoundedRect];
        _T4_2.text = @"Run 2";
        _T4_2.layer.zPosition = 1;
        [_T4_2 sizeToFit ];
        [self.view addSubview:_T4_2];
        
        _T3_1 = [[UITextField alloc]initWithFrame:CGRectMake(30, 325, 100, 20)];
        [_T3_1 setBorderStyle:UITextBorderStyleRoundedRect];
        _T3_1.text = @"Run 1";
        _T3_1.layer.zPosition = 1;
        [_T3_1 sizeToFit ];
        [self.view addSubview:_T3_1];
        
        _T3_2 = [[UITextField alloc]initWithFrame:CGRectMake(210, 325, 100, 20)];
        [_T3_2 setBorderStyle:UITextBorderStyleRoundedRect];
        _T3_2.text = @"Run 2";
        _T3_2.layer.zPosition = 1;
        [_T3_2 sizeToFit ];
        [self.view addSubview:_T3_2];
        
        _TSH_1 = [[UITextField alloc]initWithFrame:CGRectMake(30, 475, 100, 20)];
        [_TSH_1 setBorderStyle:UITextBorderStyleRoundedRect];
        _TSH_1.text = @"Run 1";
        _TSH_1.layer.zPosition = 1;
        [_TSH_1 sizeToFit ];
        [self.view addSubview:_TSH_1];
        
        _TSH_2 = [[UITextField alloc]initWithFrame:CGRectMake(210, 475, 100, 20)];
        [_TSH_2 setBorderStyle:UITextBorderStyleRoundedRect];
        _TSH_2.text = @"Run 2";
        _TSH_2.layer.zPosition = 1;
        [_TSH_2 sizeToFit ];
        [self.view addSubview:_TSH_2];
    
    }
    return self;
}



-(IBAction)backButton:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
 
    //TODO:
    //Make this switch back to initial tab
}

-(IBAction)run2:(UIButton *)sender
{
    PageTwoViewController *pagetwo = [[PageTwoViewController alloc] init];
    [self presentViewController:pagetwo animated:YES completion:nil];
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
    _graph1  = [[CPTXYGraph alloc] initWithFrame:hostingview1_.bounds];
    _graph1.identifier = @"T4";
    _graph2  = [[CPTXYGraph alloc] initWithFrame:hostingview2_.bounds];
    _graph2.identifier = @"T3";
    _graph3  = [[CPTXYGraph alloc] initWithFrame:hostingview3_.bounds];
    _graph3.identifier = @"TSH";
    hostingview1_.hostedGraph = _graph1;
    hostingview2_.hostedGraph = _graph2;
    hostingview3_.hostedGraph = _graph3;
    CPTXYAxisSet* set1;
    CPTXYAxisSet* set2;
    CPTXYAxisSet* set3;
    [self configureGraph:(_graph1) ];
    [self configureGraph:(_graph2) ];
    [self configureGraph:(_graph3) ];
    [self configureAxes:set1 field:(_graph1)];
    [self configureAxes:set2 field:(_graph2)];
    [self configureAxes:set3 field:(_graph3)];
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
    
    
    plot.delegate = self;
    
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
    y.titleTextStyle = axisTitleStyle;
    y.titleOffset = -30.0f;
    y.axisLineStyle = axisLineStyle;
    y.majorGridLineStyle = gridLineStyle;
    y.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
    y.labelTextStyle = axisTextStyle;
    y.labelOffset = 200.0f;
    y.majorTickLineStyle = axisLineStyle;
    y.majorTickLength = 4.0f;
    y.minorTickLength = 2.0f;
    y.tickDirection = CPTSignPositive;
    
    if ([graph.identifier isEqual: @"T4"])
    {
    
        y.title = @"T4 (μg/L)";
    }
    
    if ([graph.identifier isEqual: @"T3"])
    {
       
        y.title = @"T3 (μg/L)";
    }
    
    if ([graph.identifier isEqual: @"TSH"])
    {
        y.title = @"TSH (mU/L)";
    }

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

#pragma mark -
#pragma mark CPTScatterPlot delegate method


- (void)scatterPlot:(CPTScatterPlot *)plot plotSymbolWasSelectedAtRecordIndex:(NSUInteger)index
{

    if ([plot.identifier isEqual:@"T4"])
    {
        _touchPlot1Selected = YES;
        _index1selected = index;
        
        NSArray *toadd = @[[NSNumber numberWithFloat:index], [self.T4Values objectAtIndex:index] ];
        NSString *string = [NSString stringWithFormat:@"(%@, %@)", toadd[0], toadd[1]];
        _T4_1.text = string;
        [_T4_1 sizeToFit];
        
    }
    if ([plot.identifier isEqual:@"T3"])
    {
        _touchPlot2Selected = YES;
        _index2selected = index;
        NSArray *toadd = @[[NSNumber numberWithFloat:index], [self.T3Values objectAtIndex:index] ];
        NSString *string = [NSString stringWithFormat:@"(%@, %@)", toadd[0], toadd[1]];
        _T3_1.text = string;
        [_T3_1 sizeToFit];
    }
    
    if ([plot.identifier isEqual:@"TSH"])
    {
        _touchPlot3Selected = YES;
        _index3selected = index;
        NSArray *toadd = @[[NSNumber numberWithFloat:index], [self.TSHValues objectAtIndex:index] ];
        NSString *string = [NSString stringWithFormat:@"(%@, %@)", toadd[0], toadd[1]];
        _TSH_1.text = string;
        [_TSH_1 sizeToFit];
    }
    
    [plot reloadData];
    
    
}

- (CPTPlotSymbol *)symbolForScatterPlot:(CPTScatterPlot *)plot recordIndex:(NSUInteger)index
{

    CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
    symbolLineStyle.lineColor = [CPTColor blueColor];
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    plotSymbol.lineStyle = symbolLineStyle;
    CPTColor *blue = [CPTColor blueColor];
    CPTColor *green = [CPTColor greenColor];
    
    if ([plot.identifier isEqual:@"T4"] && _touchPlot1Selected == YES && index == _index1selected)
    {
        plotSymbol.symbolType = CPTPlotSymbolTypeDiamond;
        plotSymbol.size = CGSizeMake(12, 12);
        plotSymbol.fill = [CPTFill fillWithColor:green];
        
    }
    
    else if ([plot.identifier isEqual:@"T3"] && _touchPlot2Selected == YES && index == _index2selected)
    {
        plotSymbol.symbolType = CPTPlotSymbolTypeDiamond;
        plotSymbol.size = CGSizeMake(12, 12);
        plotSymbol.fill = [CPTFill fillWithColor:green];
    }
    
 
    
    else if ([plot.identifier isEqual:@"TSH"] && _touchPlot3Selected == YES && index == _index3selected)
    {
        plotSymbol.symbolType = CPTPlotSymbolTypeDiamond;
        plotSymbol.size = CGSizeMake(12, 12);
        plotSymbol.fill = [CPTFill fillWithColor:green];
    }
    
    
    else if ([plot.identifier isEqual:@"T4h"] || [plot.identifier isEqual:@"T3h"] || [plot.identifier isEqual:@"T4h"] )
    {
        plotSymbol.size = CGSizeMake(2.0f, 2.0f);
        plot.plotSymbol = plotSymbol;
        plotSymbol.fill = [CPTFill fillWithColor:blue];
    }
    
    else
    {
        plotSymbol.size = CGSizeMake(2.0f, 2.0f);
        plot.plotSymbol = plotSymbol;
        plotSymbol.fill = [CPTFill fillWithColor:blue];
    }
   
    return plotSymbol;
}

@end