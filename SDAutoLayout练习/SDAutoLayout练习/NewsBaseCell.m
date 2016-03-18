//
//  NewsBaseCell.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/16.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "NewsBaseCell.h"
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
@implementation NewsBaseCell

+(NSString *)cellIdentifierFowRow:(NewsModel*)newsModel
{
    if (newsModel.hasHead) {
        return @"NewsHeadCell";
    }else if (newsModel.imgType){
        return @"NewsBigImageCell";
    }else if (newsModel.imgextra){
        return @"NewsImgextraCell";
    }else{
        return @"NewsNormalCell";
    }
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgIcon = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imgIcon];
        
        self.lblTitle = [[UILabel alloc]init];
        self.lblTitle.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.lblTitle];
        
        self.lblSubtitle = [[UILabel alloc]init];
        self.lblSubtitle.font = [UIFont systemFontOfSize:13];
        self.lblSubtitle.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.lblSubtitle];
        
        self.lineView = [[UIView alloc]init];
        self.lineView.backgroundColor = rgba(238, 238, 238, 1);
        [self.contentView addSubview:self.lineView];
        
        self.imgOther1 = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imgOther1];
        
        self.imgOther2 = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imgOther2];
    }
    return self;
}

@end
