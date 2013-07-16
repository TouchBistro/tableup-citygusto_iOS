//
//  CGSearchViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 6/19/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGSearchResult.h"
#import "CGSearchResultCell.h"
#import "CGSearchResult.h"
#import "CGSearchViewController.h"
#import "MBProgressHud.h"
#import "CGRestaurantHomeViewController.h"
#import "CGEventDetailViewController.h"
#import "CGRestaurantListListViewController.h"
#import "CGLocalDetailViewController.h"
#import "CGRestaurantParameter.h"
#import <RestKit/RestKit.h>
#import <QuartzCore/QuartzCore.h>

#define AppIconHeight    60.0f

@interface CGSearchViewController ()

@end

@implementation CGSearchViewController{
    MHLazyTableImages *_lazyImages;
}

@synthesize matchesLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    _lazyImages = [[MHLazyTableImages alloc] init];
    _lazyImages.placeholderImage = [UIImage imageNamed:@"CityGusto App Icon - 60x60.png"];
    _lazyImages.delegate = self;
    _lazyImages.tableView = self.tableView;
    
    self.offset = 0;
    
    self.matchesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,30,300,55)];
    matchesLabel.font = [UIFont boldSystemFontOfSize:16];
    matchesLabel.numberOfLines = 0;
    matchesLabel.shadowColor = [UIColor lightTextColor];
    matchesLabel.textColor = [UIColor darkGrayColor];
    matchesLabel.shadowOffset = CGSizeMake(0, 1);
    matchesLabel.backgroundColor = [UIColor clearColor];
    matchesLabel.textAlignment =  NSTextAlignmentCenter;
    matchesLabel.text = @"Enter a search term";
    
    self.noResultsView = [[UIView alloc] initWithFrame:CGRectMake(0,30,300,55)];
    
    self.noResultsView.hidden = YES;
    [self.noResultsView addSubview:matchesLabel];
    [self.tableView insertSubview:self.noResultsView aboveSubview:self.tableView];
    
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0,100, 320, 60)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(10, 3, 300, 44)];
    
    [button setTitle:@"View More" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    
    [button addTarget:self action:@selector(viewMorePressed:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
    
    UIImage *greenImg = [UIImage imageNamed:@"buttonBackgroundGreen.png"];
    [button setBackgroundImage:greenImg forState:UIBarMetricsDefault];
    
    [self.footerView addSubview:button];
    
    [self.tableView setTableFooterView:self.footerView];
        
    NSLog(@"%@", NSStringFromCGPoint(self.tableView.tableFooterView.frame.origin));
    
    
    if (self.term.length > 0){
        self.mobileSearchBar.text = self.term;
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:self.term forKey:@"term"];
        [params setObject:[NSNumber numberWithInt:self.offset] forKey:@"offset"];
        
        if ([CGRestaurantParameter shared].useCurrentLocation){
            if ([CGRestaurantParameter shared].lat){
                [params setObject:[CGRestaurantParameter shared].lat forKey:@"lat"];
            }
            
            if ([CGRestaurantParameter shared].lon){
                [params setObject:[CGRestaurantParameter shared].lon forKey:@"long"];
            }
        }
        
        [self startSpinner];
        
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/search"
                                               parameters:params
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          self.results = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                          
                                                          if (self.results.count < 20){
                                                              self.tableView.tableFooterView = nil;
                                                          }else{
                                                              [self.tableView setTableFooterView:self.footerView];
                                                          }
                                                          
                                                          if (self.results.count == 0){
                                                              self.matchesLabel.text = @"No results found.  Please try another search term.";
                                                          }
                                                          
                                                          [self.tableView reloadData];
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
                                                      [self stopSpinner];
                                                  }];

    }
    
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
    if (self.results.count == 0){
        self.noResultsView.hidden = NO;
        self.tableView.tableFooterView.hidden = YES;
    }else{
        self.noResultsView.hidden = YES;
        self.tableView.tableFooterView.hidden = NO;
    }
    
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SearchResultCell";
    CGSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CGSearchResult *result = [self.results objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = result.name;
    cell.typeLabel.text = result.type;
    
    [_lazyImages addLazyImageForCell:cell withIndexPath:indexPath];

        CALayer *bottomBorder = [CALayer layer];
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = cell.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f].CGColor, (id)[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f].CGColor, nil];
        [cell.layer insertSublayer:gradient atIndex:0];
        
		cell.nameLabel.layer.shadowColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f].CGColor;
        cell.nameLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        
        cell.nameLabel.layer.shadowRadius = 3.0;
        cell.nameLabel.layer.shadowOpacity = 0.5;
        
        [cell.imageView.layer setBorderColor:[UIColor whiteColor].CGColor];
        [cell.imageView.layer setBorderWidth:1.5f];
        [cell.imageView.layer setShadowColor:[UIColor blackColor].CGColor];
        [cell.imageView.layer setShadowOpacity:0.8];
        [cell.imageView.layer setShadowRadius:3.0];
        [cell.imageView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    return cell;
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
    CGSearchResult *result = [self.results objectAtIndex:indexPath.row];
	return [NSURL URLWithString:result.photoURL];
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

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    self.term = searchBar.text;
    
    if (self.term.length > 0){
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:self.term forKey:@"term"];
        [params setObject:[NSNumber numberWithInt:self.offset] forKey:@"offset"];
        
        if ([CGRestaurantParameter shared].useCurrentLocation){
            if ([CGRestaurantParameter shared].lat){
                [params setObject:[CGRestaurantParameter shared].lat forKey:@"lat"];
            }
            
            if ([CGRestaurantParameter shared].lon){
                [params setObject:[CGRestaurantParameter shared].lon forKey:@"long"];
            }
        }
        
        [searchBar resignFirstResponder];
        
        [self startSpinner];
        
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/search"
                                               parameters:params
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          self.results = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                          
                                                          if (self.results.count < 20){
                                                              self.tableView.tableFooterView = nil;
                                                          }else{
                                                              [self.tableView setTableFooterView:self.footerView];
                                                          }
                                                          
                                                          if (self.results.count == 0){
                                                              self.matchesLabel.text = @"No results found.  Please try another search term.";
                                                          }

                                                          [self.tableView reloadData];
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
                                                      [self stopSpinner];
                                                  }];
        
        
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Search Term"
                                                        message:@"Search term can not be blank"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{	
	searchBar.text = nil;	
	[searchBar resignFirstResponder];
	
}

