//
//  CGEventListViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGEventOptionsViewController.h"
#import "MHLazyTableImages.h"
#import "CGEvent.h"
#import <UIKit/UIKit.h>

@interface CGEventListViewController : UITableViewController <CGEventOptionsViewDelegate, MHLazyTableImagesDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *events;
@property (nonatomic, assign, getter=isDataLoaded) BOOL dataLoaded;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, strong) CGEvent *selectedEvent;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, assign, getter=isResultsEmpty) BOOL resultsEmpty;

- (void) viewMorePressed:(id)sender;

@property (strong, nonatomic) UIView *noResultsView;

@property (nonatomic, assign) BOOL locationChanged;

-(void) startSpinner;
-(void) stopSpinner;


@end
