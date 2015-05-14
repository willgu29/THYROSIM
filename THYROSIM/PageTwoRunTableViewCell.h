//
//  PageTwoTableViewCell.h
//  THYROSIM
//
//  Created by William Gu on 10/11/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageTwoRunTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputField1;
@property (weak, nonatomic) IBOutlet UITextField *inputField2;
@property (weak, nonatomic) IBOutlet UITextField *inputField3;
@property (weak, nonatomic) IBOutlet UITextField *inputField4;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UILabel *label;


@end
