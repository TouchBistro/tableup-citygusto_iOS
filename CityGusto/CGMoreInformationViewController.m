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
    
    NSArray *viewsToRemove = [cell.valueView subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    cell.headerLabel.text = @"";
    cell.valueLabel.text = @"";
    
    CGInformation *info = [self.rows objectAtIndex:indexPath.row];
    
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 165, 180)];
    valueLabel.text = info.value;
    valueLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [valueLabel setFont:[UIFont systemFontOfSize:13]];
    [valueLabel setBackgroundColor:[UIColor clearColor]];
    
    CGSize size = [info.value sizeWithFont:[UIFont systemFontOfSize:13]
                         constrainedToSize:CGSizeMake(194, 2000)
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGInformation *info = [self.rows objectAtIndex:indexPath.row];
    
    CGSize size = [info.value sizeWithFont:[UIFont systemFontOfSize:13]
                         constrainedToSize:CGSizeMake(194, 2000)
                             lineBreakMode:NSLineBreakByWordWrapping];
    
    return tableView.rowHeight + size.height;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
