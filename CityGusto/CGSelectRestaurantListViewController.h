//
//  CGSelectRestaurantListViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/5/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CGSelectRestaurantListViewViewDelegate
- (void) updateRestaurantList:(CGRestaurantList *) restaurantList selectedIndex:(NSInteger)index;
@end

@interface CGSelectRestaurantListViewController : UITableViewController{
    id <CGSelectRestaurantListViewViewDelegate> delegate;
}

@property (nonatomic, assign) id <CGSelectRestaurantListViewViewDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *restaurantLists;
- (IBAction)cancel:(id)sender;

@end
