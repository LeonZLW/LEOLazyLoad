//
//  ViewController.m
//  LEOLazyLoad
//
//  Created by Leon on 17/3/27.
//  Copyright © 2017年 大途弘安. All rights reserved.
//

#import "LEOViewController.h"
#import "LEOTableViewSource.h"
#import "UIViewController+LEOCellTargetRect.h"
#import "LEOImageCell.h"

#import <SDImageCache.h>

@interface LEOViewController ()<UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *showImageTableView;
@property (nonatomic, strong) LEOTableViewSource *leoTableViewSource;
@property (nonatomic, copy) NSArray *imageSource;

@end

@implementation LEOViewController

- (void)dealloc {
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadTableView];
    
}

- (void)loadTableView {
    
    __weak typeof(self) weakSelf = self;
    LEOTableViewCellConfigBlock configCellBlock = ^(LEOImageCell *cell, NSDictionary *itemDic,NSIndexPath *currentIndexPath) {
        
        CGRect cellFrame = [weakSelf.showImageTableView rectForRowAtIndexPath:currentIndexPath];
        
        [cell loadVisibleWithItem:itemDic targetRect:weakSelf.targetRect cellFrame:cellFrame];
    };
    
    self.leoTableViewSource = [[LEOTableViewSource alloc]initWithSourceData:self.imageSource cellIdentifier:@"LEOImageCell" configureCellBlock:configCellBlock];
    
    self.showImageTableView.delegate = self;
    self.showImageTableView.dataSource = _leoTableViewSource;
    
    // 由于每一个页面的数据都不相同,所以数据方面的处理放在block中进行
    [self lvh_loadVisibleCellHandle:^(UITableView *tableView) {
        
        NSArray *visibleCells = [tableView visibleCells];
        for (LEOImageCell *cell in visibleCells) {
            
            NSIndexPath *indexPath = [tableView indexPathForCell:cell];
            NSDictionary *itemDic = weakSelf.imageSource[indexPath.row];
            CGRect cellFrame = [weakSelf.showImageTableView rectForRowAtIndexPath:indexPath];
            [cell loadVisibleWithItem:itemDic targetRect:weakSelf.targetRect cellFrame:cellFrame];
        }
    }];
}


- (NSArray *)imageSource {
    if (!_imageSource) {
        
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LEOImageSource" ofType:@"json"]];
        NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
        _imageSource = [NSArray arrayWithArray:dataArray];
    }
    return _imageSource;
}

@end
