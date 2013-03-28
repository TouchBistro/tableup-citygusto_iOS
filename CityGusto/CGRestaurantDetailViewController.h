//
//  CGRestaurantDetailViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/25/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurant.h"
#import <UIKit/UIKit.h>

@interface CGRestaurantDetailViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) CGRestaurant *restaurant;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *informationSectionView;
@property (strong, nonatomic) IBOutlet UILabel *likeLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfLikesLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfDislikesLabel;
@property (strong, nonatomic) IBOutlet UIView *ratingsView;
@property (strong, nonatomic) IBOutlet UILabel *topFiveLabel;
@property (strong, nonatomic) IBOutlet UIView *topFiveView;
@property (strong, nonatomic) IBOutlet UIView *infoView;
@property (strong, nonatomic) IBOutlet UIView *addressView;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UIButton *mapButton;
@property (strong, nonatomic) IBOutlet UIView *aboutView;

- (IBAction)map:(id)sender;
@end
