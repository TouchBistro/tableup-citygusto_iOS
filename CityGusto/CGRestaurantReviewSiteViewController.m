//
//  CGRestaurantReviewSiteViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/28/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGReviewLink.h"
#import "CGRestaurantReviewSiteViewController.h"

@interface CGRestaurantReviewSiteViewController ()

@end

@implementation CGRestaurantReviewSiteViewController

- (void)viewDidLoad
{
    if (self.selectedRestaurant.reviewLinks.count == 0){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *noMenuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, 320, 60)];
        noMenuLabel.text = @"There are no reviews for this restaurant.";
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
    return self.selectedRestaurant.reviewLinks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SiteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CGReviewLink *reviewLink = [self.selectedRestaurant.reviewLinks objectAtIndex:indexPath.row];
    cell.textLabel.text = reviewLink.text;
    cell.textLabel.textColor = [UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGReviewLink *reviewLink = [self.selectedRestaurant.reviewLinks objectAtIndex:indexPath.row];
    
    if (reviewLink){
        NSString *urlString = @"http://";
    	urlString = [urlString stringByAppendingString:reviewLink.link];
        
        NSURL *url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
