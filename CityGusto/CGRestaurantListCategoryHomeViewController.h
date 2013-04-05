//
//  CGRestaurantListCategoryHomeViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/4/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurantList.h"
#import "CGRestaurant.h"
#import "CGRestaurantListCategory.h"
#import "CGSelectRestaurantListViewController.h"
#import <UIKit/UIKit.h>

@interface CGRestaurantListCategoryHomeViewController : UIViewController <CGSelectRestaurantListViewViewDelegate>

@property (nonatomic, strong) NSMutableArray *restaurantListCategories;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *headerLabel;
@property (strong, nonatomic) IBOutlet UIView *imageSliderView;

@property (strong, nonatomic) IBOutlet UIView *listNameView;
@property (strong, nonatomic) IBOutlet UILabel *listNameLabel;

@property (strong, nonatomic) IBOutlet UIView *restaurant1View;
@property (strong, nonatomic) IBOutlet UIView *restaurant2View;
@property (strong, nonatomic) IBOutlet UIView *restaurant3View;

@property (strong, nonatomic) IBOutlet UILabel *restaurant1Label;
@property (strong, nonatomic) IBOutlet UILabel *restaurant2Label;
@property (strong, nonatomic) IBOutlet UILabel *restaurant3Label;

@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UIButton *locationButton;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) CGRestaurantListCategory *currentCategory;
@property (nonatomic, strong) CGRestaurantList *currentRestaurantList;

@property (nonatomic, strong) CGRestaurant *restaurant1;
@property (nonatomic, strong) CGRestaurant *restaurant2;
@property (nonatomic, strong) CGRestaurant *restaurant3;

@property (nonatomic, strong) CGRestaurant *selectedRestaurant;

- (IBAction)locationChange:(id)sender;


@end
