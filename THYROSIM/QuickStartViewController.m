//
//  QuickStartViewController.m
//  THYROSIM
//
//  Created by William Gu on 10/11/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "QuickStartViewController.h"

@interface QuickStartViewController ()

@property (weak, nonatomic) IBOutlet UITextView *intro;
@property (weak, nonatomic) IBOutlet UITextView *quickStart;

@end

@implementation QuickStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    
    [self introAddPicture];
    [self quickstartAddPictures];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)introAddPicture
{
    UIImage *diagram = [UIImage imageNamed:@"thyroid_circle.png"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:diagram];
    CGRect aRect = CGRectMake(120, 60, 150, 150);
    [imageView setFrame:aRect];
    
    UIBezierPath *exclusionPath = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(imageView.frame), CGRectGetMinY(imageView.frame), CGRectGetWidth(_intro.frame), CGRectGetHeight(imageView.frame))];
    _intro.textContainer.exclusionPaths = @[exclusionPath];
    
    [_intro addSubview:imageView];
}

-(void)quickstartAddPictures
{
    UIImage *pill = [UIImage imageNamed:@"pill1.png"];
    UIImage *syringe = [UIImage imageNamed:@"syringe1.png"];
    UIImage *infusion = [UIImage imageNamed:@"infusion1.png"];
    UIImage *trash = [UIImage imageNamed:@"trash.png"];
    
    
    CGRect aRect = CGRectMake(90, 140, 20, 20);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:aRect];
    [imageView setImage:pill];

    CGRect aRect1 = CGRectMake(110, 140, 20, 20);
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:aRect1];
    [imageView1 setImage:syringe];

    CGRect aRect2 = CGRectMake(130, 140, 20, 20);
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:aRect2];
    [imageView2 setImage:infusion];

    CGRect aRect3 = CGRectMake(90, 190, 20, 20);
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:aRect3];
    [imageView3 setImage:trash];
    
    

    UIBezierPath *exclusionPath = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(imageView.frame), CGRectGetMinY(imageView.frame), CGRectGetWidth(imageView.frame), CGRectGetHeight(imageView.frame))];
    
    UIBezierPath *exclusionPath1 = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(imageView1.frame), CGRectGetMinY(imageView1.frame), CGRectGetWidth(imageView1.frame), CGRectGetHeight(imageView1.frame))];
    
    UIBezierPath *exclusionPath2 = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(imageView2.frame), CGRectGetMinY(imageView2.frame), CGRectGetWidth(imageView2.frame), CGRectGetHeight(imageView2.frame))];
    
    UIBezierPath *exclusionPath3 = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(imageView3.frame), CGRectGetMinY(imageView3.frame), CGRectGetWidth(imageView3.frame), CGRectGetHeight(imageView3.frame))];

    
    _quickStart.textContainer.exclusionPaths = @[exclusionPath, exclusionPath1, exclusionPath2, exclusionPath3];
    
    [_quickStart addSubview:imageView];
    [_quickStart addSubview:imageView1];
    [_quickStart addSubview:imageView2];
    [_quickStart addSubview:imageView3];
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
