//
//  MainTableViewController.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/8.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "MainTableViewController.h"

#import "UITableView+SDAutoTableViewCellHeight.h"
#import "MainCell.h"

NSString * const demo0Content = @"自动布局动画，修改一个view的布局约束，其他view也会自动重新排布";
NSString * const demo1Content = @"布局示例，其中view1用到了普通view的内容自适应功能，view1内部的label用到了文字自适应功能";
NSString * const demo2Content = @"1.设置水平方向的3个等宽子view\n2.设置一个宽高都为50的位于父view中间的view";
NSString * const demo3Content = @"简单tableview展示";
NSString * const demo4Content = @"1.行间距为8的attributedString的label\n2.类cell的自动布局展示";
NSString * const demo5Content = @"1.利用普通view的内容自适应功能添加tableheaderview\n2.利用自动布局功能实现cell内部图文排布，图片可根据原始尺寸按比例缩放后展示\n3.利用“普通版tableview的cell高度自适应”完成tableview的排布";
NSString * const demo6Content = @"展示scrollview的内容自适应和普通view的动态圆角处理";
NSString * const demo7Content = @"利用“普通版tableview的《多cell》高度自适应”2步设置完成tableview的排布";
NSString * const demo8Content = @"利用“升级版tableview的《多cell》高度自适应”1步完成tableview的排布。\n注意：升级版方法适用于cell的model有多个的情况下,性能比普通版稍微差一些,不建议在数据量大的tableview中使用（cell数量尽量少于100个）,如果有大量的cell或者cell界面复杂渲染耗费性能较大则推荐使用普通方法简化版“cellHeightForIndexPath:model:keyPath:cellClass:contentViewWidth:”方法同样是一步设置即可完成";
NSString * const demo9Content = @"利用SDAutoLayout仿制微信朋友圈。高仿微信计划：\n1.高仿朋友圈 \n2.完善细节 \n3.高仿完整微信app \nPS：代码会持续在我的github更新";
NSString * const demo10Content = @"一个SDAutoLayout使用者“李西亚”同学贡献的仿网易新闻界面";
NSString * const demo11Content = @"仿微信的聊天界面：\n1.纯文本消息（带可点击链接，表情）\n2.图片消息";

@interface MainTableViewController ()
{
    NSArray *_contentArray;
}
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _contentArray = @[demo0Content,demo1Content,demo2Content,demo3Content,demo4Content,demo5Content,demo6Content,demo7Content,demo8Content,demo9Content,demo10Content,demo11Content];
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _contentArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"text";
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.titleLabel.text = [NSString stringWithFormat:@"Demo -- %ld",indexPath.row];
    cell.contentLabel.text = _contentArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:[UIScreen mainScreen].bounds.size.width];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *demoClassString = [NSString stringWithFormat:@"DemoVC%ld",indexPath.row];
    UIViewController *vc = [NSClassFromString(demoClassString) new];
    vc.title = demoClassString;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
