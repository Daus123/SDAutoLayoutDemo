//
//  DemoVC7Cell2.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/9.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "DemoVC7Cell2.h"
#import "UIView+SDAutoLayout.h"
@interface DemoVC7Cell2()
{
    UILabel *_titleLabel;
    NSArray *_imageViewsArray;
}

@end
@implementation DemoVC7Cell2


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
    
    UIImageView *imageView0 = [[UIImageView alloc]init];
    [self.contentView addSubview:imageView0];
    
    UIImageView *imageView1 = [[UIImageView alloc]init];
    [self.contentView addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc]init];
    [self.contentView addSubview:imageView2];
    
    imageView0.layer.borderColor = [UIColor grayColor].CGColor;
    imageView0.layer.borderWidth = 1;
    
    imageView1.layer.borderColor = [UIColor grayColor].CGColor;
    imageView1.layer.borderWidth = 1;
    
    imageView2.layer.borderColor = [UIColor grayColor].CGColor;
    imageView2.layer.borderWidth = 1;
    
    _imageViewsArray = @[imageView0,imageView1,imageView2];
    
    self.contentView.sd_equalWidthSubviews = _imageViewsArray;
    
    CGFloat margin = 15;
    
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView,margin)
    .topSpaceToView(self.contentView,margin)
    .rightSpaceToView(self.contentView,margin)
    .autoHeightRatio(0);
    
    imageView0.sd_layout
    .leftSpaceToView(self.contentView,margin)
    .topSpaceToView(_titleLabel,margin)
    .autoHeightRatio(0.8);
    
    imageView1.sd_layout
    .leftSpaceToView(imageView0,margin)
    .topEqualToView(imageView0)
    .autoHeightRatio(0.8);
    
    imageView2.sd_layout
    .leftSpaceToView(imageView1,margin)
    .topEqualToView(imageView1)
    .rightSpaceToView(self.contentView,margin)
    .autoHeightRatio(0.8);
    
    [self setupAutoHeightWithBottomView:imageView0 bottomMargin:margin];
}

-(void)setModel:(DemoVC7Model *)model
{
    _model = model;
    
    _titleLabel.text = model.title;
    
    [model.imagePathsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = _imageViewsArray[idx];
        imageView.image = [UIImage imageNamed:obj];
    }];
}

@end
