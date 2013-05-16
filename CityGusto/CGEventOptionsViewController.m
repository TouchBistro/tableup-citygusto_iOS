//
//  CGEventOptionsViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurantParameter.h"
#import "CGEventOptionsViewController.h"
#import "CGEventDateViewController.h"
#import "ActionSheetPicker.h"
#import <RestKit/RestKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CGEventOptionsViewController ()

@end

@implementation CGEventOptionsViewController

@synthesize activityView;
@synthesize scroller;
@synthesize locationButton;

@synthesize sortLabel;
@synthesize sortIndex;

@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    self.scroller.delegate = self;
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityView.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: self.activityView];
    
    CGRestaurantParameter *params = [CGRestaurantParameter shared];
    
    if (params){
        if (params.eventSortOrder){
            if ([params.eventSortOrder isEqualToString:@"distance"]){
                sortLabel.text = @"Distance";
            }else if ([params.eventSortOrder isEqualToString:@"az"]){
                sortLabel.text = @"Name Asc";
            }else if ([params.eventSortOrder isEqualToString:@"za"]){
                sortLabel.text = @"Name Desc";
            }else if ([params.eventSortOrder isEqualToString:@"rating-h"]){
                sortLabel.text = @"Rating";
            }else if ([params.eventSortOrder isEqualToString: @"price-h"]){
                sortLabel.text = @"Price";
            }
        }else{
            sortLabel.text = @"Distance";
        }
    }
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    self.dateLabel.text = [dateFormatter stringFromDate:[CGRestaurantParameter shared].date];
    
    [locationButton setTitle:[CGRestaurantParameter shared].getLocationName forState:UIControlStateNormal];
    
    [super viewDidLoad];
	
}


- (void)viewDidLayoutSubviews {
    self.scroller.delegate = self;
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 1300)];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.topView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:158.0f/255.0f green:157.0f/255.0f blue:157.0f/255.0f alpha:1.0f].CGColor, (id)[UIColor colorWithRed:197.0f/255.0f green:196.0f/255.0f blue:196.0f/255.0f alpha:1.0f].CGColor, nil];
    [self.topView.layer insertSublayer:gradient atIndex:0];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)search:(id)sender {
    [self.activityView startAnimating];
    [CGRestaurantParameter shared].eventOffset = 0;
    
    NSMutableDictionary *params = [[CGRestaurantParameter shared] buildEventParameterMap];
    [params setObject:@"true" forKey:@"reduced"];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/events"
                                           parameters:params
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  [self.activityView stopAnimating];
                                                  [self.delegate updateEvents:[mappingResult array]];
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

- (IBAction)clearAll:(id)sender {
    [[CGRestaurantParameter shared].categories removeAllObjects];
    [[CGRestaurantParameter shared].tags removeAllObjects];
    [[CGRestaurantParameter shared] fetchTags];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cleared"
                                                    message:@"Categories and Tags cleared."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"locationEventSegue"]){
        UINavigationController *navController = [segue destinationViewController];
        
        if (navController != nil){
            CGLocationViewController *locationController = (CGLocationViewController *)navController.topViewController;
            locationController.delegate = self;
        }
    }else if ([[segue identifier] isEqualToString:@"eventDateSegue"]){
        UINavigationController *navController = [segue destinationViewController];
        
        if (navController != nil){
            CGEventDateViewController *dateViewController = (CGEventDateViewController *)navController.topViewController;
            dateViewController.delegate = self;
        }
    }
}

- (void)sortWasSelected:(NSNumber *)selectedIndex element:(id)element {
    self.sortIndex = [selectedIndex intValue];
    
    if (self.sortIndex == 0){
        self.sortLabel.text = @"Distance";
        [CGRestaurantParameter shared].eventSortOrder = @"distance";
    }else if (self.sortIndex == 1){
        self.sortLabel.text = @"Name Asc";
        [CGRestaurantParameter shared].eventSortOrder = @"az";
    }else if (self.sortIndex == 2){
        self.sortLabel.text = @"Name Desc";
        [CGRestaurantParameter shared].eventSortOrder = @"za";
    }else if (self.sortIndex == 3){
        self.sortLabel.text = @"Rating";
        [CGRestaurantParameter shared].eventSortOrder = @"rating-h";
    }else if (self.sortIndex == 4){
        self.sortLabel.text = @"Price";
        [CGRestaurantParameter shared].eventSortOrder = @"price-h";
    }
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changeDate:(id)sender {
}

- (IBAction)changeSort:(id)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"Change Sort" rows:[NSArray arrayWithObjects: @"Distance", @"Name Asc", @"Name Desc", nil] initialSelection:self.sortIndex target:self successAction:@selector(sortWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
}

-(void) locationChanged{
    [locationButton setTitle:[CGRestaurantParameter shared].getLocationName forState:UIControlStateNormal];
}
-(void) updateDate:(NSDate *)newDate{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    self.dateLabel.text = [dateFormatter stringFromDate:newDate];
}

@end
