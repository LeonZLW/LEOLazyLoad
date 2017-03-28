//
//  LEOTableViewSource.m
//  LEOLazyLoad
//
//  Created by Leon on 17/3/27.
//  Copyright © 2017年 大途弘安. All rights reserved.
//

#import "LEOTableViewSource.h"

@interface LEOTableViewSource ()
@property (nonatomic, copy) NSArray *sourceData;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) LEOTableViewCellConfigBlock configureCellBlock;

@end

@implementation LEOTableViewSource

- (instancetype)initWithSourceData:(NSArray *)sourceData
                    cellIdentifier:(NSString *)aCellIdentifier
                configureCellBlock:(LEOTableViewCellConfigBlock)aConfigureCellBlock {
    
    if (self = [super init]) {
        self.sourceData = sourceData;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = aConfigureCellBlock;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sourceData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell,item,indexPath);
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.sourceData[indexPath.row];
}


@end
