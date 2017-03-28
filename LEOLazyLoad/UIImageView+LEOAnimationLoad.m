//
//  UIImageView+LEOAnimationLoad.m
//  LEOLazyLoad
//
//  Created by Leon on 17/3/27.
//  Copyright © 2017年 大途弘安. All rights reserved.
//

#import "UIImageView+LEOAnimationLoad.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (LEOAnimationLoad)

- (void)lad_setImageFadeInWithURL:(NSURL *)url
                placeholderImage:(UIImage *)placehoderImage {
    
    [self lad_setImageWithURL:url placeholderImage:placehoderImage options:SDWebImageRetryFailed | SDWebImageLowPriority duratingTime:0.5f];
}

- (void)lad_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)image
                   options:(SDWebImageOptions)option
              duratingTime:(NSTimeInterval)duration  {
    
    [self sd_setImageWithURL:url placeholderImage:image options:option completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        //针对没缓存过的图片做动画
        if (image && cacheType == SDImageCacheTypeNone)  {
            CATransition *fadeIn = [CATransition animation];
            fadeIn.type = @"fade";
            fadeIn.duration = duration;
            fadeIn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            [self.layer addAnimation:fadeIn forKey:@"fadeIn"];
        }
    }];
}
@end
