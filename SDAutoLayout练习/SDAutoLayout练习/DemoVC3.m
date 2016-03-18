//
//  DemoVC3.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/8.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "DemoVC3.h"

#import "DemoVC3Cell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "SDRefresh.h"

@interface DemoVC3 ()
{
    NSArray *_textArray;
    SDRefreshFooterView *_refreshFooter;
}
@end

@implementation DemoVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rowCount = 10;
    
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下，"
                           ];
    _textArray = textArray;
    
    __weak typeof(self) weakSelf = self;
    
    
    
    //上拉加载
    _refreshFooter = [SDRefreshFooterView refreshView];
    [_refreshFooter addToScrollView:self.tableView];
    __weak typeof(_refreshFooter) weakReFresh = _refreshFooter;
    _refreshFooter.beginRefreshingOperation = ^(){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.rowCount += 10;
            [weakSelf.tableView reloadData];
            [weakReFresh endRefreshing];
        });
    };
    
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rowCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    int index = indexPath.row % 5;
    static NSString *ID = @"test";
    DemoVC3Cell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[DemoVC3Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.text = _textArray[index];
    
   
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = indexPath.row % 5;
    NSString *text = _textArray[index];
    return [self.tableView cellHeightForIndexPath:indexPath model:text keyPath:@"text" cellClass:[DemoVC3Cell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
}


@end
