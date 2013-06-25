//
//  CGSearchViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 6/19/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurant.h"
#import "CGEvent.h"
#import "CGLocal.h"
#import "MHLazyTableImages.h"
#import <UIKit/UIKit.h>

@interface CGSearchViewController : UITableViewController <MHLazyTableImagesDelegate, UIScrollViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *results;
@property (nonatomic, strong) NSMutableArray *listRestaurants;

@property (nonatomic, assign, getter=isResultsEmpty) BOOL resultsEmpty;

@property (strong, nonatomic) UIView *noResultsView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UILabel *matchesLabel;

@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, strong) NSString *term;

@property (nonatomic, strong) CGRestaurant *selectedRestaurant;
@property (nonatomic, strong) CGEvent *selectedEvent;
@property (nonatomic, strong) CGSearchResult *selectedResult;
@property (nonatomic, strong) CGLocal *selectedLocal;

@end
