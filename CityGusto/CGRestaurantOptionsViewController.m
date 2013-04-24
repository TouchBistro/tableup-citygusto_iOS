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
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityView.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: self.activityView];
    
    CGRestaurantParameter *params = [CGRestaurantParameter shared];
    
    if (params){
        if (params.sortOrder){
            if (params.sortOrder == @"distance"){
                sortLabel.text = @"Distance";
            }else if (params.sortOrder == @"az"){
                sortLabel.text = @"Name Asc";
            }else if (params.sortOrder == @"za"){
                sortLabel.text = @"Name Desc";
            }else if (params.sortOrder == @"rating-h"){
                sortLabel.text = @"Rating";
            }else if (params.sortOrder == @"price-h"){
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
    
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    self.scroller.delegate = self;
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 800)];
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
    
    NSMutableDictionary *paramsDictionary = [[CGRestaurantParameter shared] buildParameterMap];
    [paramsDictionary setObject:@"true" forKey:@"reduced"];
    
    [self.activityView startAnimating];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurants"
                                           parameters:paramsDictionary
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  [self.activityView stopAnimating];
                                                  [self.delegate updateRestaurants:[mappingResult array]];
                                                  [self dismissViewControllerAnimated:YES completion:nil];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  [self.activityView stopAnimating];
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
}

@end
