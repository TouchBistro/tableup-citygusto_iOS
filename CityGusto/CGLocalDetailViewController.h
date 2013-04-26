//
//  CGLocalDetailViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/26/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGLocal.h"
#import <UIKit/UIKit.h>

@interface CGLocalDetailViewController : UIViewController

@property (nonatomic, strong) CGLocal *local;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *headerLabel;
@property (strong, nonatomic) IBOutlet UIView *addressView;
@property (strong, nonatomic) IBOutlet UILabel *address1;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *neighborhoodLabel;

- (IBAction)map:(id)sender;
- (IBAction)call:(id)sender;
- (IBAction)website:(id)sender;

@end
