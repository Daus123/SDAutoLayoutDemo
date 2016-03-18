//
//  SDBaseRefreshView.h
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/10.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const kSDBaseRefreshViewObserveKeyPath;

typedef enum {
    SDWXRefreshViewStateNormal,
    SDWXRefreshViewStateWillRefresh,
    SDWXRefreshViewStateRefreshing,
} SDWXRefreshViewState;

@interface SDBaseRefreshView : UIView

@property(nonatomic,strong)UIScrollView *scrollView;

-(void)endRefreshing;

@property (nonatomic, assign) UIEdgeInsets scrollViewOriginalInsets;

@property (nonatomic, assign) SDWXRefreshViewState refreshState;


@end
