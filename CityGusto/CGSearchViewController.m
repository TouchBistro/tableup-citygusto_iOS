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
#import <RestKit/RestKit.h>
#import <QuartzCore/QuartzCore.h>

#define AppIconHeight    60.0f

@interface CGSearchViewController ()

@end

@implementation CGSearchViewController{
    MHLazyTableImages *_lazyImages;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _lazyImages = [[MHLazyTableImages alloc] init];
    _lazyImages.placeholderImage = [UIImage imageNamed:@"CityGusto App Icon - 60x60.png"];
    _lazyImages.delegate = self;
    _lazyImages.tableView = self.tableView;
    
    self.offset = 0;
    
    UILabel *matchesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320,320)];
    matchesLabel.font = [UIFont boldSystemFontOfSize:18];
    matchesLabel.numberOfLines = 0;
    matchesLabel.shadowColor = [UIColor lightTextColor];
    matchesLabel.textColor = [UIColor darkGrayColor];
    matchesLabel.shadowOffset = CGSizeMake(0, 1);
    matchesLabel.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f];
    matchesLabel.textAlignment =  NSTextAlignmentCenter;
    matchesLabel.text = @"Enter a search term";
    
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 60)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(10, 3, 300, 44)];
    
    [button setTitle:@"View More" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    
    [button addTarget:self action:@selector(viewMorePressed:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
    
    [self.tableView setTableFooterView:self.footerView];
    
    UIImage *greenImg = [UIImage imageNamed:@"buttonBackgroundGreen.png"];
    [button setBackgroundImage:greenImg forState:UIBarMetricsDefault];
    
    self.noResultsView.hidden = YES;
    [self.noResultsView addSubview:matchesLabel];
    
    [self.tableView insertSubview:self.noResultsView aboveSubview:self.tableView];
    
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
//        self.tableView.tableFooterView.hidden = YES;
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
    
    [cell.imageView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [cell.imageView.layer setBorderWidth:1.5f];
    [cell.imageView.layer setShadowColor:[UIColor blackColor].CGColor];
    [cell.imageView.layer setShadowOpacity:0.8];
    [cell.imageView.layer setShadowRadius:3.0];
    [cell.imageView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    
    NSString *term = searchBar.text;
    
    if (term.length > 0){
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:term forKey:@"term"];
        [params setObject:[NSNumber numberWithInt:self.offset] forKey:@"offset"];
        
        [searchBar resignFirstResponder];
        
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/MattsMenus/mobile/search"
                                               parameters:params
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          self.results = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                          
                                                          if (self.results.count < 20){
                                                              self.tableView.tableFooterView = nil;
                                                          }else{
                                                              [self.tableView setTableFooterView:self.footerView];
                                                          }
                                                          
                                                          self.resultsEmpty = self.results.count == 0 ? YES : NO;

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

- (void) startSpinner {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Getting Search Results";
    hud.userInteractionEnabled = YES;
}

- (void) stopSpinner {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
