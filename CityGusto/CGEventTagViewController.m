//
//  CGEventTagViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGTag.h"
#import "CGRestaurantParameter.h"
#import "CGEventTagViewController.h"

@interface CGEventTagViewController ()

@end

@implementation CGEventTagViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navItem.title = [CGRestaurantParameter shared].getLocationName;
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
    return [[CGRestaurantParameter shared].tagsForSelectedLocationAndCategories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventTagCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CGTag *tag = [[CGRestaurantParameter shared].tagsForSelectedLocationAndCategories objectAtIndex:indexPath.row];
    
    if (tag){
        cell.textLabel.text = tag.name;
        cell.textLabel.textColor = [UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
        
        if ([CGRestaurantParameter shared].tags.count > 0){
            NSUInteger index = [[CGRestaurantParameter shared].tags indexOfObject:tag];
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
    CGTag *tag = [[CGRestaurantParameter shared].tagsForSelectedLocationAndCategories objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [[CGRestaurantParameter shared].tags addObject:tag];
    } else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        [[CGRestaurantParameter shared].tags removeObject:tag];
    }
}

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
