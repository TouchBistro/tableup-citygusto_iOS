//
//  CGMoreInformationViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/28/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGInformation.h"
#import "CGInformationCell.h"
#import "CGMoreInformationViewController.h"

@interface CGMoreInformationViewController ()

@end

@implementation CGMoreInformationViewController

@synthesize selectedRestaurant;
@synthesize rows;

- (void)viewDidLoad
{
    self.rows = [[NSMutableArray alloc] init];
    if (self.selectedRestaurant.about){
        [self.rows addObject:[[CGInformation alloc]initWithHeader:@"About" value:self.selectedRestaurant.about]];
    }
    
    if (self.selectedRestaurant.cuisineNames){
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
    static NSString *CellIdentifier = @"InfoCell";
    CGInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CGInformation *info = [self.rows objectAtIndex:indexPath.row];
    
    cell.headerLabel.text = info.header;
    cell.valueTextView.text = info.value;
    cell.valueTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [cell.valueTextView sizeToFit];
    
//    CGRect frame = cell.valueTextView.frame;
    
//    NSInteger height = cell.valueTextView.contentSize.height;
//    frame.size.height = cell.valueTextView.contentSize.height;
//    cell.valueTextView.frame = frame;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // for the sake of illustration, say your model for this table is just an array of strings you wish to present.
    // it's probably more complex, but the idea is to get the string you want to present for the
    // cell at indexPath
    CGInformation *info = [self.rows objectAtIndex:indexPath.row];
    CGSize size = [info.value sizeWithFont:[UIFont systemFontOfSize:13]
                         constrainedToSize:CGSizeMake(194, 2000)
                             lineBreakMode:NSLineBreakByWordWrapping];
    
    // this is a little funky, because for it to be just right, you should format your prototype
    // cell height to be a good-looking height when your text view has a zero height.
    // the basic idea here is that the cell will get taller as the text does.
    return tableView.rowHeight + size.height;
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
