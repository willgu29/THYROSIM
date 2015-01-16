//
//  RunSimulationViewController.m
//  THYROSIM
//
//  Created by William Gu on 10/11/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "RunSimulationViewController.h"
#import "AppDelegate.h"
#import "MathComputations.h"
#import "ScatterPlotViewController.h"
#import "ScatterPlot2ViewController.h"
#import "ScatterPlot3ViewController.h"
#import "TabGraphViewController.h"
#import "ErrorCheck.h"
#import "ErrorEnums.h"

@interface RunSimulationViewController ()

@property (nonatomic, weak) IBOutlet UILabel *errorLabel;
@property (nonatomic, weak) IBOutlet UILabel *errorHolder;

@end

@implementation RunSimulationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    _errorLabel.hidden = YES;
    _errorHolder.hidden = YES;
}

-(IBAction)runSimulation:(UIButton *)sender
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    PageOneInputs *pageOneData = delegate.dataObject.pageOneData;
    PageTwoInputs *pageTwoData = delegate.dataObject.pageTwoData;
    
    [pageOneData logAllData];
    [pageTwoData logAllData];
    
    
    //TODO: Error check here
    ErrorCheck *errorChecker = [[ErrorCheck alloc] init];
    int errorValue = [errorChecker errorCheckAll];
    if (errorValue != ALL_GOOD_PROCEED)
    {
        //DISPLAY ERROR MESSAGE
        _errorLabel.text = [self convertErrorToString:errorValue];
        _errorLabel.hidden = NO;
        _errorHolder.hidden = NO;
        return;
    }
    
    
    
    //TODO: Math computations
    MathComputations *myMathObject = [[MathComputations alloc] init];

    [myMathObject getShitDone];
    
    
    //TODO: Pass in Data Objects for all graphs
    
    
    //Set a timer... if runs for more than 30seconds or so just cancel the operation
    
    ScatterPlotViewController *scatterVC = [[ScatterPlotViewController alloc ]init];
    ScatterPlot2ViewController *scatter2VC = [[ScatterPlot2ViewController alloc ]init];
    ScatterPlot3ViewController *scatter3VC = [[ScatterPlot3ViewController alloc ]init];

    
    scatterVC.T4Values = myMathObject.T4Values;
    scatter2VC.T3Values = myMathObject.T3Values;
    scatter3VC.TSHValues = myMathObject.TSHValues;
    scatterVC.intervalHours = myMathObject.intervalHours;
    scatter2VC.intervalHours = myMathObject.intervalHours;
    scatter3VC.intervalHours = myMathObject.intervalHours;

    
    scatterVC.title = @"T4";
    scatter2VC.title = @"T3";
    scatter3VC.title = @"TSH";
    
    
    
    
    TabGraphViewController *tabGraph = [[TabGraphViewController alloc] init];
    tabGraph.viewControllers = [NSArray arrayWithObjects:scatterVC, scatter2VC, scatter3VC, nil];
    
    [self presentViewController:tabGraph animated:YES completion:nil];
    
   
}

-(NSString *)convertErrorToString:(int) errorValue
{
    
    if (errorValue == PAGE_ONE_SIMULDAYS_ERROR)
    {
        return @"Make sure simulation days in step 1 is greater than zero";
    }
    else if (errorValue == PAGE_ONE_T3A_ERROR)
    {
        return @"Check to make sure T3 Absorption is between 0-100% in step 1";
    }
    else if (errorValue == PAGE_ONE_T3S_ERROR)
    {
        return @"Check to make sure T3 Secretion is between 0-200% in step 1";

    }
    else if (errorValue == PAGE_ONE_T4A_ERROR)
    {
        return @"Check to make sure T4 Absorption is between 0-100% in step 1";

    }
    else if (errorValue == PAGE_ONE_T4S_ERROR)
    {
        return @"Check to make sure T4 Secretion is between 0-200% in step 1";
    }
    else if (errorValue == PAGE_TWO_DOSING_INTERVAL_ERROR)
    {
        return @"Make sure your dosing intervals is positive in step 2";
    }
    else if (errorValue == PAGE_TWO_TIME_ERROR)
    {
        return @"Make sure start and end times are valid in step 2";
    }
    else
    {
        //???
    }
    
    return @"NO ERROR";
}

-(void)createHeadline
{
    self.view.backgroundColor= [UIColor colorWithRed:0.16 green:0.67 blue:0.886 alpha:1];
    //[UIColor colorWithHue:.537728 saturation:.89447 brightness:1 alpha:1];
    
    UIButton *trackView = [[UIButton alloc] initWithFrame:CGRectMake(16, 6, 100, 30)];
    [trackView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIFont *headline = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    [trackView.titleLabel setFont:headline];
    [trackView setTitle:@"TrackView" forState:UIControlStateNormal];
    
    [trackView addTarget:self
                  action:@selector(dismissCurrentViewController)
        forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 20)];
    [userLabel setTextAlignment:NSTextAlignmentRight];
    UIFont *body = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    [userLabel setFont:body];
    userLabel.textColor = [UIColor whiteColor];
    NSString *username = @"WilLGu29";
    userLabel.text = username;
    
    [self.view.window addSubview:userLabel];
    [self.view.window addSubview:trackView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
