//
//  CGCuisineViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/27/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGCuisineViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *cuisines;
- (IBAction)done:(id)sender;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;

@end
