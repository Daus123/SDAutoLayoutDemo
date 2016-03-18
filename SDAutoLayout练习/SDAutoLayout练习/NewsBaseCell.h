//
//  NewsBaseCell.h
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/16.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SDAutoLayout.h"
#import "UIImageView+WebCache.h"
#import "SDCycleScrollView.h"
#import "NewsModel.h"

@interface NewsBaseCell : UITableViewCell

/**
 *  图片
 */
@property (nonatomic, strong) UIImageView *imgIcon;

/**
 *  标题
 */
@property (nonatomic, strong) UILabel *lblTitle;

/**
 *  描述
 */
@property (nonatomic, strong) UILabel *lblSubtitle;

/**
 *  第二张图片
 */
@property (nonatomic, strong) UIImageView *imgOther1;

/**
 *  第三张图片
 */
@property (nonatomic, strong) UIImageView *imgOther2;

/**
 *  底部分界线
 */
@property (nonatomic, strong) UIView *lineView;

/**
 *  滚动图片区
 */
@property (nonatomic, strong) SDCycleScrollView *cycelScrollView;
/**
 *  数据模型
 */
@property (nonatomic, strong) NewsModel *newsModel;

+(NSString *)cellIdentifierFowRow:(NewsModel*)newsModel;
@end
