//
//  PageTwoViewController.m
//  THYROSIM
//
//  Created by William Gu on 10/11/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "PageTwoViewController.h"
#import "PageTwoTableViewCell.h"
#import "InfusionTableViewCell.h"
#import "AppDelegate.h"
#import "Inputs.h"

@interface PageTwoViewController ()

//@property (strong, nonatomic) NSMutableArray *inputArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation PageTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableData) name:@"Reload Table" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveVC) name:@"Move VC" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(revertVC) name:@"Revert VC" object:nil];

    
//    [self createInputArray];
}


-(void)reloadTableData
{
    [self.tableView reloadData];
}

//-(void)createInputArray
//{
//    _inputArray = [[NSMutableArray alloc] init];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)addInput:(UIButton *)sender
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    //T3
    if (sender.tag == 0)
    {
        [delegate.dataObject.pageTwoData.inputArray addObject:[NSNumber numberWithInt:0]];
    }
    else if (sender.tag == 1)
    {
        [delegate.dataObject.pageTwoData.inputArray addObject:[NSNumber numberWithInt:1]];
    }
    else if (sender.tag == 2)
    {
        [delegate.dataObject.pageTwoData.inputArray addObject:[NSNumber numberWithInt:2]];
    }
    //T4
    else if (sender.tag == 3)
    {
        [delegate.dataObject.pageTwoData.inputArray addObject:[NSNumber numberWithInt:3]];
    }
    else if (sender.tag == 4)
    {
        [delegate.dataObject.pageTwoData.inputArray addObject:[NSNumber numberWithInt:4]];
    }
    else if (sender.tag == 5)
    {
        [delegate.dataObject.pageTwoData.inputArray addObject:[NSNumber numberWithInt:5]];
    }
    Inputs *emptyInput = [[Inputs alloc] init];
    [delegate.dataObject.pageTwoData.filledArray addObject:emptyInput];
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    delegate.dataObject.pageTwoData.inputArray = _inputArray;
    
    
    //TODO: add item to table
    [_tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    return [delegate.dataObject.pageTwoData.inputArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    //FOR custom cell later
//    static NSString *CellIdentifier = @"Cell";
      static NSString *CellIdentifier = @"NOTHING";
//    PageTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ([[delegate.dataObject.pageTwoData.inputArray objectAtIndex:indexPath.row] isEqualToNumber:[NSNumber numberWithInt:2]] || [[delegate.dataObject.pageTwoData.inputArray objectAtIndex:indexPath.row] isEqualToNumber:[NSNumber numberWithInt:5]])
    {
        InfusionTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InfusionTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
//        cell.inputField1.delegate = self;
//        cell.inputField2.delegate = self;
//        cell.inputField3.delegate = self;
        
        
        cell.deleteButton.tag = indexPath.row;
        cell.tag = indexPath.row;
        cell.label.text = [self inputName:[delegate.dataObject.pageTwoData.inputArray objectAtIndex:indexPath.row]];
        
        
        Inputs *inputs = [delegate.dataObject.pageTwoData.filledArray objectAtIndex:indexPath.row];
        
        cell.inputField1.text = [NSString stringWithFormat:@"%d",inputs.doseAmount];
        cell.inputField2.text = [NSString stringWithFormat:@"%d",inputs.startTime];
        cell.inputField3.text = [NSString stringWithFormat:@"%d",inputs.endTime];
        
        return cell;
        
    }
    else
    {
        PageTwoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PageTwoTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
//        cell.inputField1.delegate = self;
//        cell.inputField2.delegate = self;
//        cell.inputField3.delegate = self;
//        cell.inputField4.delegate = self;
        cell.deleteButton.tag = indexPath.row;
        cell.tag = indexPath.row;
        cell.label.text = [self inputName:[delegate.dataObject.pageTwoData.inputArray objectAtIndex:indexPath.row]];
        
        Inputs *inputs = [delegate.dataObject.pageTwoData.filledArray objectAtIndex:indexPath.row];
        
        cell.inputField1.text = [NSString stringWithFormat:@"%d",inputs.doseAmount];
        cell.inputField2.text = [NSString stringWithFormat:@"%d",inputs.doseInterval];
        cell.inputField3.text = [NSString stringWithFormat:@"%d",inputs.startTime];
        cell.inputField4.text = [NSString stringWithFormat:@"%d",inputs.endTime];


        return cell;
    }
    
    
}



-(NSString *)inputName:(NSNumber*)type
{
    NSString *myString = nil;
    if (type == [NSNumber numberWithInt:0])
    {
        myString = @"T3-ORAL DOSE";
    }
    else if (type == [NSNumber numberWithInt:1])
    {
        myString = @"T3-IV DOSE";

    }
    else if (type == [NSNumber numberWithInt:2])
    {
        myString = @"T3 INFUSION";
        
    }
    else if (type == [NSNumber numberWithInt:3])
    {
        myString = @"T4-ORAL DOSE";
        
    }
    else if (type == [NSNumber numberWithInt:4])
    {
        myString = @"T4-IV DOSE";
        
    }
    else if (type == [NSNumber numberWithInt:5])
    {
        myString = @"T4 INFUSION";
        
    }
    
    return myString;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)moveVC
{
    [self.view setFrame:CGRectMake(0, -150, self.view.frame.size.width, self.view.frame.size.height)];
}

-(void)revertVC
{
    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}


@end
