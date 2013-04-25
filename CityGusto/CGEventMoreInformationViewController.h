//
//  CGEventMoreInformationViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/25/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGEvent.h"
#import <UIKit/UIKit.h>

@interface CGEventMoreInformationViewController : UITableViewController

@property (nonatomic, strong) CGEvent *selectedEvent;
@property (nonatomic, strong) NSMutableArray *rows;

@end
