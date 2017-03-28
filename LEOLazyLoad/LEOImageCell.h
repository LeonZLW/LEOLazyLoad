//
//  LEOImageCell.h
//  LEOLazyLoad
//
//  Created by Leon on 17/3/27.
//  Copyright © 2017年 大途弘安. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LEOImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leoImageView;


- (void)loadVisibleWithItem:(NSDictionary *)item
                 targetRect:(NSValue *)aTargetRect
                  cellFrame:(CGRect)aCellFrame;

@end
