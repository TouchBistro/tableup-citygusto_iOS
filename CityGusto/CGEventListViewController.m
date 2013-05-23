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
#import "CGEventMapViewController.h"
#import "MHLazyTableImages.h"
#import <QuartzCore/QuartzCore.h>
#import <RestKit/RestKit.h>

#define AppIconHeight    60.0f

@interface CGEventListViewController ()

@end

@implementation CGEventListViewController{
    MHLazyTableImages *_lazyImages;
}

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
    
    _lazyImages = [[MHLazyTableImages alloc] init];
    _lazyImages.placeholderImage = [UIImage imageNamed:@"CityGusto App Icon - 60x60.png"];
    _lazyImages.delegate = self;
    _lazyImages.tableView = self.tableView;
    
    [self setDataLoaded:NO];
    
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 60)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(10, 3, 300, 44)];
    
    [button setTitle:@"View More" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
    
    [button addTarget:self action:@selector(viewMorePressed:)
     forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *greenImg = [UIImage imageNamed:@"buttonBackgroundGreen.png"];
    [button setBackgroundImage:greenImg forState:UIBarMetricsDefault];
    [self.footerView addSubview:button];
    
    [self.tableView setTableFooterView:self.footerView];
    
    self.noResultsView = [[UIView alloc] initWithFrame:self.tableView.frame];
    self.noResultsView.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f];
    
    UILabel *matchesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320,320)];
    matchesLabel.font = [UIFont boldSystemFontOfSize:18];
    matchesLabel.numberOfLines = 0;
    matchesLabel.shadowColor = [UIColor lightTextColor];
    matchesLabel.textColor = [UIColor darkGrayColor];
    matchesLabel.shadowOffset = CGSizeMake(0, 1);
    matchesLabel.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f];
    matchesLabel.textAlignment =  NSTextAlignmentCenter;
    matchesLabel.text = @"Your search returned no results.\n Try clearing filters.";
    
    self.noResultsView.hidden = YES;
    [self.noResultsView addSubview:matchesLabel];
    [self.tableView insertSubview:self.noResultsView aboveSubview:self.tableView];

    [self startSpinner];
    if (self.events.count == 0){
        NSMutableDictionary *params = [[CGRestaurantParameter shared] buildEventParameterMap];
        [params setObject:@"true" forKey:@"reduced"];
        
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/events"
                                               parameters:params
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          self.events = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                          
                                                          if ([mappingResult array].count < 25){
                                                              self.tableView.tableFooterView = nil;
                                                          }else{
                                                              [self.tableView setTableFooterView:self.footerView];
                                                          }
                                                          
                                                          [self setDataLoaded:YES];
                                                          [self stopSpinner];
                                                      }
                                                      
                                                      self.resultsEmpty = self.events.count == 0 ? YES : NO;
                                                      [self.tableView reloadData];
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
    if (self.resultsEmpty){
        self.noResultsView.hidden = NO;
    }else{
        self.noResultsView.hidden = YES;
    }
    
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventCell";
    CGEventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    cell.nameLabel.text = @"";
    cell.venueLabel.text = @"";
    cell.timeLabel.text = @"";
    cell.nextOccurrenceLabel.text = @"";
    
    if (self.isResultsEmpty == NO){
        CGEvent *event = [self.events objectAtIndex:indexPath.row];
        
        cell.nameLabel.text = event.name;
        
        //NSURL *url = [NSURL URLWithString:event.venuePhotoURL];
        //NSData *data = [NSData dataWithContentsOfURL:url];
        //UIImage *image = [UIImage imageWithData:data];
        
        //cell.primaryPhotoImage.image = image;
        
        [_lazyImages addLazyImageForCell:cell withIndexPath:indexPath];
        
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
        
        // New line
        //[cell.primaryPhotoImage.layer setShadowPath:[UIBezierPath bezierPathWithRect:cell.primaryPhotoImage.bounds].CGPath];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    self.selectedEvent = [self.events objectAtIndex:indexPath.row];
    CGEvent *event = [self.events objectAtIndex:indexPath.row];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:event.eventId, @"id", nil];
    
    [self startSpinner];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/events"
                                           parameters:params
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      self.selectedEvent = [[mappingResult array] objectAtIndex:0];
                                                      
                                                      [self stopSpinner];
                                                      [self performSegueWithIdentifier:@"eventDetailSegue" sender:self];
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

