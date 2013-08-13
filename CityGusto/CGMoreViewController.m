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
#import "MBProgressHud.h"
#import <RestKit/RestKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface CGMoreViewController ()

@end

@implementation CGMoreViewController

- (void)viewDidLoad
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    CGAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (!appDelegate.session.isOpen) {
        appDelegate.session = [[FBSession alloc] init];
        
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
            [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState status,
                                                             NSError *error) {
                FBSession.activeSession = session;
            }];
        }
    }
    
    [[CGRestaurantParameter shared] getCurrentLocation];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: self.activityView];
    
    if (indexPath.row == 0){
        [self.tabBarController setSelectedIndex:1];
    }else if (indexPath.row == 1){
        [self.tabBarController setSelectedIndex:2];
    }else if (indexPath.row == 2){
        [self.tabBarController setSelectedIndex:3];
    }else if (indexPath.row == 3){
        [self.tabBarController setSelectedIndex:4];
    }else if (indexPath.row == 5){
        [self startSpinner];
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:[[NSNumber alloc] initWithInt:0] forKey:@"offset"];
        [params setObject:[[NSNumber alloc] initWithInt:20] forKey:@"max"];
        [params setObject:@"true" forKey:@"reduced"];
        
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/new/native/restaurants"
                                               parameters:params
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          self.restaurants = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                          [self performSegueWithIdentifier:@"newRestaurantsSegue" sender:self];
                                                      }
                                                      
                                                      [self stopSpinner];
                                                  }
                                                  failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                      message:@"There was an issue"
                                                                                                     delegate:nil
                                                                                            cancelButtonTitle:@"OK"
                                                                                            otherButtonTitles:nil];
                                                      [alert show];
                                                      NSLog(@"Hit error: %@", error);
                                                      
                                                      [self stopSpinner];
                                                  }];
    }else if (indexPath.row == 4){
        if ([CGRestaurantParameter shared].loggedInUser){
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            [params setObject:[CGRestaurantParameter shared].loggedInUser.username forKey:@"username"];
            
            [self startSpinner];
            [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurantFavoriteLists"
                                                   parameters:params
                                                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                          if (mappingResult){
                                                              self.restaurantFavoriteLists = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                              [self performSegueWithIdentifier:@"restaurantFavoriteListSegue" sender:self];
                                                          }
                                                          [self stopSpinner];
                                                      }
                                                      failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                          message:@"There was an issue"
                                                                                                         delegate:nil
                                                                                                cancelButtonTitle:@"OK"
                                                                                                otherButtonTitles:nil];
                                                          [alert show];
                                                          NSLog(@"Hit error: %@", error);
                                                          
                                                          [self stopSpinner];
                                                      }];
        }else{
            CGAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
            if (appDelegate.session.isOpen){
                [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                                   id<FBGraphUser> user,
                                                   NSError *error) {
                     if (!error) {
                         NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
                         [params setObject:user.id forKey:@"fbUid"];
                         
                         [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/facebook/login"
                                                                parameters:params
                                                                   success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                                       if (mappingResult){
                                                                           [CGRestaurantParameter shared].loggedInUser = [[mappingResult array] objectAtIndex:0];
                                                                           [self loginSuccessful];
                                                                       }
                                                                   }
                                                                   failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                                       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                                       message:@"There was an issue"
                                                                                                                      delegate:nil
                                                                                                             cancelButtonTitle:@"OK"
                                                                                                             otherButtonTitles:nil];
                                                                       [alert show];
                                                                   }];
                     }
                 }];
            }else{
                //we need to log in
                [self performSegueWithIdentifier:@"loginSegue" sender:self];
            }
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
            CGLoginViewController *loginController = (CGLoginViewController *)navController.topViewController;
            loginController.delegate = self;
        }
    }
}


-(void) loginSuccessful{
    [self startSpinner];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[CGRestaurantParameter shared].loggedInUser.username forKey:@"username"];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurantFavoriteLists"
                                           parameters:params
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
                                                  
                                                  if (mappingResult){
                                                      self.restaurantFavoriteLists = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                      [self performSegueWithIdentifier:@"restaurantFavoriteListSegue" sender:self];
                                                  }
                                                  
                                                  [self stopSpinner];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:@"There was an issue"
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                                  [alert show];
                                                  
                                                  [self stopSpinner];
                                              }];
}

- (void) startSpinner {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    hud.userInteractionEnabled = YES;
}

- (void) stopSpinner {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
