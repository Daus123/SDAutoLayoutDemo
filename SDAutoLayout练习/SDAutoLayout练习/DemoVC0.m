//
//  DemoVC0.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/8.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "DemoVC0.h"

#define kTimeInterval 0.8
@interface DemoVC0 ()
{
    NSTimer *_timer;
    CGFloat _widthRatio;
}
@end

@implementation DemoVC0

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _widthRatio = 0.4;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(animation) userInfo:nil repeats:YES];
    
    self.view0.sd_layout
    .leftSpaceToView(self.view,20)
    .topSpaceToView(self.view,80)
    .widthRatioToView(self.view,_widthRatio)
    .heightIs(130);
    
    self.view1.sd_layout
    .leftSpaceToView(self.view0,10)
    .topEqualToView(self.view0)
    .widthRatioToView(self.view0,0.5)
    .heightIs(60);
    
    self.view2.sd_layout
    .leftSpaceToView(self.view1,10)
    .topEqualToView(self.view1)
    .widthIs(50)
    .heightRatioToView(self.view1,1);
    
    self.view3.sd_layout
    .leftEqualToView(self.view1)
    .topSpaceToView(self.view1,10)
    .widthRatioToView(self.view0,0.5)
    .heightIs(60);
    
    self.view4.sd_layout
    .leftSpaceToView(self.view3,10)
    .topEqualToView(self.view3)
     .widthRatioToView(self.view2, 1)
    .heightRatioToView(self.view3,1);
    
    [self.view0 addSubview:self.view5];
    
    self.view5.sd_layout
    .centerYEqualToView(self.view0)
    .rightSpaceToView(self.view0,10)
    .widthRatioToView(self.view0,0.5)
    .heightIs(20);
    
    
}

-(void)animation
{
    if (_widthRatio == 0.4) {
        _widthRatio = 0.1;
    }else{
        _widthRatio = 0.4;
    }
    [UIView animateWithDuration:kTimeInterval animations:^{
       self.view0.sd_layout
        .widthRatioToView(self.view,_widthRatio);
        [self.view0 updateLayout];
        [self.view5 updateLayout];
    }];
    
}


@end
