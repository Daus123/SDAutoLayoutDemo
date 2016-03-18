//
//  NewsBigImage.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/16.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "NewsBigImageCell.h"

@implementation NewsBigImageCell

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
    
    self.lblTitle.sd_layout
    .leftSpaceToView(self.contentView,margin)
    .topSpaceToView(self.contentView,margin)
    .rightSpaceToView(self.contentView,margin)
    .heightIs(21);
    
    self.imgIcon.sd_layout
    .topSpaceToView(self.lblTitle,margin)
    .leftSpaceToView(self.contentView,margin)
    .rightSpaceToView(self.contentView,margin)
    .heightIs(130);
    
    self.lblSubtitle.sd_layout
    .topSpaceToView(self.imgIcon,margin)
    .leftSpaceToView(self.contentView,margin)
    .rightSpaceToView(self.contentView,margin)
    .heightIs(21);
    
    self.lineView.sd_layout
    .topSpaceToView(self.lblSubtitle,margin)
    .rightSpaceToView(self.contentView,0)
    .leftSpaceToView(self.contentView,0)
    .heightIs(1);
    
    [self setupAutoHeightWithBottomView:self.lineView bottomMargin:0];
}

-(void)setNewsModel:(NewsModel *)newsModel
{
    self.lblTitle.text = newsModel.title;
    self.lblSubtitle.text = newsModel.digest;
    [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"303"]];
}
@end
