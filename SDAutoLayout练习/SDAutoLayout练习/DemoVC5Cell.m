//
//  DemoVC5Cell.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/8.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "DemoVC5Cell.h"
@interface DemoVC5Cell()
{
    UIImageView *_view0;
    UILabel *_view1;
    UILabel *_view2;
    UIImageView *_view3;
    UILabel *_view4;
}

@end
@implementation DemoVC5Cell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}


-(void)setup
{
    UIImageView *view0 = [[UIImageView alloc]init];
    view0.backgroundColor = [UIColor redColor];
    _view0 = view0;
    
    UILabel *view1 = [[UILabel alloc]init];
    view1.textColor = [UIColor lightGrayColor];
    view1.font = [UIFont systemFontOfSize:16];
    _view1 = view1;
    
    UILabel *view2 = [[UILabel alloc]init];
    view2.textColor = [UIColor grayColor];
    view2.font = [UIFont systemFontOfSize:16];
    _view2 = view2;
    
    UIImageView *view3 = [[UIImageView alloc]init];
    view3.backgroundColor = [UIColor orangeColor];
    _view3 = view3;
    
    UILabel *view4 = [[UILabel alloc]init];
    view4.textColor = [UIColor whiteColor];
    view4.backgroundColor = [UIColor lightGrayColor];
    view4.text = @"纯文本";
    view4.font = [UIFont systemFontOfSize:13];
    _view4 = view4;
    
    [self.contentView sd_addSubviews:@[view0,view1,view2,view3,view4]];
    
    _view0.sd_layout
    .widthIs(40)
    .heightIs(40)
    .topSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,10);
    
    _view1.sd_layout
    .topEqualToView(_view0)
    .leftSpaceToView(_view0,10)
    .heightRatioToView(_view0,0.4);
    
    _view2.sd_layout
    .topSpaceToView(_view1,10)
    .leftEqualToView(_view1)
    .rightSpaceToView(self.contentView,10)
    .autoHeightRatio(0);
    
    _view3.sd_layout
    .leftEqualToView(_view2)
    .topSpaceToView(_view2,10)
    .widthRatioToView(_view2,0.7);
    
    _view4.sd_layout
    .centerYEqualToView(_view1)
    .leftSpaceToView(_view1,10)
    .heightIs(20);
    
    [_view4 setSingleLineAutoResizeWithMaxWidth:50];
    
    _view0.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    [_view1 setSingleLineAutoResizeWithMaxWidth:200];
}


-(void)setModel:(DemoVC5Model *)model
{
    _model = model;
    
    _view0.image = [UIImage imageNamed:model.iconName];
    
    _view1.text = model.name;
    
    [_view1 sizeToFit];
    
    _view2.text = model.content;
    
    CGFloat bottomMargin = 0;
    
    UIImage *pic = [UIImage imageNamed:model.pickName];
    
    if (pic.size.width > 0) {
        CGFloat scale = pic.size.height / pic.size.width;
        _view3.sd_layout.autoHeightRatio(scale);
        _view3.image = pic;
        bottomMargin = 10;
        _view4.hidden = YES;
    }else{
        _view3.sd_layout.autoHeightRatio(0);
        _view4.hidden = NO;
    }
    [self setupAutoHeightWithBottomView:_view3 bottomMargin:bottomMargin];
}

@end
