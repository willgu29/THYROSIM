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

@interface RunSimulationViewController ()

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

-(IBAction)runSimulation:(UIButton *)sender
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    PageOneInputs *pageOneData = delegate.dataObject.pageOneData;
    PageTwoInputs *pageTwoData = delegate.dataObject.pageTwoData;
    
    [pageOneData logAllData];
    [pageTwoData logAllData];
    
    NSArray *pageTwoArray = delegate.dataObject.pageTwoData.filledArray;
    
    MathComputations *myMathObject = [[MathComputations alloc] init];
    NSInteger myDividedNumber = [myMathObject divide:10];
    NSInteger myNumber = [myMathObject add:2 numberTwo:3];
    
    NSLog(@"%d", 10);
    NSLog(@"%f", 10.111);
    NSLog(@"%d",myMathObject.myNumber);
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
