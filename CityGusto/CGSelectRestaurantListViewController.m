//
//  CGSelectRestaurantListViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/5/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurantListListViewController.h"
#import "CGRestaurantList.h"
#import "CGSelectRestaurantListViewController.h"
#import "CGRestaurantParameter.h"
#import <RestKit/RestKit.h>

@interface CGSelectRestaurantListViewController ()

@end

@implementation CGSelectRestaurantListViewController

@synthesize restaurantLists;
@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
    }
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: self.activityView];
    
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
    return self.restaurantLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CGRestaurantList *restaurantList = [self.restaurantLists objectAtIndex:indexPath.row];
    
    if (restaurantList){
        cell.textLabel.text = restaurantList.name;
        cell.textLabel.textColor = [UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CGRestaurantList *selectedList = [self.restaurantLists objectAtIndex:indexPath.row];
//    if (selectedList){
//        [self.delegate updateRestaurantList:selectedList selectedIndex:indexPath.row];
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
    self.currentRestaurantList = [self.restaurantLists objectAtIndex:indexPath.row];;
    NSMutableDictionary *params = [[CGRestaurantParameter shared] buildParameterMap];
    [params setObject:self.currentRestaurantList.restaurantListId forKey:@"listId"];
    
    [self.activityView startAnimating];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurants"
                                           parameters:params
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      self.restaurants = [[NSMutableArray alloc] initWithArray:[mappingResult array]];

                                                      [self performSegueWithIdentifier:@"selectListRestaurantListSegue" sender:self];
                                                  }
                                                  [self.activityView stopAnimating];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:@"There was an issue"
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                                  [alert show];
                                                  NSLog(@"Hit error: %@", error);
                                                  
                                                  [self.activityView stopAnimating];
                                              }];
    
    
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"selectListRestaurantListSegue"]){
        CGRestaurantListListViewController *listViewController = [segue destinationViewController];
        listViewController.restaurants = self.restaurants;
        listViewController.restaurantList = self.currentRestaurantList;

        
        
    }
}
@end
