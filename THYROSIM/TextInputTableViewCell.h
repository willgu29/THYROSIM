//
//  TextInputTableViewCell.h
//  THYROSIM
//
//  Created by William Gu on 10/11/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TextInputTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UILabel *name;

-(instancetype)init;

@end

