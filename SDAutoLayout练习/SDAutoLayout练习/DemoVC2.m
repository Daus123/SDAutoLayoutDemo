//
//  DemoVC2.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/8.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "DemoVC2.h"

@interface DemoVC2 ()

@end

@implementation DemoVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.sd_equalWidthSubviews = @[self.view0,self.view1,self.view2];
    
    self.view0.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(self.view,100)
    .heightEqualToWidth();
    
    self.view1.sd_layout
    .leftSpaceToView(self.view0,0)
    .topEqualToView(self.view0)
    .heightEqualToWidth();
    
    self.view2.sd_layout
    .leftSpaceToView(self.view1,0)
    .topEqualToView(self.view1)
    .rightSpaceToView(self.view,0)
    .heightEqualToWidth();
    
    self.view3.sd_layout
    .centerXEqualToView(self.view)
    .centerYEqualToView(self.view)
    .widthIs(50)
    .heightEqualToWidth();
}




@end
