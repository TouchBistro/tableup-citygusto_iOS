//
//  CGRestaurantTopListViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/28/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGTopListPosition.h"
#import "CGRestaurantTopListViewController.h"

@interface CGRestaurantTopListViewController ()

@end

@implementation CGRestaurantTopListViewController

- (void)viewDidLoad
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    if (self.selectedRestaurant.restaurantListPositions.count == 0){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *noMenuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, 320, 60)];
        noMenuLabel.text = @"There are no lists for this restaurant.";
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
    return self.selectedRestaurant.restaurantListPositions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CGTopListPosition *toplist = [self.selectedRestaurant.restaurantListPositions objectAtIndex:indexPath.row];
    
    NSString *listDetails = @"#";
    listDetails = [listDetails stringByAppendingString:[toplist.position stringValue]];
    listDetails = [listDetails stringByAppendingString:@") "];
    listDetails = [listDetails stringByAppendingString:toplist.listName];
    listDetails = [listDetails stringByAppendingString:@": "];
    
    if (toplist.neighborhoodName){
        listDetails = [listDetails stringByAppendingString:toplist.neighborhoodName];
        listDetails = [listDetails stringByAppendingString:@" - "];
    }
    
    listDetails = [listDetails stringByAppendingString:toplist.cityName];
    
    cell.textLabel.text = listDetails;
    cell.textLabel.textColor = [UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
