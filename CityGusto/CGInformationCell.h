//
//  CGInformationCell.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/28/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGInformationCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UITextView *valueTextView;
@property (strong, nonatomic) IBOutlet UITextView *headerTextView;
@property (strong, nonatomic) IBOutlet UILabel *valueLabel;
@property (strong, nonatomic) IBOutlet UIView *valueView;

@property (strong, nonatomic) IBOutlet UILabel *headerLabel;
@end
