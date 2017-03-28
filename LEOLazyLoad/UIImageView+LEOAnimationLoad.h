//
//  UIImageView+LEOAnimationLoad.h
//  LEOLazyLoad
//
//  Created by Leon on 17/3/27.
//  Copyright © 2017年 大途弘安. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImageView (LEOAnimationLoad)

/**
 渐进加载图片
 
 @param url 图片url
 @param placehoderImage 占位图
 */
- (void)lad_setImageFadeInWithURL:(NSURL *)url
                placeholderImage:(UIImage *)placehoderImage;




@end
