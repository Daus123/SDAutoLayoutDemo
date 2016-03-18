//
//  DemoVC6.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/9.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "DemoVC6.h"

@interface DemoVC6 ()

@end

@implementation DemoVC6

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:scrollView];
    
    [scrollView sd_addSubviews:@[self.view0,self.view1,self.view2,self.view3,self.view4,self.view5,self.view6,self.view7,self.view8]];
   
    scrollView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    
    self.view0.sd_layout
    .leftSpaceToView(scrollView,20)
    .rightSpaceToView(scrollView,20)
    .topSpaceToView(scrollView,20)
    .heightIs(150);
    
    self.view1.sd_layout
    .widthIs(200)
    .heightIs(200)
    .centerXEqualToView(scrollView)
    .topSpaceToView(self.view0,20);
    
    self.view2.sd_layout
    .leftSpaceToView(scrollView,50)
    .rightSpaceToView(scrollView,50)
    .topSpaceToView(self.view1,20)
    .heightIs(150);
    
    self.view3.sd_layout
    .widthIs(250)
    .heightEqualToWidth()
    .centerXEqualToView(scrollView)
    .topSpaceToView(self.view2,20);
    
    self.view4.sd_layout
    .leftSpaceToView(scrollView,10)
    .rightSpaceToView(scrollView,10)
    .topSpaceToView(self.view3,20)
    .heightIs(400);
    
    [scrollView setupAutoContentSizeWithBottomView:self.view4 bottomMargin:20];

    self.view0.sd_cornerRadiusFromHeightRatio = @(0.5);
    self.view1.sd_cornerRadiusFromWidthRatio = @(0.5);
    self.view2.sd_cornerRadiusFromWidthRatio = @(0.5);
}




@end
