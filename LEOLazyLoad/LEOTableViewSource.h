//
//  LEOTableViewSource.h
//  LEOLazyLoad
//
//  Created by Leon on 17/3/27.
//  Copyright © 2017年 大途弘安. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class LEOImageCell;

typedef void(^LEOTableViewCellConfigBlock)(id cell, id item, NSIndexPath *indexPath);

@interface LEOTableViewSource : NSObject<UITableViewDataSource>


- (instancetype)initWithSourceData:(NSArray *)sourceData
                    cellIdentifier:(NSString *)aCellIdentifier
                configureCellBlock:(LEOTableViewCellConfigBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
@end
