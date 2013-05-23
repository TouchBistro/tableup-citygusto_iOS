//
//  CGEventCell.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGEventCell.h"

@implementation CGEventCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)lazyTableImages:(MHLazyTableImages*)lazyTableImages didLoadLazyImage:(UIImage *)image{
    self.primaryPhotoImage.image = image;
}

@end
