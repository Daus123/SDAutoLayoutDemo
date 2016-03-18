//
//  SDTimeLineRefreshHeader.h
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/10.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "SDBaseRefreshView.h"

@interface SDTimeLineRefreshHeader : SDBaseRefreshView

+ (instancetype)refreshHeaderWithCenter:(CGPoint)center;

@property (nonatomic, copy) void(^refreshingBlock)();


@end
