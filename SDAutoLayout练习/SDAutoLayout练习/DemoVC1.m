//
//  DemoVC1.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/8.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "DemoVC1.h"

@interface DemoVC1 ()

@end

@implementation DemoVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view0.sd_layout
    .leftSpaceToView(self.view,10)
    .topSpaceToView(self.view,20)
    .widthIs(50)
    .heightIs(50);
    
    self.view1.sd_layout
    .leftSpaceToView(self.view0,10)
    .topEqualToView(self.view0)
    .rightSpaceToView(self.view,30);
    
    self.view2.sd_layout
    .rightSpaceToView(self.view,10)
    .topSpaceToView(self.view1,20)
    .widthIs(50)
    .heightIs(50);
    
    self.view3.sd_layout
    .topEqualToView(self.view2)
    .leftSpaceToView(self.view,30)
    .heightRatioToView(self.view,0.2)
    .rightSpaceToView(self.view2,10);
    
    self.view4.sd_layout
    .leftEqualToView(self.view0)
    .topSpaceToView(self.view3,20)
    .heightRatioToView(self.view0,1)
    .widthRatioToView(self.view0,1);
    
    self.view5.sd_layout
    .leftEqualToView(self.view1)
    .rightEqualToView(self.view1)
    .topEqualToView(self.view4)
    .bottomSpaceToView(self.view,20);

    UILabel *testLabel = [[UILabel alloc]init];
    UIView *testView = [[UIView alloc]init];
    [self.view1 addSubview:testLabel];
    [self.view1 addSubview:testView];
    
    testLabel.backgroundColor = [UIColor purpleColor];
    testView.backgroundColor = [UIColor orangeColor];
     testLabel.text = @"edflgjl;ijf;iljd;lid;lij;lfk;lknsdfhfg;ljhl;sfdj;oid;lij;lfk;lknsdfhfg;ljhl;sfdj;oij;lfk;lknsdfhfg;ljhl;sfdj;oigfj;jgf;lfgjrlkfewiorrgi";
    
    testLabel.sd_layout
    .leftSpaceToView(self.view1,10)
    .topSpaceToView(self.view1,10)
    .rightSpaceToView(self.view1,10)
    .autoHeightRatio(0);
    
    testView.sd_layout
    .leftEqualToView(testLabel)
    .topSpaceToView(testLabel,10)
    .rightEqualToView(testLabel)
    .heightIs(30);
    
    [self.view1 setupAutoHeightWithBottomView:testView bottomMargin:10];
    
}





@end
