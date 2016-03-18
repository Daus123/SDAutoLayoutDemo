//
//  DemoVC10.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/16.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "DemoVC10.h"
#include "AFNetworking.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "XYString.h"

#import "NewsBaseCell.h"
@interface DemoVC10()

@property(nonatomic, strong) UITableView *tv;

@property(nonatomic, strong) NSMutableArray *listArray;

@property(nonatomic, assign) NSInteger page;

@property(nonatomic, strong) MJRefreshComponent *myRefreshView;
@end
@implementation DemoVC10

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.tv];
    self.tv.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
}

-(NSMutableArray *)listArray
{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

-(UITableView *)tv
{
    if (!_tv) {
        _tv = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tv.separatorColor = [UIColor clearColor];
        _tv.delegate = self;
        _tv.dataSource = self;
        
        __weak typeof(self) weakSelf = self;
        _tv.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.myRefreshView = weakSelf.tv.header;
            weakSelf.page = 0;
            [weakSelf loadData];
        }];
        
        [_tv.header beginRefreshing];
        
        _tv.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.myRefreshView = weakSelf.tv.footer;
            weakSelf.page = weakSelf.page + 10;
            [weakSelf loadData];
        }];
        _tv.footer.hidden = YES;
    }
    return _tv;
    
}

-(void)loadData
{
    NSString * urlString = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/%ld-20.html",@"headline/T1348647853363",self.page];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dict = [XYString getObjectFromJsonString:operation.responseString];

        NSString *key = [dict.keyEnumerator nextObject];
        
        NSArray *tempArray = dict[key];
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithArray:[NewsModel mj_objectArrayWithKeyValuesArray:tempArray]];
        
        if (self.myRefreshView == _tv.header) {
            self.listArray = arrayM;
            _tv.footer.hidden = self.listArray.count == 0? YES:NO;
        }else if (self.myRefreshView == _tv.footer){
            [self.listArray addObjectsFromArray:arrayM];
        }
        
        [self doneWithView:self.myRefreshView];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
         [_myRefreshView endRefreshing];
    }];
}

-(void)doneWithView:(MJRefreshComponent*)refreshView
{
    [_tv reloadData];
    [_myRefreshView endRefreshing];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = self.listArray[indexPath.row];
    
    NSString *classString = [NewsBaseCell cellIdentifierFowRow:model];
    
    Class mClass = NSClassFromString(classString);
    
    NewsBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:classString];
    
    if (!cell) {
        cell = [[mClass alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classString];
    }
    cell.newsModel = model;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = self.listArray[indexPath.row];
    
    NSString *classString = [NewsBaseCell cellIdentifierFowRow:model];
    Class mclass = NSClassFromString(classString);
    
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"NewsModel" cellClass:mclass contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    
}



@end
