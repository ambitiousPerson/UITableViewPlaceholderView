//
//  ViewController.m
//  UITableViewPlaceholderView
//
//  Created by 崔志伟 on 2018/5/31.
//  Copyright © 2018年 崔志伟. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+placeholderView.h"
#import "UITableViewPlaceholderView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) BOOL  isNormal ;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isNormal = YES;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    UITableViewPlaceholderView *placeholderView = [[UITableViewPlaceholderView alloc]initWithFrame:self.view.bounds];
    self.tableView.placeholderView = placeholderView;
}

#pragma mark == UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isNormal){
        return 20;
    }else{
        return 0;
    }
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

- (IBAction)valueChangedAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex ==0) {
        self.isNormal = YES;
    }else{
        self.isNormal = NO;
    }
    [self.tableView reloadData];
}


@end
