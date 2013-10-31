//
//  CGEventOptionsViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGEventDateViewController.h"
#import "CGLocationViewController.h"
#import <UIKit/UIKit.h>

@protocol CGEventOptionsViewDelegate
- (void) updateEvents:(NSArray *)newEvents;
@end

@interface CGEventOptionsViewController : UIViewController <UIScrollViewDelegate, CGLocationViewDelegate, GEventDateViewDelegate> {
    id <CGEventOptionsViewDelegate> delegate;
}

@property (nonatomic, assign) id <CGEventOptionsViewDelegate> delegate;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;

@property (strong, nonatomic) IBOutlet UIButton *tagButton;
@property (strong, nonatomic) IBOutlet UIButton *clearAllButton;
@property (strong, nonatomic) IBOutlet UIButton *tagsButton;
@property (strong, nonatomic) IBOutlet UIButton *categoriesButton;
@property (strong, nonatomic) IBOutlet UIButton *locationButton;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;

- (IBAction)search:(id)sender;
- (IBAction)clearAll:(id)sender;
- (IBAction)cancel:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (strong, nonatomic) IBOutlet UIView *headerView;

- (IBAction)changeSort:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *topView;

-(void)locationChanged;

@property (nonatomic, assign) NSInteger sortIndex;
@property (strong, nonatomic) IBOutlet UILabel *sortLabel;


@end
