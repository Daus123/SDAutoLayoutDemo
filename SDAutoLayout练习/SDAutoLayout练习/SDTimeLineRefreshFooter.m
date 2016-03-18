//
//  SDTimeLineRefreshFooter.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/10.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "SDTimeLineRefreshFooter.h"
#import "UIView+SDAutoLayout.h"

#define kSDTimeLineRefreshFooterHeight 50

@implementation SDTimeLineRefreshFooter


+ (instancetype)refreshFooterWithRefreshingTest:(NSString *)text
{
    SDTimeLineRefreshFooter *footer = [[SDTimeLineRefreshFooter alloc]init];
    footer.indicatorLabel.text = text;
    return footer;
}

-(void)addToScrollView:(UIScrollView *)scrollView refreshOpration:(void (^)())refresh
{
    self.scrollView = scrollView;
    self.refreshBlock = refresh;
}

-(void)setScrollView:(UIScrollView *)scrollView
{
    [super setScrollView:scrollView];
    [scrollView addSubview:self];
    self.hidden = YES;
}

-(void)endRefreshing
{
    [super endRefreshing];
    [UIView animateWithDuration:0.2 animations:^{
        self.scrollView.contentInset = self.scrollViewOriginalInsets;
        
    }];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    UIView *containView = [[UIView alloc]init];
    [self addSubview:containView];
    
    self.indicatorLabel = [[UILabel alloc]init];
    self.indicatorLabel.textColor = [UIColor lightGrayColor];
    self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.indicator startAnimating];
   
    containView.sd_layout
    .heightIs(20)
    .centerXEqualToView(self)
    .centerYEqualToView(self);
    [containView setupAutoWidthWithRightView:self.indicatorLabel rightMargin:0];

    [containView sd_addSubviews:@[self.indicator,self.indicatorLabel]];
    
    self.indicator.sd_layout
    .leftEqualToView(containView)
    .topEqualToView(containView);
    
    self.indicatorLabel.sd_layout
    .leftSpaceToView(self.indicator,5)
    .topEqualToView(containView)
    .bottomEqualToView(containView);
    
    [self.indicatorLabel setSingleLineAutoResizeWithMaxWidth:250];
    
 
    
}

-(void)setRefreshState:(SDWXRefreshViewState)refreshState
{
    [super setRefreshState:refreshState];
    
    if (refreshState == SDWXRefreshViewStateRefreshing) {
        self.scrollViewOriginalInsets = self.scrollView.contentInset;
        UIEdgeInsets insets = self.scrollView.contentInset;
        insets.bottom += kSDTimeLineRefreshFooterHeight;
        self.scrollView.contentInset = insets;
        if (self.refreshBlock) {
            self.refreshBlock();
        }
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if(keyPath != kSDBaseRefreshViewObserveKeyPath) return;
    
    if ((self.scrollView.contentOffset.y > self.scrollView.contentSize.height - self.scrollView.height) && self.refreshState != SDWXRefreshViewStateRefreshing) {
        self.frame = CGRectMake(0, self.scrollView.contentSize.height, self.scrollView.width, kSDTimeLineRefreshFooterHeight);
        self.hidden = NO;
    }else if(self.refreshState == SDWXRefreshViewStateNormal){
        self.hidden = YES;
    }
}

@end
