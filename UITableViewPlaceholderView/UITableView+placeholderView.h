//
//  UITableView+placeholderView.h
//  UITableViewPlaceholderView
//
//  Created by 崔志伟 on 2018/5/31.
//  Copyright © 2018年 崔志伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (placeholderView)
@property (nonatomic,strong) UIView * placeholderView ;
/**
 是否加载完数据
 */
@property (nonatomic,assign) BOOL  isLoadEndData  ;

@end

