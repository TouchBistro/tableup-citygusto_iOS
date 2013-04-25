//
//  CGEventMoreInformationViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/25/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGInformationCell.h"
#import "CGInformation.h"
#import "CGEventMoreInformationViewController.h"

@interface CGEventMoreInformationViewController ()

@end

@implementation CGEventMoreInformationViewController

- (void)viewDidLoad
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    self.rows = [[NSMutableArray alloc] init];
    if (self.selectedEvent.description){
        [self.rows addObject:[[CGInformation alloc]initWithHeader:@"Description" value:self.selectedEvent.description]];
    }
    
/*    if (self.selectedRestaurant.cuisineNames){
        [self.rows addObject:[[CGInformation alloc]initWithHeader:@"Cuisines" value:self.selectedRestaurant.cuisineNames]];
    }
    
    if (self.selectedRestaurant.featureNames){
        [self.rows addObject:[[CGInformation alloc]initWithHeader:@"Features" value:self.selectedRestaurant.featureNames]];
    }
    
    if (self.selectedRestaurant.price){
        [self.rows addObject:[[CGInformation alloc]initWithHeader:@"Price" value:self.selectedRestaurant.price]];
    }
    
    if (self.selectedRestaurant.ambianceNames){
        [self.rows addObject:[[CGInformation alloc]initWithHeader:@"Ambiance" value:self.selectedRestaurant.ambianceNames]];
    }
    
    if (self.selectedRestaurant.parkingInfo){
        [self.rows addObject:[[CGInformation alloc]initWithHeader:@"Parking" value:self.selectedRestaurant.parkingInfo]];
    }
    
    if (self.selectedRestaurant.delivers){
        [self.rows addObject:[[CGInformation alloc]initWithHeader:@"Delivers" value:self.selectedRestaurant.delivers]];
    }
    
    if (self.selectedRestaurant.creditcardNames){
        [self.rows addObject:[[CGInformation alloc]initWithHeader:@"Credit Card Names" value:self.selectedRestaurant.creditcardNames]];
    }
 
*/
    
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
    return self.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventInfoCell";
    CGInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSArray *viewsToRemove = [cell.valueView subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    cell.headerLabel.text = @"";
    cell.valueLabel.text = @"";
    
    CGInformation *info = [self.rows objectAtIndex:indexPath.row];
    
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 194, 180)];
    valueLabel.text = info.value;
    valueLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [valueLabel setFont:[UIFont systemFontOfSize:13]];
    [valueLabel setBackgroundColor:[UIColor clearColor]];
    
    CGSize size = [info.value sizeWithFont:[UIFont systemFontOfSize:13]
                         constrainedToSize:CGSizeMake(194, 5000.0f)
                             lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect newFrame = valueLabel.frame;
    newFrame.size.height = size.height;
    valueLabel.frame = newFrame;
    valueLabel.numberOfLines = 0;
    [valueLabel sizeToFit];
    [cell.valueView addSubview:valueLabel];
    
    cell.headerLabel.text = info.header;
    
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
