//
//  CGRestaurantPhotoViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/21/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurantPhotoViewController.h"
#import "AsyncImageView.h"
#import "CGPhoto.h"

@interface CGRestaurantPhotoViewController ()

@end

@implementation CGRestaurantPhotoViewController

@synthesize carousel;

- (void)viewDidLoad
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    if (self.photos.count == 0){
        UILabel *noPhotoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, 320, 60)];
        noPhotoLabel.text = @"There are no photos for this restaurant.";
        noPhotoLabel.textColor = [UIColor colorWithRed:98.0f/255.0f green:137.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
        noPhotoLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:noPhotoLabel];
    }else{
        self.carousel.type = iCarouselTypeCoverFlow2;
    }
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [self.photos count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    CGPhoto *photo = [self.photos objectAtIndex:index];
    
    if (view == nil)
    {
        view = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 275.0f, 275.0f)];
        view.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:view];
    
    ((AsyncImageView *)view).imageURL = [NSURL URLWithString:photo.photoURL];
    
    return view;
    
}

@end