- (void) startSpinner {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading Results";
    hud.userInteractionEnabled = YES;
}

- (void) stopSpinner {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSearchResult *result = [self.results objectAtIndex:indexPath.row];
    self.selectedResult = result;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:result.resultId, @"id", nil];
    
    if (result){
        if ([result.type isEqualToString:@"Event"]){
            [self startSpinner];
            
            [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/events"
                                                   parameters:params
                                                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                          if (mappingResult){
                                                              self.selectedEvent = [[mappingResult array] objectAtIndex:0];
                                                              
                                                              [self stopSpinner];
                                                              [self performSegueWithIdentifier:@"searchEventDetailSegue" sender:self];
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
        }else if ([result.type isEqualToString:@"Local Business"]){
            [self startSpinner];
            [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/locals"
                                                   parameters:params
                                                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                          if (mappingResult){
                                                              self.selectedLocal = [[mappingResult array] objectAtIndex:0];
                                                          }
                                                          
                                                          [self stopSpinner];
                                                          [self performSegueWithIdentifier:@"searchLocalDetailSegue" sender:self];
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
        }else if ([result.type isEqualToString:@"Restaurant/Bar"]){
            [self startSpinner];
            
            [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurants"
                                                   parameters:params
                                                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                          if (mappingResult){
                                                              self.selectedRestaurant = [[mappingResult array] objectAtIndex:0];
                                                              
                                                              [self stopSpinner];
                                                              [self performSegueWithIdentifier:@"searchRestaurantDetailSegue" sender:self];
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
            
        }else if ([result.type isEqualToString:@"'Best of' List"]){
            NSDictionary *listParams = [NSDictionary dictionaryWithObjectsAndKeys:result.resultId, @"listId", nil];
            
            [self startSpinner];
            [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurants"
                                                   parameters:listParams
                                                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                          if (mappingResult){
                                                              self.listRestaurants = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                              [self stopSpinner];

                                                              [self performSegueWithIdentifier:@"searchRestaurantListSegue" sender:self];
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
                                                          
                                                          [self stopSpinner];
                                                      }];
            
        }
    }
}

- (void) viewMorePressed:(id)sender{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    self.offset += 20;
    [params setObject:[[NSNumber alloc] initWithInt:self.offset] forKey:@"offset"];
    [params setObject:[[NSNumber alloc] initWithInt:20] forKey:@"max"];
    [params setObject:@"true" forKey:@"reduced"];
    [params setObject:self.term forKey:@"term"];
    
    if ([CGRestaurantParameter shared].useCurrentLocation){
        if ([CGRestaurantParameter shared].lat){
            [params setObject:[CGRestaurantParameter shared].lat forKey:@"lat"];
        }
        
        if ([CGRestaurantParameter shared].lon){
            [params setObject:[CGRestaurantParameter shared].lon forKey:@"long"];
        }
    }
    
    
    [self startSpinner];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/search"
                                           parameters:params
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      [self.results addObjectsFromArray:[mappingResult array]];
                                                      
                                                      if ([mappingResult array].count < 20){
                                                          self.tableView.tableFooterView = nil;
                                                      }else{
                                                          [self.tableView setTableFooterView:self.footerView];
                                                      }
                                                      
                                                      [self.tableView reloadData];
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
    if ([[segue identifier] isEqualToString:@"searchRestaurantDetailSegue"]){
        CGRestaurantHomeViewController *homeController = [segue destinationViewController];
        homeController.restaurant = self.selectedRestaurant;
    }else if ([[segue identifier] isEqualToString:@"searchEventDetailSegue"]){
        CGEventDetailViewController *viewController = [segue destinationViewController];
        viewController.event = self.selectedEvent;
    }else if ([[segue identifier] isEqualToString:@"searchRestaurantListSegue"]){
        CGRestaurantList *restaurantList = [CGRestaurantList alloc];
        restaurantList.name = self.selectedResult.name;
        restaurantList.restaurantListId = self.selectedResult.resultId;
        
        CGRestaurantListListViewController *restaurantListViewController = [segue destinationViewController];
        restaurantListViewController.restaurants = self.listRestaurants;
        restaurantListViewController.restaurantList = restaurantList;
    }else if ([[segue identifier] isEqualToString:@"searchLocalDetailSegue"]){
        CGLocalDetailViewController *viewController = [segue destinationViewController];
        viewController.local = self.selectedLocal;
    }
}

@end
