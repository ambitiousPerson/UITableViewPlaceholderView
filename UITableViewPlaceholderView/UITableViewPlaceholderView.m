//
//  UITableViewPlaceholderView.m
//  UITableViewPlaceholderView
//
//  Created by 崔志伟 on 2018/5/31.
//  Copyright © 2018年 崔志伟. All rights reserved.
//

#import "UITableViewPlaceholderView.h"

@implementation UITableViewPlaceholderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self  = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        
        UILabel *content = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 20)];
        content.textAlignment =  NSTextAlignmentCenter;
        content.text  = @"占位图";
        content.center = CGPointMake(self.center.x, self.center.y);
        [self addSubview:content];
        
    }
    return self;
}

@end
