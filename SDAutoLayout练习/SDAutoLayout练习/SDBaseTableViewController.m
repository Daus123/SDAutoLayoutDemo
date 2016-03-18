//
//  SDBaseTableViewController.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/10.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "SDBaseTableViewController.h"

@interface SDBaseTableViewController ()

@end

@implementation SDBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
