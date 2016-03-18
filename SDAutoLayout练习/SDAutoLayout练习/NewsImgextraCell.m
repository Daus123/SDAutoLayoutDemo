//
//  newsImgextraCell.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/16.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "NewsImgextraCell.h"
#import "Imgextra.h"
@implementation NewsImgextraCell

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
    
    self.contentView.sd_equalWidthSubviews = @[self.imgIcon,self.imgOther1,self.imgOther2];
    
    self.imgIcon.sd_layout
    .leftSpaceToView(self.contentView,margin)
    .topSpaceToView(self.lblTitle,margin)
    .autoHeightRatio(0.75);
    
    self.imgOther1.sd_layout
    .leftSpaceToView(self.imgIcon,margin)
    .topEqualToView(self.imgIcon)
    .autoHeightRatio(0.75);
    
    self.imgOther2.sd_layout
    .leftSpaceToView(self.imgOther1,margin)
    .topEqualToView(self.imgOther1)
    .rightSpaceToView(self.contentView,margin)
    .autoHeightRatio(0.75);
    
    self.lineView.sd_layout
    .topSpaceToView(self.imgIcon,margin)
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(1);
    
    [self setupAutoHeightWithBottomView:self.lineView bottomMargin:0];
    
}


-(void)setNewsModel:(NewsModel *)newsModel
{
    self.lblTitle.text = newsModel.title;
    [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"303"]];
    Imgextra *imgextra1= newsModel.imgextra[0];
    Imgextra *imgextra2 = newsModel.imgextra[1];
    [self.imgOther1 sd_setImageWithURL:[NSURL URLWithString:imgextra1.imgsrc] placeholderImage:[UIImage imageNamed:@"303"]];
    [self.imgOther2 sd_setImageWithURL:[NSURL URLWithString:imgextra2.imgsrc] placeholderImage:[UIImage imageNamed:@"303"]];

}

@end
