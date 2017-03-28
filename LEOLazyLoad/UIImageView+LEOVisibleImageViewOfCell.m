//
//  UIImageView+LEOVisibleImageViewOfCell.m
//  LEOLazyLoad
//
//  Created by Leon on 17/3/27.
//  Copyright © 2017年 大途弘安. All rights reserved.
//

#import "UIImageView+LEOVisibleImageViewOfCell.h"
#import "UIImageView+LEOAnimationLoad.h"
#import "UIImageView+WebCache.h"
#import <SDImageCache.h>

@implementation UIImageView (LEOVisibleImageViewOfCell)

- (void)lvc_loadVisibleImageWithURL:(NSURL *)imageURL
                        targetRect:(NSValue *)aTargetRect
                         cellFrame:(CGRect)aCellFrame {
    
    // 先判断当前imageView上的图片url 是否与当前要显示的url一致 如果一致的话就不走括号里的处理逻辑 使用当前的图片
    if (![[self sd_imageURL] isEqual:imageURL]) {
        
        BOOL shouldLoadImage = YES;
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        
        // self.targetRect是用来判断是否在减速过程当中
        // !CGRectIntersectsRect([self.targetRect CGRectValue], cellFrame)是用来判断出现的cell是否在目标区域
        // 4.这两个判断合起来的意思是:tableView正处于减速过程,显示的cell也不在目标区域才为真
        if (aTargetRect && !CGRectIntersectsRect([aTargetRect CGRectValue], aCellFrame)) {
            
            SDImageCache *cache = [manager imageCache];
            NSString *key = [manager cacheKeyForURL:imageURL];
            
            // 如果不存磁盘 只需要改成imageFromeMemoryCacheForkey:
            if (![cache imageFromDiskCacheForKey:key]) {
                shouldLoadImage = NO;
            }
        }
        
        UIImage *placeholderImage = [UIImage imageNamed:@""];
        //3. 加载图片
        if (shouldLoadImage) {
            [self lad_setImageFadeInWithURL:imageURL placeholderImage:placeholderImage];
        }else {
            self.image = placeholderImage;
        }
    }

}

@end
