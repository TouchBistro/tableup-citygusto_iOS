//
//  CGMoreViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGMoreViewController.h"
#import "CGRestaurantParameter.h"
#import "CGNewRestaurantsListViewController.h"
#import "CGLoginViewController.h"
#import "CGMyRestaurantFavoriteListViewController.h"
#import "CGAppDelegate.h"
#import <RestKit/RestKit.h>

@interface CGMoreViewController ()

@end

@implementation CGMoreViewController

- (void)viewDidLoad
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityView.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: self.activityView];
    
    if (indexPath.row == 1){
        [self.activityView startAnimating];
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/new/native/restaurants"
                                               parameters:[[CGRestaurantParameter shared] buildParameterMap]
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          self.restaurants = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                          [self performSegueWithIdentifier:@"newRestaurantsSegue" sender:self];
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
    }else if (indexPath.row == 0){
        if ([CGRestaurantParameter shared].loggedInUser){
            [self.activityView startAnimating];
            [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurantFavoriteLists"
                                                   parameters:[[CGRestaurantParameter shared] buildParameterMap]
                                                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                          if (mappingResult){
                                                              self.restaurants = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                              [self performSegueWithIdentifier:@"newRestaurantsSegue" sender:self];
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
        }else{
//            CGAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
//            if (appDelegate.session.isOpen){
                
//            }
            
            [self performSegueWithIdentifier:@"loginSegue" sender:self];
        }
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"newRestaurantsSegue"]){
        CGNewRestaurantsListViewController *newRestaurantsController = [segue destinationViewController];
        newRestaurantsController.restaurants = self.restaurants;
    }else  if ([[segue identifier] isEqualToString:@"restaurantFavoriteListSegue"]){
        CGMyRestaurantFavoriteListViewController *favRestaurantListController = [segue destinationViewController];
        favRestaurantListController.restaurantFavoriteLists = self.restaurantFavoriteLists;
    }else if ([[segue identifier] isEqualToString:@"loginSegue"]){
        UINavigationController *navController = [segue destinationViewController];
        
        if (navController != nil){
            CGLoginViewController *locationController = (CGLoginViewController *)navController.topViewController;
            locationController.delegate = self;
        }
    }
}


-(void) loginSuccessful{
    [self.activityView startAnimating];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[CGRestaurantParameter shared].loggedInUser.username forKey:@"username"];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurantFavoriteLists"
                                           parameters:params
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      self.restaurantFavoriteLists = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                      [self performSegueWithIdentifier:@"restaurantFavoriteListSegue" sender:self];
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
                                                  
                                                  [self.activityView stopAnimating];
                                              }];
}

@end
