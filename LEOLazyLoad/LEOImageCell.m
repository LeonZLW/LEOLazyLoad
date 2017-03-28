//
//  LEOImageCell.m
//  LEOLazyLoad
//
//  Created by Leon on 17/3/27.
//  Copyright © 2017年 大途弘安. All rights reserved.
//

#import "LEOImageCell.h"
#import "UIImageView+LEOVisibleImageViewOfCell.h"

@implementation LEOImageCell


- (void)loadVisibleWithItem:(NSDictionary *)item
                 targetRect:(NSValue *)aTargetRect
                  cellFrame:(CGRect)aCellFrame {
    
    NSURL *imageURL = [NSURL URLWithString:item[@"imgURL"]];
    [self.leoImageView lvc_loadVisibleImageWithURL:imageURL targetRect:aTargetRect cellFrame:aCellFrame];
}


@end
