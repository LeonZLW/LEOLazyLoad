//
//  UIViewController+LEOCellTargetRect.h
//  LEOLazyLoad
//
//  Created by Leon on 17/3/27.
//  Copyright © 2017年 大途弘安. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LEOLoadVisibleCellHandler)(id);

@interface UIViewController (LEOCellTargetRect)
@property (nonatomic, strong) NSValue *targetRect;

- (void)lvh_loadVisibleCellHandle:(LEOLoadVisibleCellHandler)handler;

@end
