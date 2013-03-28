//
//  CGCuisineViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/27/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurantParameter.h"
#import "CGCuisineViewController.h"
#import "CGCuisine.h"

@interface CGCuisineViewController ()

@end

@implementation CGCuisineViewController

@synthesize cuisines;

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
    return [CGRestaurantParameter shared].allCuisines.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CuisineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CGCuisine *cuisine = [[CGRestaurantParameter shared].allCuisines objectAtIndex:indexPath.row];
    
    if (cuisine){
        cell.textLabel.text = [[[CGRestaurantParameter shared].allCuisines objectAtIndex:indexPath.row] name];
        
        if ([CGRestaurantParameter shared].cuisines.count > 0){
            NSUInteger index = [[CGRestaurantParameter shared].cuisines  indexOfObject:cuisine];
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
    //add to selected cuisines
    CGCuisine *selectedCuisine = [[CGRestaurantParameter shared].allCuisines objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [[CGRestaurantParameter shared].cuisines addObject:selectedCuisine];
    } else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        [[CGRestaurantParameter shared].cuisines removeObject:selectedCuisine];
    }
    
}

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
