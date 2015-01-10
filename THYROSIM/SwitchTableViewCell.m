//
//  SwitchTableViewCell.m
//  THYROSIM
//
//  Created by William Gu on 10/11/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "SwitchTableViewCell.h"
#import "AppDelegate.h"

@implementation SwitchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)onOff:(UISwitch *)sender
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSLog(@"Value changed!");
    if (sender.tag == 4)
    {
        [delegate.dataObject.pageOneData setRecalculateInitialConditions:sender.on];
    }
    else if (sender.tag == 6)
    {
        //Color for later
    }
}

-(void)resignKeyboard
{
    NSLog(@"Resign keyboard");
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resignKeyboard];
}

@end
