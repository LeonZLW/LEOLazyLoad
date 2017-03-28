//
//  UIViewController+LEOCellTargetRect.m
//  LEOLazyLoad
//
//  Created by Leon on 17/3/27.
//  Copyright © 2017年 大途弘安. All rights reserved.
//

#import "UIViewController+LEOCellTargetRect.h"
#import <objc/runtime.h>

static char LEO_TARGETRECT_KEY;
static char LEO_VISIBLECELLBLOCK_KEY;

@implementation UIViewController (LEOCellTargetRect)

- (NSValue *)targetRect {
   return objc_getAssociatedObject(self, &LEO_TARGETRECT_KEY);
}

- (void)setTargetRect:(NSValue *)targetRect {
    objc_setAssociatedObject(self, &LEO_TARGETRECT_KEY, targetRect, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lvh_loadVisibleCellHandle:(LEOLoadVisibleCellHandler)handler {
    objc_setAssociatedObject(self, &LEO_VISIBLECELLBLOCK_KEY, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    self.targetRect = nil;
    // 1.用户开始拖拽的时候去加载已显示在屏幕上的cell,如果不调用这个方法的话,当快速滑动图片列表在减速过程尚未完全停止的情况下又对它进行拖动操作,这时候当前屏幕上未加载出来图片的cell拖动的时候就不会重新加载图片了,因为这个cell已经在屏幕上了,不会再走cellForRowAtIndexPath方法
    [self p_loadVisibleCellInScrollView:scrollView];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    // 2.targetRect用来记录减速到最后会停留的区域
    CGRect targetRect = CGRectMake(targetContentOffset->x, targetContentOffset->y, scrollView.bounds.size.width, scrollView.bounds.size.height);
    self.targetRect = [NSValue valueWithCGRect:targetRect];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.targetRect = nil;
    
//    3. 最终减速到静止状态,再次对已显示在屏幕上的cell加载图片
    [self p_loadVisibleCellInScrollView:scrollView];
}

- (void)p_loadVisibleCellInScrollView:(UIScrollView *)scrollView {
    
    LEOLoadVisibleCellHandler block = objc_getAssociatedObject(self, &LEO_VISIBLECELLBLOCK_KEY);
    block(scrollView);
    
    if (block) {
        block(scrollView);
    }
}

@end
