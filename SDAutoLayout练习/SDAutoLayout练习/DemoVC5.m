//
//  DemoVC5.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/8.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "DemoVC5.h"
#import "DemoVC5Cell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "SDCycleScrollView.h"
#import "SDRefreshFooterView.h"
@interface DemoVC5 ()
{
    SDRefreshFooterView *_refreshFooter;

}
@property (nonatomic, strong) NSMutableArray *modelsArray;

@end

@implementation DemoVC5

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //头部
    [self setupHeaderView];
    
    //创建10条数据
    [self creatModelsWithCount:10];
    
    __weak typeof(self) weakSelf = self;
    _refreshFooter = [SDRefreshFooterView refreshView];
    [_refreshFooter addToScrollView:self.tableView];
    __weak typeof(_refreshFooter) weakRefreshFooter = _refreshFooter;
    _refreshFooter.beginRefreshingOperation = ^(){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf creatModelsWithCount:10];
        [weakSelf.tableView reloadData];
        [weakRefreshFooter endRefreshing];
    });
    };
}


-(void)setupHeaderView
{
    UIView *header = [[UIView alloc]init];
    
    NSArray *picImageNamesArray = @[ @"pic1.jpg",
                                     @"pic2.jpg",
                                     @"pic3.jpg",
                                     @"pic4.jpg",
                                     ];
    SDCycleScrollView *scrollView = [[SDCycleScrollView alloc]init];
    scrollView.localizationImageNamesGroup = picImageNamesArray;
    [header addSubview:scrollView];
    
    UILabel *updateTimeLabel = [[UILabel alloc]init];
    updateTimeLabel.font = [UIFont systemFontOfSize:13];
    updateTimeLabel.textColor = [UIColor lightGrayColor];
    updateTimeLabel.text = @"更新时间：2016.03.09";
    [header addSubview:updateTimeLabel];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3 ];
    [header addSubview:bottomLine];
    
    scrollView.sd_layout
    .leftSpaceToView(header,0)
    .topSpaceToView(header,0)
    .rightSpaceToView(header,0)
    .heightIs(150);
    
    updateTimeLabel.sd_layout
    .leftSpaceToView(header,10)
    .topSpaceToView(scrollView,0)
    .rightSpaceToView(header,0)
    .heightIs(25);
    
    bottomLine.sd_layout
    .leftSpaceToView(header,0)
    .topSpaceToView(updateTimeLabel,0)
    .rightSpaceToView(header,0)
    .heightIs(1);
    
    [header setupAutoHeightWithBottomView:bottomLine bottomMargin:0];
    [header layoutIfNeeded];
    
    self.tableView.tableHeaderView = header;
}

-(void)creatModelsWithCount:(NSInteger)count
{
    if (!self.modelsArray) {
        self.modelsArray = [[NSMutableArray alloc]init];
    }
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"GSD_iOS",
                            @"风口上的猪",
                            @"当今世界网名都不好起了",
                            @"我叫郭德纲",
                            @"Hello Kitty"];
    
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
    NSArray *picImageNamesArray = @[ @"pic0.jpg",
                                     @"pic1.jpg",
                                     @"pic2.jpg",
                                     @"pic3.jpg",
                                     @"pic4.jpg",
                                     ];
    
    for (int i = 0; i < count; i++) {
        int iconImageIndex = arc4random_uniform(5);
        int nameIndex = arc4random_uniform(5);
        int textIndex = arc4random_uniform(5);
        int picImageIndex = arc4random_uniform(5);
        
        
        DemoVC5Model *model = [[DemoVC5Model alloc]init];
        model.iconName = iconImageNamesArray[iconImageIndex];
        model.name = namesArray[nameIndex];
        model.content = textArray[textIndex];
        // 模拟“有或者无图片”
        int  random = arc4random_uniform(100);
        if (random <= 80) {
            model.pickName = picImageNamesArray[picImageIndex];
        }
        [self.modelsArray addObject:model];
    }
}



#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cellID";
    DemoVC5Cell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[DemoVC5Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.model = self.modelsArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DemoVC5Model *model = self.modelsArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[DemoVC5Cell class] contentViewWidth:[self cellContentViewWith]];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}





@end
