//
//  NewsNormalCell.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/16.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "NewsNormalCell.h"

@implementation NewsNormalCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    CGFloat margin = 10;
    
    self.imgIcon.sd_layout
    .leftSpaceToView(self.contentView,margin)
    .topSpaceToView(self.contentView,margin)
    .widthIs(90)
    .heightIs(65);
    
    self.lblTitle.sd_layout
    .leftSpaceToView(self.imgIcon,margin)
    .topEqualToView(self.imgIcon)
    .rightSpaceToView(self.contentView,margin)
    .heightIs(21);
    
    self.lblSubtitle.sd_layout
    .leftSpaceToView(self.imgIcon,margin)
    .topSpaceToView(self.lblTitle,margin)
    .rightSpaceToView(self.contentView,margin)
    .autoHeightRatio(0);
    
    self.lineView.sd_layout
    .topSpaceToView(self.lblSubtitle,margin)
    .rightSpaceToView(self.contentView,0)
    .leftSpaceToView(self.contentView,0)
    .heightIs(1);
    
    [self setupAutoHeightWithBottomView:self.lineView bottomMargin:0];
}


-(void)setNewsModel:(NewsModel *)newsModel
{
    [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"303"]];
    self.lblTitle.text = newsModel.title;
    
    self.lblSubtitle.text = newsModel.digest;
}

@end
