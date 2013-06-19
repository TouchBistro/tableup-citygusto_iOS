//
//  CGSearchViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 6/19/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "MHLazyTableImages.h"
#import <UIKit/UIKit.h>

@interface CGSearchViewController : UITableViewController <MHLazyTableImagesDelegate, UIScrollViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *results;

@property (nonatomic, assign, getter=isResultsEmpty) BOOL resultsEmpty;

@property (strong, nonatomic) UIView *noResultsView;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, assign) NSInteger offset;

@end
