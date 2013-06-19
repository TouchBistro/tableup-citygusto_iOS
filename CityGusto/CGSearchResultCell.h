//
//  CGSearchResultCell.h
//  CityGusto
//
//  Created by Padraic Doyle on 6/19/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGSearchResultCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
