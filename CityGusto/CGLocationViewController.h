//
//  CGLocationViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/27/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CGLocationViewDelegate
- (void) locationChanged;
@end

@interface CGLocationViewController : UITableViewController{
    id <CGLocationViewDelegate> delegate;
}

@property (nonatomic, assign) id <CGLocationViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *locations;

- (IBAction)cancel:(id)sender;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;

@end
