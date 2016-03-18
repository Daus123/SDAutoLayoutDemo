//
//  DemoVC4.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/8.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "DemoVC4.h"

@interface DemoVC4 ()

@end

@implementation DemoVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.view0.sd_layout
    .leftSpaceToView(self.view,20)
    .topSpaceToView(self.view,80)
    .widthIs(50)
    .heightIs(50);
    
    self.view1.sd_layout
    .leftSpaceToView(self.view0,20)
    .topEqualToView(self.view0)
    .rightSpaceToView(self.view,20)
    .heightRatioToView(self.view0,0.4);
    
    self.view2.sd_layout
    .leftEqualToView(self.view1)
    .topSpaceToView(self.view1,20)
    .widthRatioToView(self.view1,0.45)
    .heightIs(30);
    
    self.view3.sd_layout
    .leftSpaceToView(self.view2,10)
    .topEqualToView(self.view2)
    .rightEqualToView(self.view1)
    .heightRatioToView(self.view2,1);
    
    self.view4.sd_layout
    .leftEqualToView(self.view2)
    .topSpaceToView(self.view2,20)
    .widthRatioToView(self.view1,0.7)
    .heightIs(30);
    
    self.view5.sd_layout
    .leftSpaceToView(self.view4,10)
    .topEqualToView(self.view4)
    .rightEqualToView(self.view3)
    .heightRatioToView(self.view4,1);
    
    //  --------- attributedString测试：行间距为8 ---------------------------
    
    NSString *text = @"attributedString测试：行间距为8。彩虹网络卡福利费绿调查开房；卡法看得出来分开了的出口来反馈率打开了房；快烦死了；了； 调查开房；；v单纯考虑分离开都快来反馈来看发v离开的积分房积分jdhflgfkkvvm.cm。";
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    [paragraph setLineSpacing:10];
    UIColor *color = [UIColor blackColor];
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:text attributes:@{NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:paragraph}];
    UILabel *label =[[UILabel alloc]init];
    [self.view addSubview:label];
    label.backgroundColor = [UIColor brownColor];
    label.attributedText = string;
    
    label.sd_layout
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,10)
    .topSpaceToView(self.view4,10)
    .autoHeightRatio(0);
    
    label.isAttributedContent = YES;
}




@end
