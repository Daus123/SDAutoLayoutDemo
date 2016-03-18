//
//  ViewController.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/8.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}


-(void)setupView
{
    UIView *view0 = [[UIView alloc]init];
    view0.backgroundColor = [UIColor redColor];
    self.view0 = view0;
    
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor grayColor];
    self.view1 = view1;
    
    UIView *view2 = [[UIView alloc]init];
    view2.backgroundColor = [UIColor brownColor];
    self.view2 = view2;
    
    UIView *view3 = [[UIView alloc]init];
    view3.backgroundColor = [UIColor orangeColor];
    self.view3 = view3;
    
    UIView *view4 = [[UIView alloc]init];
    view4.backgroundColor = [UIColor purpleColor];
    self.view4 = view4;
    
    UIView *view5 = [[UIView alloc]init];
    view5.backgroundColor = [UIColor yellowColor];
    self.view5 = view5;
    
    UIView *view6 = [[UIView alloc]init];
    view6.backgroundColor = [UIColor cyanColor];
    self.view6 = view6;
    
    UIView *view7 = [[UIView alloc]init];
    view7.backgroundColor = [UIColor magentaColor];
    self.view7 = view7;
    
    UIView *view8 = [[UIView alloc]init];
    view8.backgroundColor = [UIColor blackColor];
    self.view8 = view8;
    
    [self.view sd_addSubviews:@[view0,view1,view2,view3,view4,view5,view6,view7,view8]];
}




@end
