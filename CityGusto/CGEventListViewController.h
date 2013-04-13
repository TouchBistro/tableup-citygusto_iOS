//
//  CGEventListViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGEventOptionsViewController.h"
#import "CGEvent.h"
#import <UIKit/UIKit.h>

@interface CGEventListViewController : UITableViewController<CGEventOptionsViewDelegate>

@property (nonatomic, strong) NSMutableArray *events;
@property (nonatomic, assign, getter=isDataLoaded) BOOL dataLoaded;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, strong) CGEvent *selectedEvent;

- (void) viewMorePressed:(id)sender;

@end
