//
//  CGEventListViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//


#import "CGEventListViewController.h"
#import "CGRestaurantParameter.h"
#import "CGEventCell.h"
#import "CGEvent.h"
#import "CGEventOptionsViewController.h"
#import "CGEventDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <RestKit/RestKit.h>


@interface CGEventListViewController ()

@end

@implementation CGEventListViewController

@synthesize events;
@synthesize selectedEvent;
@synthesize dataLoaded;
@synthesize activityView;

- (void)viewDidLoad
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    [self setDataLoaded:NO];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 60)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(10, 3, 300, 44)];
    
    [button setTitle:@"View More" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
    
    [button addTarget:self action:@selector(viewMorePressed:)
     forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *greenImg = [UIImage imageNamed:@"buttonBackgroundGreen.png"];
    [button setBackgroundImage:greenImg forState:UIBarMetricsDefault];
    [footerView addSubview:button];
    
    [self.tableView setTableFooterView:footerView];
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityView.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.tableView addSubview: activityView];
    
    [self.activityView startAnimating];
    if (self.events.count == 0){
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/MattsMenus/mobile/native/events"
                                               parameters:[[CGRestaurantParameter shared] buildEventParameterMap]
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          self.events = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                          [self setDataLoaded:YES];
                                                          [self.tableView reloadData];
                                                          [self.activityView stopAnimating];
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
                                                      [self.activityView stopAnimating];
                                                  }];
        
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
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventCell";
    CGEventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    CGEvent *event = [self.events objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = @"";
    cell.venueLabel.text = @"";
    cell.timeLabel.text = @"";
    cell.nextOccurrenceLabel.text = @"";
    
    if (event){
        cell.nameLabel.text = event.name;
        
        NSURL *url = [NSURL URLWithString:event.venuePhotoURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        cell.primaryPhotoImage.image = image;
        
        cell.venueLabel.text = event.venueName;
        
        NSString *eventTime = event.startTime ? event.startTime : nil;
        if (event.endTime && eventTime){
            eventTime = [eventTime stringByAppendingString:@" - "];
            eventTime = [eventTime stringByAppendingString:event.endTime];
        }
        
        if (eventTime){
            cell.timeLabel.text = eventTime;
        }
        
        if (event.dateString){
            cell.nextOccurrenceLabel.text = event.dateString;
        }
        
        //style
        cell.headerView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:236.0f/255.0f blue:236.0f/255.0f alpha:1.0f];
        cell.nameLabel.textColor = [UIColor colorWithRed:98.0f/255.0f green:137.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
        
        CALayer *bottomBorder = [CALayer layer];
        
        bottomBorder.frame = CGRectMake(0.0f, 22.0f, cell.headerView.frame.size.width, 1.0f);
        bottomBorder.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f].CGColor;
        
        [cell.headerView.layer addSublayer:bottomBorder];
        
        cell.nameLabel.layer.shadowColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f].CGColor;
        cell.nameLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        
        cell.nameLabel.layer.shadowRadius = 3.0;
        cell.nameLabel.layer.shadowOpacity = 0.5;
        
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
    self.selectedEvent = [self.events objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"eventDetailSegue" sender:self];
}

-(void) viewMorePressed:(id)sender{
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"eventOptionsSegue"]){
        UINavigationController *navController = [segue destinationViewController];
        
        if (navController != nil){
            CGEventOptionsViewController *optionsController = (CGEventOptionsViewController *)navController.topViewController;
            optionsController.delegate = self;
        }
    }else if ([[segue identifier] isEqualToString:@"eventDetailSegue"]){
        CGEventDetailViewController *detailController = [segue destinationViewController];
        detailController.event = self.selectedEvent;
    }
    
    
}

-(void)updateEvents:(NSArray *)newEvents{
    [self.events removeAllObjects];
    [self.events addObjectsFromArray:newEvents];
    
    [self.tableView reloadData];
}

@end
