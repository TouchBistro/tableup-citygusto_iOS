//
//  CGRestaurantCell.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//
#import "MHLazyTableImages.h"
#import <UIKit/UIKit.h>

@interface CGRestaurantCell : UITableViewCell <MHLazyTableImageCell>

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *primaryPhotoImage;
@property (strong, nonatomic) IBOutlet UILabel *topFiveLabel;
@property (strong, nonatomic) IBOutlet UILabel *ratings;
@property (strong, nonatomic) IBOutlet UIImageView *starImages;
@property (strong, nonatomic) IBOutlet UIImageView *priceImageView;
@property (strong, nonatomic) IBOutlet UILabel *noResultsLabel;

@end
