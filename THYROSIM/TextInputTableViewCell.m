//
//  TextInputTableViewCell.m
//  THYROSIM
//
//  Created by William Gu on 10/11/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "TextInputTableViewCell.h"
#import "AppDelegate.h"
@implementation TextInputTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignKeyboard) name:@"Resign Keyboards" object:nil];
        
    }
    return self;
}


-(void)resignKeyboard
{
    NSLog(@"Resign keyboard");
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
//    if ([_inputField isFirstResponder])
//    {
//        [_inputField resignFirstResponder];
//    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resignKeyboard];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    NSLog(@"Began edit");
//    _inputField.KeyboardType = UIKeyboardTypePhonePad;
//    
//}
//
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    //SAVE DATA
//    NSLog(@"End edit");
//}
//
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    return YES;
//}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
