//
//  PageOneViewController.m
//  THYROSIM
//
//  Created by William Gu on 10/11/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "PageOneViewController.h"
#import "TextInputTableViewCell.h"
#import "SwitchTableViewCell.h"
#import "AppDelegate.h"

@interface PageOneViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tableViewRowNames;
//@property (nonatomic, strong) NSArray *defaultInputValues;

@end

@implementation PageOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createArrayOfNames];
    [self setDefaultInputValues];
}

-(void)createArrayOfNames
{
    _tableViewRowNames = @[@"Change T4 Secretion (0-200%)", @"Change T4 Absorption (0-100%)", @"Change T3 Secretion (0-200%)", @"Change T3 Absorption (0-100%)", @"Recalculate Initial Conditions", @"Simulation time(days)"];
}

-(void)setDefaultInputValues
{
//    _defaultInputValues = @[@"100", @"88", @"100", @"88"];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.dataObject.pageOneData.t4Secretion = 100;
    delegate.dataObject.pageOneData.t4Absorption = 88;
    delegate.dataObject.pageOneData.t3Secretion = 100;
    delegate.dataObject.pageOneData.t3Absorption = 88;
    delegate.dataObject.pageOneData.simulationTimeDays = 5;

    
}

-(void)viewWillAppear:(BOOL)animated
{
//    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableViewRowNames count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //FOR custom cell later
    static NSString *CellIdentifier = @"Cell";
    
    if (indexPath.row == 4)
    {
        SwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SwitchTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.name.text = [_tableViewRowNames objectAtIndex:indexPath.row];
        cell.tag = indexPath.row;
        cell.flipSwitch.tag = indexPath.row;
        
        return cell;
    }
    
    
    TextInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TextInputTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    cell.inputField.delegate = self;
    cell.name.text = [_tableViewRowNames objectAtIndex:indexPath.row];
    cell.textLabel.tag = indexPath.row;
    cell.inputField.tag = indexPath.row;
    cell.tag = indexPath.row;
    if (indexPath.row == 0){
        cell.inputField.text = [NSString stringWithFormat:@"%ld",(long)delegate.dataObject.pageOneData.t4Secretion];

    } else if(indexPath.row == 1) {
        cell.inputField.text = [NSString stringWithFormat:@"%ld",(long)delegate.dataObject.pageOneData.t4Absorption];

    } else if (indexPath.row == 2){
        cell.inputField.text = [NSString stringWithFormat:@"%ld",(long)delegate.dataObject.pageOneData.t3Secretion];

    } else if (indexPath.row == 3) {
        cell.inputField.text = [NSString stringWithFormat:@"%ld",(long)delegate.dataObject.pageOneData.t3Absorption];

    } else if (indexPath.row == 5) {
        cell.inputField.text = [NSString stringWithFormat:@"%ld",(long)delegate.dataObject.pageOneData.simulationTimeDays];

    }
    
    
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"Began edit");
    textField.KeyboardType = UIKeyboardTypePhonePad;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"End edit");
    [self saveDataWithTextField:textField];
}

-(void)saveDataWithTextField:(UITextField *)textField
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSInteger row = textField.tag;
    if (row == 0)
    {
        [delegate.dataObject.pageOneData setT4Secretion:textField.text.integerValue];
    }
    else if (row == 1)
    {
        [delegate.dataObject.pageOneData setT4Absorption:textField.text.integerValue];
    }
    else if (row == 2)
    {
        [delegate.dataObject.pageOneData setT3Secretion:textField.text.integerValue];
    }
    else if (row == 3)
    {
        [delegate.dataObject.pageOneData setT3Absorption:textField.text.integerValue];
    }
    else if (row == 4)
    {
        //refer to switch cell
    }
    else if (row == 5)
    {
        [delegate.dataObject.pageOneData setSimulationTimeDays:textField.text.integerValue];
    }
    else if (row == 6)
    {
        //color later
    }
    
    
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
