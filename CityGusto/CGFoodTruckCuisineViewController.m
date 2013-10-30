//
//  CGFoodTruckCuisineViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 5/22/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//
#import "CGRestaurantParameter.h"
#import "CGCuisine.h"
#import "CGFoodTruckCuisineViewController.h"

@interface CGFoodTruckCuisineViewController ()

@end

@implementation CGFoodTruckCuisineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [CGRestaurantParameter shared].foodTruckCuisinesForSelectedLocation.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FoodTruckCuisineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CGCuisine *cuisine = [[CGRestaurantParameter shared].foodTruckCuisinesForSelectedLocation objectAtIndex:indexPath.row];
    
    if (cuisine){
        cell.textLabel.text = [[[CGRestaurantParameter shared].foodTruckCuisinesForSelectedLocation objectAtIndex:indexPath.row] name];
        cell.textLabel.textColor = [UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    	cell.textLabel.shadowColor = [UIColor whiteColor];
		cell.textLabel.shadowOffset = CGSizeMake(1, 1);
        
        if ([CGRestaurantParameter shared].foodTruckCuisines.count > 0){
            NSUInteger index = [[CGRestaurantParameter shared].foodTruckCuisines indexOfObject:cuisine];
            if (index != NSNotFound) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGCuisine *selectedCuisine = [[CGRestaurantParameter shared].foodTruckCuisinesForSelectedLocation objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [[CGRestaurantParameter shared].foodTruckCuisines addObject:selectedCuisine];
    } else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        [[CGRestaurantParameter shared].foodTruckCuisines removeObject:selectedCuisine];
    }
}

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
