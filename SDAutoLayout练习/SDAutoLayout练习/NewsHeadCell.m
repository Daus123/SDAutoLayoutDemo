//
//  NewsHeadCell.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/16.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "NewsHeadCell.h"
#import "Ads.h"
@interface NewsBaseCell()<SDCycleScrollViewDelegate>

@end
@implementation NewsHeadCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
    }
    return self;
}

-(void)setup
{
    self.cycelScrollView = [[SDCycleScrollView alloc]init];
    [self.contentView addSubview:self.cycelScrollView];
    
    self.cycelScrollView.sd_layout
    .topSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .leftSpaceToView(self.contentView,0)
    .heightIs(175);
    
    [self setupAutoHeightWithBottomView:self.cycelScrollView bottomMargin:0];
}

-(void)setNewsModel:(NewsModel *)newsModel
{
    NSMutableArray *imageURLStrings = [NSMutableArray array];
    NSMutableArray *titles = [NSMutableArray array];
    [newsModel.ads enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Ads *ads = obj;
        [imageURLStrings addObject:ads.imgsrc];
        [titles addObject:ads.title];
    }];
    
    self.cycelScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycelScrollView.pageControlStyle =  SDCycleScrollViewPageContolStyleClassic;
    self.cycelScrollView.delegate = self;
    self.cycelScrollView.titlesGroup = titles;
    self.cycelScrollView.imageURLStringsGroup = imageURLStrings;
    self.cycelScrollView.currentPageDotColor = [UIColor whiteColor];
    self.cycelScrollView.placeholderImage = [UIImage imageNamed:@"303"];

    
}

@end
