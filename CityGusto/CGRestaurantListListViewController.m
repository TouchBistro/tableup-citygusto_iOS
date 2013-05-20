//
//  CGRestaurantListListViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/5/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurantHomeViewController.h"
#import "CGRestaurantMapViewController.h"
#import "CGRestaurantCell.h"
#import "CGRestaurantListListViewController.h"
#import <RestKit/RestKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CGRestaurantListListViewController ()

@end

@implementation CGRestaurantListListViewController

@synthesize activityView;
@synthesize restaurantList;

-(void)viewDidLayoutSubviews{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.headerView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:173.0f/255.0f green:98.0f/255.0f blue:137.0f/255.0f alpha:1.0f].CGColor, (id)[UIColor colorWithRed:200.0f/255.0f green:150.0f/255.0f blue:176.0f/255.0f alpha:1.0f].CGColor, nil];
    
    [self.headerView.layer insertSublayer:gradient atIndex:0];
    
    self.headerLabel.text = self.restaurantList.name;
}

- (void)viewDidLoad
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    UIImage *headerButtonImage = [UIImage imageNamed:@"headerButton.png"];
    [self.mapButtonItem setBackgroundImage:headerButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.tableView addSubview: activityView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 85)];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [textView setFont:[UIFont boldSystemFontOfSize:11]];
    textView.text = @"Best of Lists Are Based On User Voting.";
    textView.textColor = [UIColor colorWithRed:99.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
    textView.backgroundColor = [UIColor clearColor];
    textView.textAlignment = NSTextAlignmentCenter;
    textView.userInteractionEnabled = NO;
    textView.scrollEnabled = NO;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(10, 35, 300, 44)];
    [button setTitle:@"Vote For This List" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.shadowColor = [UIColor blackColor];
	button.titleLabel.shadowOffset = CGSizeMake(1, 1);
    [button addTarget:self action:@selector(voteOnCityGusto:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
    
    UIImage *voteButtonImage = [UIImage imageNamed:@"buttonBackgroundPink.png"];
    [button setBackgroundImage:voteButtonImage forState:UIControlStateNormal];
    
    [footerView addSubview:textView];
    [footerView addSubview:button];
    
    [self.tableView setTableFooterView:footerView];
    
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
    return self.restaurants.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RestaurantListCell";
    
    CGRestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    CGRestaurant *restaurant = [self.restaurants objectAtIndex:indexPath.row];
    
    if (cell){
        NSString *restaurantName = @"#";
        restaurantName = [restaurantName stringByAppendingString:[@(indexPath.row + 1) stringValue]];
        restaurantName = [restaurantName stringByAppendingString:@") "];
        restaurantName = [restaurantName stringByAppendingString:restaurant.name];
        
        cell.nameLabel.text = restaurantName;
        
        NSURL *url = [NSURL URLWithString:restaurant.primaryPhotoURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        cell.primaryPhotoImage.image = image;
        
        NSString *topList = @"Currently in Top 5 of ";
        topList = [topList stringByAppendingString:[restaurant.numberOfTopFiveLists stringValue]];
        topList = [topList stringByAppendingString:@" Lists"];
        
        NSString *numberOfRatings = [restaurant.numberOfRatings stringValue];
        numberOfRatings = [numberOfRatings stringByAppendingString:@" Ratings"];
        
        cell.ratings.text = numberOfRatings;
        
        if (restaurant.numberOfStars == [NSNumber numberWithInt:1]) {
            [cell.starImages setImage:[UIImage imageNamed:@"stars_1.png"]];
        }else if (restaurant.numberOfStars == [NSNumber numberWithInt:2]) {
            [cell.starImages setImage:[UIImage imageNamed:@"stars_2.png"]];
        }else if (restaurant.numberOfStars == [NSNumber numberWithInt:3]) {
            [cell.starImages setImage:[UIImage imageNamed:@"stars_3.png"]];
        }else if (restaurant.numberOfStars == [NSNumber numberWithInt:4]) {
            [cell.starImages setImage:[UIImage imageNamed:@"stars_4.png"]];
        }else if (restaurant.numberOfStars == [NSNumber numberWithInt:5]) {
            [cell.starImages setImage:[UIImage imageNamed:@"stars_5.png"]];
        }else{
            [cell.starImages setImage:[UIImage imageNamed:@"stars_0.png"]];
        }
        
        if (restaurant.numberOfDollarSigns == [NSNumber numberWithInt:1]){
            [cell.priceImageView setImage:[UIImage imageNamed:@"reviewdollars1.png"]];
        }else if (restaurant.numberOfDollarSigns == [NSNumber numberWithInt:2]){
            [cell.priceImageView setImage:[UIImage imageNamed:@"reviewdollars2.png"]];
        }else if (restaurant.numberOfDollarSigns == [NSNumber numberWithInt:3]){
            [cell.priceImageView setImage:[UIImage imageNamed:@"reviewdollars3.png"]];
        }else if (restaurant.numberOfDollarSigns == [NSNumber numberWithInt:4]){
            [cell.priceImageView setImage:[UIImage imageNamed:@"reviewdollars4.png"]];
        }else if (restaurant.numberOfDollarSigns == [NSNumber numberWithInt:5]){
            [cell.priceImageView setImage:[UIImage imageNamed:@"reviewdollars5.png"]];
        }else{
            [cell.priceImageView setImage:[UIImage imageNamed:@"reviewdollars1.png"]];
        }
        
        //style
//        cell.headerView.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
//        cell.nameLabel.textColor = [UIColor colorWithRed:98.0f/255.0f green:137.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
        
        CALayer *bottomBorder = [CALayer layer];
        
        bottomBorder.frame = CGRectMake(0.0f, 22.0f, cell.headerView.frame.size.width, 1.0f);
        bottomBorder.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f].CGColor;
        
        [cell.headerView.layer addSublayer:bottomBorder];
        
        cell.nameLabel.layer.shadowColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f].CGColor;
        cell.nameLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        
        cell.nameLabel.layer.shadowRadius = 3.0;
        cell.nameLabel.layer.shadowOpacity = 0.5;
        
        cell.topFiveLabel.text = topList;
        
        [cell.primaryPhotoImage.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [cell.primaryPhotoImage.layer setBorderWidth:1.5f];
        [cell.primaryPhotoImage.layer setShadowColor:[UIColor blackColor].CGColor];
        [cell.primaryPhotoImage.layer setShadowOpacity:0.8];
        [cell.primaryPhotoImage.layer setShadowRadius:3.0];
        [cell.primaryPhotoImage.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
        
    }
    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRestaurant *restaurant = [self.restaurants objectAtIndex:indexPath.row];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:restaurant.restaurantId, @"id", nil];
    
    [self.activityView startAnimating];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurants"
                                           parameters:params
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      self.selectedRestaurant = [[mappingResult array] objectAtIndex:0];
                                                      
                                                      [self.activityView stopAnimating];
                                                      [self performSegueWithIdentifier:@"listHomeSegue" sender:self];
                                                  }
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:@"There was an issue"
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                                  [alert show];
                                                  NSLog(@"Hit error: %@", error);
                                              }];
}



-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"listMapSegue"]){
        CGRestaurantMapViewController *mapController = [segue destinationViewController];
        mapController.restaurants = self.restaurants;
    }else if ([[segue identifier] isEqualToString:@"listHomeSegue"]){
        CGRestaurantHomeViewController *homeController = [segue destinationViewController];
        homeController.restaurant = self.selectedRestaurant;
    }
}

- (void) updateRestaurants:(NSArray *)newRestaurants{
    [self.restaurants removeAllObjects];
    [self.restaurants addObjectsFromArray:newRestaurants];
    
    [self.tableView reloadData];
}

- (void) voteOnCityGusto:(id)sender{
    NSString *urlString = @"http://citygusto.com/restaurantListVote/show/id?listId=";
    urlString = [urlString stringByAppendingString:[self.restaurantList.restaurantListId stringValue]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

@end
