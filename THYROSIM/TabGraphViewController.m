//
//  TabGraphViewController.m
//  THYROSIM
//
//  Created by William Gu on 12/7/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "TabGraphViewController.h"

@interface TabGraphViewController ()

@property (nonatomic, weak) IBOutlet UIButton *backButton;

@end

@implementation TabGraphViewController

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

}

-(void)viewDidAppear:(BOOL)animated
{
    [[self.viewControllers objectAtIndex:0] viewDidAppear:YES];
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