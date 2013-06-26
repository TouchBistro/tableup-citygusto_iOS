//
//  CGSelectRestaurantCategoryViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/5/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//
#import "CGRestaurantListCategory.h"
#import "CGLoginViewController.h"
#import <UIKit/UIKit.h>

@protocol CGSelectRestaurantCategoryDelegate
- (void) updateRestaurantCategory:(CGRestaurantListCategory *) restaurantCategory;
@end



@interface CGSelectRestaurantCategoryViewController : UITableViewController <CGLoginViewDelegate>{
    id <CGSelectRestaurantCategoryDelegate> delegate;
}

@property (nonatomic, assign) id <CGSelectRestaurantCategoryDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *restaurantCategories;
@property (nonatomic, strong) CGRestaurantListCategory *selectedCategory;


- (IBAction)cancel:(id)sender;

@end
