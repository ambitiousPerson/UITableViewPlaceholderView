//
//  UITableView+placeholderView.m
//  UITableViewPlaceholderView
//
//  Created by 崔志伟 on 2018/5/31.
//  Copyright © 2018年 崔志伟. All rights reserved.
//

#import "UITableView+placeholderView.h"
#import <objc/runtime.h>

static NSString *const placeholderViewKey = @"WG_PlaceholderViewKey";

static NSString *const isLoadEndDataKey = @"WG_isLoadEndDataKey";

@implementation NSObject (swizzle)

/**
 交换方法
 @param originalSel 原来的方法
 @param swizzledSel 需要交换为的方法
 */
+ (void)swizzleInstanceSelector:(SEL)originalSel
           WithSwizzledSelector:(SEL)swizzledSel {
    Method  originalMethod = class_getInstanceMethod(self, originalSel);
    
    Method swizzledMethod =  class_getInstanceMethod(self, swizzledSel);
    //   如果发现方法已经存在，返回NO，也可以用来做检查用,我们这里是为了避免源方法没有实现的情况;如果方法没有存在,我们则先尝试添加被替换的方法的实现
    
    BOOL methodIsAdd = class_addMethod(self, originalSel,method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (methodIsAdd) {
        class_replaceMethod(self, swizzledSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
        
    }
}
@end

@implementation UITableView (placeholderView)

+(void)load{
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        [self swizzleInstanceSelector:@selector(reloadData) WithSwizzledSelector:@selector(wg_ReloadData)];
    });
}
-(void)wg_ReloadData{
    [self wg_DataEmpty];
    [self wg_ReloadData];
}

- (void)setPlaceholderView:(UIView *)placeholderView{
    objc_setAssociatedObject(self, (__bridge const void *)(placeholderViewKey), placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)placeholderView{
    return  objc_getAssociatedObject(self, (__bridge const void *)(placeholderViewKey));
}

- (void)setIsLoadEndData:(BOOL)isLoadEndData{
    
    objc_setAssociatedObject(self, (__bridge const void *)(isLoadEndDataKey), [NSNumber numberWithBool:isLoadEndData], OBJC_ASSOCIATION_ASSIGN);
    
}


- (BOOL)isLoadEndData{
    return  ((NSNumber*)objc_getAssociatedObject(self, (__bridge const void *)(isLoadEndDataKey))).boolValue;
}

- (void)wg_DataEmpty{
    
    BOOL isEmpty = YES;
    id <UITableViewDataSource> ds = self.dataSource;
    NSInteger sections = 1;
    if ([ds respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [ds numberOfSectionsInTableView:self];
    }
    for (NSInteger i  = 0; i < sections; i++ ) {
        NSInteger rows  =  [ds tableView:self numberOfRowsInSection:i];
        if (rows) {
            isEmpty = NO;
        }
    }
    
    if (isEmpty&&self.isLoadEndData) {
        [self.placeholderView removeFromSuperview];
        [self addSubview:self.placeholderView];
    }else{
        [self.placeholderView removeFromSuperview];
    }
}
@end

