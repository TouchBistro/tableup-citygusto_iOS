//
//  CGFoodTruckOptionsViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 5/22/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "ActionSheetPicker.h"
#import "CGFoodTruckOptionsViewController.h"
#import "CGRestaurantParameter.h"
#import "MBProgressHud.h"
#import <QuartzCore/QuartzCore.h>
#import <RestKit/RestKit.h>

@interface CGFoodTruckOptionsViewController ()

@end

@implementation CGFoodTruckOptionsViewController

@synthesize scroller;
@synthesize sortLabel;
@synthesize sortIndex;

@synthesize locationButton;

- (void)viewDidLayoutSubviews {
    self.scroller.delegate = self;
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 530)];
    
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = self.headerView.bounds;
//    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:173.0f/255.0f green:98.0f/255.0f blue:137.0f/255.0f alpha:1.0f].CGColor, (id)[UIColor colorWithRed:200.0f/255.0f green:150.0f/255.0f blue:176.0f/255.0f alpha:1.0f].CGColor, nil];
//    [self.headerView.layer insertSublayer:gradient atIndex:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: self.activityView];
    
    CGRestaurantParameter *params = [CGRestaurantParameter shared];
    
    if (params){
        if (params.foodTruckSortOrder){
            if ([params.foodTruckSortOrder isEqualToString:@"distance"]){
                sortLabel.text = @"Distance";
            }else if ([params.foodTruckSortOrder isEqualToString:@"az"]){
                sortLabel.text = @"Name Asc";
            }else if ([params.foodTruckSortOrder isEqualToString:@"za"]){
                sortLabel.text = @"Name Desc";
            }else if ([params.foodTruckSortOrder isEqualToString: @"rating-h"]){
                sortLabel.text = @"Rating";
            }
        }else{
            sortLabel.text = @"Distance";
        }
        
        if (params.foodTruckOpenFilter == YES){
            [self.openSwitch setOn:YES];
        }else{
            [self.openSwitch setOn:NO];
        }
    }
    
    [locationButton setTitle:[CGRestaurantParameter shared].getLocationName forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)changeSort:(id)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"Change Sort" rows:[NSArray arrayWithObjects: @"Distance", @"Name Asc", @"Name Desc", @"Rating", @"Price", nil] initialSelection:self.sortIndex target:self successAction:@selector(sortWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sortWasSelected:(NSNumber *)selectedIndex element:(id)element {
    self.sortIndex = [selectedIndex intValue];
    
    if (self.sortIndex == 0){
        self.sortLabel.text = @"Distance";
        [CGRestaurantParameter shared].foodTruckSortOrder = @"distance";
    }else if (self.sortIndex == 1){
        self.sortLabel.text = @"Name Asc";
        [CGRestaurantParameter shared].foodTruckSortOrder = @"az";
    }else if (self.sortIndex == 2){
        self.sortLabel.text = @"Name Desc";
        [CGRestaurantParameter shared].foodTruckSortOrder = @"za";
    }else if (self.sortIndex == 3){
        self.sortLabel.text = @"Rating";
        [CGRestaurantParameter shared].foodTruckSortOrder = @"rating-h";
    }else if (self.sortIndex == 4){
        self.sortLabel.text = @"Price";
        [CGRestaurantParameter shared].foodTruckSortOrder = @"price-h";
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"foodTruckLocationSegue"]){
        UINavigationController *navController = [segue destinationViewController];
        
        if (navController != nil){
            CGLocationViewController *locationController = (CGLocationViewController *)navController.topViewController;
            locationController.delegate = self;
        }    
    }
}

-(void) locationChanged{
    [locationButton setTitle:[CGRestaurantParameter shared].getLocationName forState:UIControlStateNormal];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/foodtrucks/cuisines"
                                           parameters:[[CGRestaurantParameter shared] buildFoodTruckParameterMap]
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      [[CGRestaurantParameter shared].foodTruckCuisinesForSelectedLocation removeAllObjects];
                                                      [[CGRestaurantParameter shared].foodTruckCuisinesForSelectedLocation addObjectsFromArray:[[mappingResult dictionary] objectForKey:@"cuisines"]];
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

- (IBAction)search:(id)sender {
    CGRestaurantParameter *params = [CGRestaurantParameter shared];
    
    if (self.openSwitch.on){
        params.foodTruckOpenFilter = YES;
    }else{
        params.foodTruckOpenFilter = NO;
    }
    
    params.offset = 0;
    
    NSMutableDictionary *paramsDictionary = [[CGRestaurantParameter shared] buildFoodTruckParameterMap];
    [paramsDictionary setObject:@"true" forKey:@"reduced"];
    
    [self startSpinner];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/foodtrucks"
                                           parameters:paramsDictionary
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  [self stopSpinner];

                                                  [self.delegate updateFoodTrucks:[mappingResult array]];
                                                  [self dismissViewControllerAnimated:YES completion:nil];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  [self stopSpinner];

                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:@"There was an issue"
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                                  [alert show];
                                                  NSLog(@"Hit error: %@", error);
                                              }];
}

- (IBAction)clearAll:(id)sender{
    [[CGRestaurantParameter shared].foodTruckCuisines removeAllObjects];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cleared"
                                                    message:@"Cuisines cleared."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
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
