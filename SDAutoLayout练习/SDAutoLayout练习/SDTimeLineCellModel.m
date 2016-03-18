//
//  SDTimeLineCellModel.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/10.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "SDTimeLineCellModel.h"
#import <UIKit/UIKit.h>

extern const CGFloat contentLabelFontSize;
extern CGFloat maxContentLabelHeight;

@implementation SDTimeLineCellModel

@synthesize msgContent = _msgContent;

-(void)setMsgContent:(NSString *)msgContent
{
    _msgContent = msgContent;
}

- (NSString *)msgContent
{
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 70;
    CGFloat height = [_msgContent boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:contentLabelFontSize]} context:nil].size.height;
    
    if (height > maxContentLabelHeight) {
        _shouldShowMoreButton = YES;
    }else{
        _shouldShowMoreButton = NO;
    }
    return _msgContent;
                    
}

-(void)setIsOpening:(BOOL)isOpening
{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    }else{
        _isOpening = isOpening;
    }
}


@end

@implementation SDTimeLineCellLikeItemModel


@end

@implementation SDTimeLineCellCommentItemModel


@end

