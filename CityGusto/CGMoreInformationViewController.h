//
//  CGMoreInformationViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/28/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurant.h"
#import <UIKit/UIKit.h>

@interface CGMoreInformationViewController : UITableViewController

@property (nonatomic, strong) CGRestaurant *selectedRestaurant;
@property (nonatomic, strong) NSMutableArray *rows;
@end
