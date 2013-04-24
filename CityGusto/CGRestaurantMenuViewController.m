//
//  CGRestaurantMenuViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/28/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGMenu.h"
#import "CGRestaurantMenuViewController.h"

@interface CGRestaurantMenuViewController ()

@end

@implementation CGRestaurantMenuViewController

@synthesize selectedRestaurant;

- (void)viewDidLoad
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
    }
    
    if (self.selectedRestaurant.menus.count == 0){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *noMenuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, 320, 60)];
        noMenuLabel.text = @"There are no menus for this restaurant.";
        noMenuLabel.textColor = [UIColor colorWithRed:98.0f/255.0f green:137.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
        noMenuLabel.textAlignment = NSTextAlignmentCenter;
        
        [view addSubview:noMenuLabel];
        [self.view addSubview:view];
        [self.view bringSubviewToFront:view];
    }
    
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
    return selectedRestaurant.menus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CGMenu *menu = [self.selectedRestaurant.menus objectAtIndex:indexPath.row];
    
    cell.textLabel.text = menu.name;
    cell.textLabel.textColor = [UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0f];

    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
