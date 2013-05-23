//
//  CGRestaurantCell.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "MHLazyTableImages.h"
#import "CGRestaurantCell.h"

@implementation CGRestaurantCell

@synthesize nameLabel;
@synthesize headerView;
@synthesize primaryPhotoImage;
@synthesize topFiveLabel;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)lazyTableImages:(MHLazyTableImages*)lazyTableImages didLoadLazyImage:(UIImage *)image{
    self.primaryPhotoImage.image = image;
}

@end
