//
//  DemoVC7.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/9.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "DemoVC7.h"
#import "DemoVC7Cell1.h"
#import "DemoVC7Cell2.h"
#import "SDRefreshFooterView.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
@interface DemoVC7 ()
{
    SDRefreshFooterView *_footerView;
}
@property(nonatomic,strong)NSMutableArray *modelsArray;
@end

@implementation DemoVC7

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createModelWithCount:10];
    
    [self.tableView registerClass:[DemoVC7Cell1 class] forCellReuseIdentifier:NSStringFromClass([DemoVC7Cell1 class])];
    [self.tableView registerClass:[DemoVC7Cell2 class] forCellReuseIdentifier:NSStringFromClass([DemoVC7Cell2 class])];
    
    _footerView = [SDRefreshFooterView refreshView];
    [_footerView addToScrollView:self.tableView];
    __weak typeof(self) weakSelf = self;
    __weak typeof(_footerView) weakFooterView = _footerView;
    _footerView.beginRefreshingOperation = ^(){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf createModelWithCount:10];
            [weakSelf.tableView reloadData];
            [weakFooterView endRefreshing];
        });
 
    };
}


-(void)createModelWithCount:(NSInteger)count
{
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray new];
    }
    
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的LaunchImage 时。然后等比例拉伸",
                           @"然后等比例拉伸到大屏。屏幕宽度返回 320否则在大屏上会显得字大",
                           @"长期处于这种模式下，否则在大屏上会显得字大，内容少这种情况下对界面不会",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任小。但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。"
                           ];

    for (int i = 0; i < count; i++) {
        int iconImageIdx = arc4random_uniform(5);
        int textIndex = arc4random_uniform(5);
        
        DemoVC7Model *model = [[DemoVC7Model alloc]init];
        model.title = textArray[textIndex];
        
        int random = arc4random_uniform(100);
        if (random <= 30) {
            NSMutableArray *temp = [NSMutableArray array];
            for (int j = 0; j < 3; j++) {
                int idx = arc4random_uniform(5);
                NSString *icon = iconImageNamesArray[idx];
                [temp addObject:icon];
            }
            model.imagePathsArray = [temp copy];
        }else{
            model.imagePathsArray = @[iconImageNamesArray[iconImageIdx]];
        }
        [self.modelsArray addObject:model];
    }
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSString *identifier = NSStringFromClass([DemoVC7Cell1 class]);
    
    DemoVC7Model *model = self.modelsArray[indexPath.row];
    
    if (model.imagePathsArray.count > 1) {
        identifier = NSStringFromClass([DemoVC7Cell2 class]);
    }
    
    DemoVC7Cell1 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.model = model;
   
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    DemoVC7Model *model = self.modelsArray[indexPath.row];

    Class currentClass = [DemoVC7Cell1 class];
    if (model.imagePathsArray.count > 1) {
        currentClass = [DemoVC7Cell2 class];
    }
    
    return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:currentClass contentViewWidth:[self cellContentViewWith]];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    //适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
