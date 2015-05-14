//
//  InfusionTwoRunTableViewCell.m
//  THYROSIM
//
//  Created by Dylan Hoang on 5/3/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "InfusionTwoRunTableViewCell.h"
#import "AppDelegate.h"
#import "Inputs.h"

@implementation InfusionTwoRunTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
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


-(IBAction)deleteRow:(UIButton *)sender
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.dataObject.pageTwoData.inputArray2 removeObjectAtIndex:self.deleteButton.tag];
    [delegate.dataObject.pageTwoData.filledArray2 removeObjectAtIndex:self.deleteButton.tag];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Reload Table" object:nil];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.KeyboardType = UIKeyboardTypePhonePad;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Move VC" object:nil];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self saveDataForRow:self.deleteButton.tag withTextField:textField];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Revert VC" object:nil];
    
}

-(void)saveDataForRow:(NSInteger)row withTextField:(UITextField *)textField
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    Inputs *inputs = [delegate.dataObject.pageTwoData.filledArray2 objectAtIndex:row];
    [inputs setInputName:self.label.text];
    [inputs setInputID:[self mapLabelText:self.label.text]];
    if (textField.tag == 0)
    {
        [inputs setDoseAmount:textField.text.integerValue];
    }
    else if (textField.tag == 1)
    {
        [inputs setDoseInterval:textField.text.integerValue];
        
    }
    else if (textField.tag == 2)
    {
        [inputs setStartTime:textField.text.integerValue];
        
    }
    else if (textField.tag == 3)
    {
        [inputs setEndTime:textField.text.integerValue];
    }
    
}

-(NSInteger)mapLabelText:(NSString *)stringText
{
    if ([stringText isEqualToString:@"T3-ORAL DOSE"])
    {
        return 1;
    }
    else if ([stringText isEqualToString:@"T4-ORAL DOSE"])
    {
        return 2;
    }
    else if ([stringText isEqualToString:@"T3-IV DOSE"])
    {
        return 3;
    }
    else if ([stringText isEqualToString:@"T4-IV DOSE"])
    {
        return 4;
    }
    else if ([stringText isEqualToString:@"T3 INFUSION"])
    {
        return 5;
    }
    else if ([stringText isEqualToString:@"T4 INFUSION"])
    {
        return 6;
    }
    return -1;
}


@end
