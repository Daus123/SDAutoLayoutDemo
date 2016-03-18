//
//  DemoVC7Cell1.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/9.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "DemoVC7Cell1.h"
#import "UIView+SDAutoLayout.h"
@interface DemoVC7Cell1()
{
    UILabel *_titleLabel;
    UIImageView *_imageView;
}

@end
@implementation DemoVC7Cell1


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
    }
    return self;
}

-(void)setup
{
    _titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.textColor = [UIColor darkGrayColor];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.numberOfLines = 0;
    
    _imageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_imageView];
    _imageView.layer.borderColor = [UIColor grayColor].CGColor;
    _imageView.layer.borderWidth = 1;
 
    CGFloat margin = 15;
    
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView,margin)
    .topSpaceToView(self.contentView,margin)
    .rightSpaceToView(self.contentView,120)
    .autoHeightRatio(0);
    
    _imageView.sd_layout
    .leftSpaceToView(_titleLabel,margin)
    .topEqualToView(_titleLabel)
    .rightSpaceToView(self.contentView,margin)
    .heightIs(60);
    
    [self setupAutoHeightWithBottomViewsArray:@[_titleLabel,_imageView] bottomMargin:margin];
}

-(void)setModel:(DemoVC7Model *)model
{
    _model = model;
    _titleLabel.text = model.title;
    _imageView.image = [UIImage imageNamed:[model.imagePathsArray lastObject]];
}


@end
