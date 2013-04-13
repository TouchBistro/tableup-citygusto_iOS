//
//  CGEventDateViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GEventDateViewDelegate
- (void) updateDate:(NSDate *)newDate;
@end

@interface CGEventDateViewController : UITableViewController {
    id <GEventDateViewDelegate> delegate;
}

@property (nonatomic, assign) id <GEventDateViewDelegate> delegate;


- (IBAction)done:(id)sender;
- (IBAction)changeDate:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) NSString *dateString;
@property (assign, nonatomic) NSInteger sortIndex;

@end
