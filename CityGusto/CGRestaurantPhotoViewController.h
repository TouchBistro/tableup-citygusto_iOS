//
//  CGRestaurantPhotoViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/21/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface CGRestaurantPhotoViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (strong, nonatomic) IBOutlet iCarousel *carousel;
@property (strong, nonatomic) NSMutableArray *photos;

@end
