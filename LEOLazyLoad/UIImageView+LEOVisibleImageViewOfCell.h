//
//  UIImageView+LEOVisibleImageViewOfCell.h
//  LEOLazyLoad
//
//  Created by Leon on 17/3/27.
//  Copyright © 2017年 大途弘安. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LEOVisibleImageViewOfCell)

- (void)lvc_loadVisibleImageWithURL:(NSURL *)imageURL
                        targetRect:(NSValue *)aTargetRect
                          cellFrame:(CGRect)aCellFrame;

@end
