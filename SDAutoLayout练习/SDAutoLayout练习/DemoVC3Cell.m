//
//  DemoVC3Cell.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/8.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "DemoVC3Cell.h"
#import "UIView+SDAutoLayout.h"
#define margin 10
@interface DemoVC3Cell()
{
    UIView *_view0;
    UIView *_view1;
    UILabel *_view2;
    UILabel *_view3;
    UIView *_view4;
    UIView *_view5;


}

@end
@implementation DemoVC3Cell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *view0 = [[UIImageView alloc]init];
        view0.backgroundColor = [UIColor redColor];
        _view0 = view0;
        
        UIView *view1 = [[UIView alloc]init];
        view1.backgroundColor = [UIColor grayColor];
        _view1 = view1;
        
        UILabel *view2 =[[UILabel alloc]init];
        view2.backgroundColor = [UIColor brownColor];
        _view2 = view2;
        
        UILabel *view3 =[[UILabel alloc]init];
        view3.backgroundColor = [UIColor orangeColor];
        _view3 = view3;
        
        UIView *view4 = [[UIView alloc]init];
        view4.backgroundColor = [UIColor purpleColor];
        _view4 = view4;
        
        UIView *view5 = [[UIView alloc]init];
        view5.backgroundColor = [UIColor yellowColor];
        _view5 = view5;
        
        [self.contentView sd_addSubviews:@[_view0,_view1,_view2,_view3,_view4,_view5]];
        
        _view0.sd_layout
        .leftSpaceToView(self.contentView,margin)
        .topSpaceToView(self.contentView,margin)
        .widthIs(50)
        .heightEqualToWidth();
        
        _view1.sd_layout
        .leftSpaceToView(_view0,margin)
        .topEqualToView(_view0)
        .rightSpaceToView(self.contentView,margin)
        .heightRatioToView(_view0,0.4);
        
        _view2.sd_layout
        .leftEqualToView(_view1)
        .topSpaceToView(_view1,margin)
        .rightSpaceToView(self.contentView,60)
        .autoHeightRatio(0);
        
        _view3.sd_layout
        .leftSpaceToView(_view2,margin)
        .topEqualToView(_view2)
        .rightEqualToView(_view1)
        .heightRatioToView(_view2,1);
        
        _view4.sd_layout
        .leftEqualToView(_view2)
        .topSpaceToView(_view2,margin)
        .heightIs(30)
        .widthRatioToView(_view1,0.7);
        
        _view5.sd_layout
        .leftSpaceToView(_view4,margin)
        .topEqualToView(_view4)
        .rightEqualToView(_view3)
        .bottomEqualToView(_view4);
        
        [self setupAutoHeightWithBottomView:_view4 bottomMargin:margin];
    }
    return self;
}

-(void)setText:(NSString *)text
{
    _text = [text copy];
    _view2.text = text;
}

@end
