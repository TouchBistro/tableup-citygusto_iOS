//
//  CGEventDateViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurantParameter.h"
#import "CGEventDateViewController.h"
#import "ActionSheetPicker.h"

@interface CGEventDateViewController ()

@end

@implementation CGEventDateViewController

@synthesize dateString;
@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    dateString = [dateFormatter stringFromDate:[CGRestaurantParameter shared].date];
    self.dateLabel.text = dateString;
    
    self.sortIndex = 0;
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TimeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.textColor = [UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
    
    if (indexPath.row == 0){
        cell.textLabel.text = @"Pre-Dawn (12am - 5:59am)";
        NSUInteger index = [[CGRestaurantParameter shared].times indexOfObject:[NSNumber numberWithInt:1]];
        if (index != NSNotFound) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"Morning (6am - 11:59am)";
        
        NSUInteger index = [[CGRestaurantParameter shared].times indexOfObject:[NSNumber numberWithInt:2]];
        if (index != NSNotFound) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"Afternoon (12pm - 5:59pm)";
        
        NSUInteger index = [[CGRestaurantParameter shared].times indexOfObject:[NSNumber numberWithInt:3]];
        if (index != NSNotFound) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else if (indexPath.row == 3){
        cell.textLabel.text = @"Evening (6pm - 11:59pm)";
        
        NSUInteger index = [[CGRestaurantParameter shared].times indexOfObject:[NSNumber numberWithInt:4]];
        if (index != NSNotFound) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0){
        if (cell.accessoryType == UITableViewCellAccessoryNone){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [[CGRestaurantParameter shared].times addObject:[NSNumber numberWithInt:1]];
        } else{
            cell.accessoryType = UITableViewCellAccessoryNone;
            [[CGRestaurantParameter shared].times removeObject:[NSNumber numberWithInt:1]];
        }
    }else if (indexPath.row == 1){
        if (cell.accessoryType == UITableViewCellAccessoryNone){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [[CGRestaurantParameter shared].times addObject:[NSNumber numberWithInt:2]];
        } else{
            cell.accessoryType = UITableViewCellAccessoryNone;
            [[CGRestaurantParameter shared].times removeObject:[NSNumber numberWithInt:2]];
        }
    }else if (indexPath.row == 2){
        if (cell.accessoryType == UITableViewCellAccessoryNone){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [[CGRestaurantParameter shared].times addObject:[NSNumber numberWithInt:3]];
        } else{
            cell.accessoryType = UITableViewCellAccessoryNone;
            [[CGRestaurantParameter shared].times removeObject:[NSNumber numberWithInt:3]];
        }
    }else if (indexPath.row == 3){
        if (cell.accessoryType == UITableViewCellAccessoryNone){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [[CGRestaurantParameter shared].times addObject:[NSNumber numberWithInt:4]];
        } else{
            cell.accessoryType = UITableViewCellAccessoryNone;
            [[CGRestaurantParameter shared].times removeObject:[NSNumber numberWithInt:4]];
        }
    }
    
    
}

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)changeDate:(id)sender {
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    for (int i = 0; i <= 10; i++){
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.day = i;
        
        NSDate *newDate = [calendar dateByAddingComponents:components toDate:[[NSDate alloc] init] options: 0];
        [dates addObject:[dateFormatter stringFromDate:newDate]];
    }
    
    [ActionSheetStringPicker showPickerWithTitle:@"Change Date" rows:dates initialSelection:self.sortIndex target:self successAction:@selector(sortWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
}


- (void)sortWasSelected:(NSNumber *)selectedIndex element:(id)element {
    self.sortIndex = [selectedIndex intValue];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = self.sortIndex;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    [CGRestaurantParameter shared].date = [calendar dateByAddingComponents:components toDate:[[NSDate alloc] init] options: 0];
    
    dateString = [dateFormatter stringFromDate:[CGRestaurantParameter shared].date];
    self.dateLabel.text = dateString;
    
    [self.delegate updateDate:[CGRestaurantParameter shared].date];
}


@end
