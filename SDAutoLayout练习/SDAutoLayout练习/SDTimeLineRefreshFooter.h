//
//  SDTimeLineRefreshFooter.h
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/10.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "SDBaseRefreshView.h"

@interface SDTimeLineRefreshFooter : SDBaseRefreshView


+ (instancetype)refreshFooterWithRefreshingTest:(NSString*)text;

-(void)addToScrollView:(UIScrollView*)scrollView refreshOpration:(void(^)())refresh;

@property(nonatomic, strong)UILabel *indicatorLabel;
@property(nonatomic, strong)UIActivityIndicatorView *indicator;

@property(nonatomic,copy)void (^refreshBlock)();

@end
