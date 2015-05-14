//
//  InfusionTwoRunTableViewCell.h
//  THYROSIM
//
//  Created by Dylan Hoang on 5/3/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfusionTwoRunTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *inputField1;
@property (weak, nonatomic) IBOutlet UITextField *inputField2;
@property (weak, nonatomic) IBOutlet UITextField *inputField3;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
