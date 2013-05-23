//
//  CGFoodTruckCell.m
//  CityGusto
//
//  Created by Padraic Doyle on 5/22/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGFoodTruckCell.h"

@implementation CGFoodTruckCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)lazyTableImages:(MHLazyTableImages*)lazyTableImages didLoadLazyImage:(UIImage *)image{
    self.primaryPhotoImage.image = image;
}

@end