-(void) viewMorePressed:(id)sender{
    [CGRestaurantParameter shared].eventOffset = [NSNumber numberWithInt:[[CGRestaurantParameter shared].eventOffset intValue] + 25];
    NSMutableDictionary *params = [[CGRestaurantParameter shared] buildEventParameterMap];
    [params setObject:@"true" forKey:@"reduced"];
    
    [self startSpinner];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/events"
                                           parameters:params
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      [self.events addObjectsFromArray:[mappingResult array]];
                                                      
                                                      [self setDataLoaded:YES];
                                                      [self.tableView reloadData];
                                                      
                                                      if ([mappingResult array].count < 25){
                                                          self.tableView.tableFooterView = nil;
                                                      }else{
                                                          [self.tableView setTableFooterView:self.footerView];
                                                      }
                                                      
                                                      
                                                      [self stopSpinner];
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
    if ([[segue identifier] isEqualToString:@"eventOptionsSegue"]){
        UINavigationController *navController = [segue destinationViewController];
        
        if (navController != nil){
            CGEventOptionsViewController *optionsController = (CGEventOptionsViewController *)navController.topViewController;
            optionsController.delegate = self;
        }
    }else if ([[segue identifier] isEqualToString:@"eventDetailSegue"]){
        CGEventDetailViewController *detailController = [segue destinationViewController];
        detailController.event = self.selectedEvent;
    }else if ([[segue identifier] isEqualToString:@"mapEventSegue"]){
        CGEventMapViewController *mapController = [segue destinationViewController];
        mapController.events = self.events;
    }
}

-(void)updateEvents:(NSArray *)newEvents{
    [self.events removeAllObjects];
    [self.events addObjectsFromArray:newEvents];
    
    if ([self.events count] < 25){
        self.tableView.tableFooterView = nil;
    }else{
        [self.tableView setTableFooterView:self.footerView];
    }
    
    self.resultsEmpty = self.events.count == 0 ? YES : NO;
    
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointZero animated:NO];
}

- (void) startSpinner {
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.center = CGPointMake(self.tableView.frame.size.width / 2.0, self.tableView.frame.size.height / 2.0);
    [self.tableView addSubview: activityView];
    
    [self.activityView startAnimating];
}

- (void) stopSpinner {
    [self.activityView stopAnimating];
    [self.activityView removeFromSuperview];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[_lazyImages scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	[_lazyImages scrollViewDidEndDecelerating:scrollView];
}

#pragma mark - MHLazyTableImagesDelegate

- (NSURL *)lazyTableImages:(MHLazyTableImages *)lazyTableImages lazyImageURLForIndexPath:(NSIndexPath *)indexPath
{
    CGEvent *event = [self.events objectAtIndex:indexPath.row];
	return [NSURL URLWithString:event.venuePhotoURL];
}

- (UIImage *)lazyTableImages:(MHLazyTableImages *)lazyTableImages postProcessLazyImage:(UIImage *)image forIndexPath:(NSIndexPath *)indexPath
{
    if (image.size.width != AppIconHeight && image.size.height != AppIconHeight)
 		return [self scaleImage:image toSize:CGSizeMake(AppIconHeight, AppIconHeight)];
    else
        return image;
}

- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size
{
	UIGraphicsBeginImageContextWithOptions(size, YES, 0.0f);
	CGRect imageRect = CGRectMake(0.0f, 0.0f, size.width, size.height);
	[image drawInRect:imageRect];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

@end
