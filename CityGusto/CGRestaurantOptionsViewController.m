//
//  CGRestaurantOptionsViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/25/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurantOptionsViewController.h"
#import "CGRestaurantParameter.h"
#import "CGCuisineViewController.h"
#import "ActionSheetPicker.h"
#import "CGLocationViewController.h"
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
#import <RestKit/RestKit.h>


@interface CGRestaurantOptionsViewController ()

@end

@implementation CGRestaurantOptionsViewController

@synthesize scroller;

@synthesize headerView;
@synthesize sortLabel;

@synthesize deliversSwitch;
@synthesize kitchenSwitch;

@synthesize searchButton;
@synthesize locationButton;

@synthesize cuisinesButton;
@synthesize featureButton;
@synthesize clearAllButton;
@synthesize changeSortButton;

@synthesize delegate = _delegate;
@synthesize activityView;
@synthesize sortIndex;

- (void)viewDidLoad
{
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: self.activityView];
    
    self.navItem.title = [CGRestaurantParameter shared].getLocationName;
    
    CGRestaurantParameter *params = [CGRestaurantParameter shared];
    
    if (params){
        if (params.sortOrder){
            if ([params.sortOrder isEqualToString:@"distance"]){
                sortLabel.text = @"Distance";
            }else if ([params.sortOrder isEqualToString:@"az"]){
                sortLabel.text = @"Name Asc";
            }else if ([params.sortOrder isEqualToString:@"za"]){
                sortLabel.text = @"Name Desc";
            }else if ([params.sortOrder isEqualToString: @"rating-h"]){
                sortLabel.text = @"Rating";
            }else if ([params.sortOrder isEqualToString:@"price-h"]){
                sortLabel.text = @"Price";
            }
        }else{
            sortLabel.text = @"Distance";
        }
        
        if (params.deliveryFilter == YES){
            [self.deliversSwitch setOn:YES];
        }else{
            [self.deliversSwitch setOn:NO];
        }
        
        if (params.kitchenOpenFilter == YES){
            [self.kitchenSwitch setOn:YES];
        }else{
            [self.kitchenSwitch setOn:NO];
        }
    }
    
    [locationButton setTitle:[CGRestaurantParameter shared].getLocationName forState:UIControlStateNormal];
    
    
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = self.headerView.bounds;
//    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:137.0f/255.0f green:173.0f/255.0f blue:98.0f/255.0f alpha:1.0f].CGColor, (id)[UIColor colorWithRed:176.0f/255.0f green:200.0f/255.0f blue:150.0f/255.0f alpha:1.0f].CGColor, nil];
    
//    [self.headerView.layer insertSublayer:gradient atIndex:[self.headerView.layer.sublayers count] - 1];
    
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    self.scroller.delegate = self;
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 800)];
    
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = self.headerView.bounds;
//    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:137.0f/255.0f green:173.0f/255.0f blue:98.0f/255.0f alpha:1.0f].CGColor, (id)[UIColor colorWithRed:176.0f/255.0f green:200.0f/255.0f blue:150.0f/255.0f alpha:1.0f].CGColor, nil];
    
//    [self.headerView.layer insertSublayer:gradient atIndex:[self.headerView.layer.sublayers count] - 1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)changeSort:(id)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"Change Sort" rows:[NSArray arrayWithObjects: @"Distance", @"Name Asc", @"Name Desc", @"Rating", @"Price", nil] initialSelection:self.sortIndex target:self successAction:@selector(sortWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
}

- (IBAction)locationChange:(id)sender {
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clearAll:(id)sender {
    [[CGRestaurantParameter shared].cuisines removeAllObjects];
    [[CGRestaurantParameter shared].features removeAllObjects];
    [[CGRestaurantParameter shared] fetchFeatures];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cleared"
                                                    message:@"Cuisines and Features cleared."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)sortWasSelected:(NSNumber *)selectedIndex element:(id)element {
    self.sortIndex = [selectedIndex intValue];
    
    if (self.sortIndex == 0){
        self.sortLabel.text = @"Distance";
        [CGRestaurantParameter shared].sortOrder = @"distance";
    }else if (self.sortIndex == 1){
        self.sortLabel.text = @"Name Asc";
        [CGRestaurantParameter shared].sortOrder = @"az";
    }else if (self.sortIndex == 2){
        self.sortLabel.text = @"Name Desc";
        [CGRestaurantParameter shared].sortOrder = @"za";
    }else if (self.sortIndex == 3){
        self.sortLabel.text = @"Rating";
        [CGRestaurantParameter shared].sortOrder = @"rating-h";
    }else if (self.sortIndex == 4){
        self.sortLabel.text = @"Price";
        [CGRestaurantParameter shared].sortOrder = @"price-h";
    }
}

- (IBAction)search:(id)sender {
    CGRestaurantParameter *params = [CGRestaurantParameter shared];
    
    if (self.kitchenSwitch.on){
        params.kitchenOpenFilter = YES;
    }else{
        params.kitchenOpenFilter = NO;
    }
    
    if (self.deliversSwitch.on){
        params.deliveryFilter = YES;
    }else{
        params.deliveryFilter = NO;
    }
    params.offset = 0;
    
    NSMutableDictionary *paramsDictionary = [[CGRestaurantParameter shared] buildParameterMap];
    [paramsDictionary setObject:@"true" forKey:@"reduced"];
    
    [self startSpinner];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurants"
                                           parameters:paramsDictionary
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  [self stopSpinner];
                                                  [self.delegate updateRestaurants:[mappingResult array]];
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
                                                  
                                                  [self stopSpinner];
                                              }];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"locationSegue"]){
        UINavigationController *navController = [segue destinationViewController];
        
        if (navController != nil){
            CGLocationViewController *locationController = (CGLocationViewController *)navController.topViewController;
            locationController.delegate = self;
        }
    }
}

-(void) locationChanged{
    [locationButton setTitle:[CGRestaurantParameter shared].getLocationName forState:UIControlStateNormal];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/cuisines"
                                           parameters:[[CGRestaurantParameter shared] buildParameterMap]
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      [[CGRestaurantParameter shared].cuisinesForSelectedLocation removeAllObjects];
                                                      [[CGRestaurantParameter shared].featuresForSelectedLocationAndCuisines removeAllObjects];
                                                      
                                                      [[CGRestaurantParameter shared].cuisinesForSelectedLocation addObjectsFromArray:[[mappingResult dictionary] objectForKey:@"cuisines"]];
                                                      [[CGRestaurantParameter shared].featuresForSelectedLocationAndCuisines addObjectsFromArray:[[mappingResult dictionary] objectForKey:@"features"]];
                                                  }
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:@"There was an issue getting cuisines"
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                                  [alert show];
                                                  NSLog(@"Hit error: %@", error);
                                              }];
}

- (void) startSpinner {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    hud.userInteractionEnabled = NO;
}

- (void) stopSpinner {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
