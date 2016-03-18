//
//  SDTimeLineCellCommentView.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/11.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "SDTimeLineCellCommentView.h"
#import "UIView+SDAutoLayout.h"
#import "MLLinkLabel.h"
#import "SDTimeLineCellModel.h"
#import "GlobalDefines.h"
@interface SDTimeLineCellCommentView()<MLLinkLabelDelegate>

@property(nonatomic, strong) NSArray *likeItemsArray;
@property(nonatomic, strong) NSArray *commentItemsArray;

@property(nonatomic, strong) UIImageView *bgImageView;

@property(nonatomic, strong) UILabel *likeLabel;
@property(nonatomic, strong) UIView *likeLabelBottomLine;

@property(nonatomic, strong) NSMutableArray *commentLabelsArray;


@end
@implementation SDTimeLineCellCommentView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    _bgImageView = [[UIImageView alloc]init];
    UIImage *image = [[UIImage imageNamed:@"LikeCmtBg"]stretchableImageWithLeftCapWidth:40 topCapHeight:30];
    _bgImageView.image = image;
    [self addSubview:_bgImageView];
    
    _likeLabel = [[UILabel alloc]init];
    [self addSubview:_likeLabel];
    
    _likeLabelBottomLine = [[UIView alloc]init];
    _likeLabelBottomLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_likeLabelBottomLine];
    
    _bgImageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

-(void)setCommentItemsArray:(NSArray *)commentItemsArray
{
    _commentItemsArray = commentItemsArray;
    
    NSUInteger originalLabelCount = self.commentLabelsArray.count;
    NSUInteger needsToAddCount = commentItemsArray.count > originalLabelCount ? (commentItemsArray.count - originalLabelCount ): 0;
    for (int i = 0; i < needsToAddCount; i++) {
        MLLinkLabel *label = [[MLLinkLabel alloc]init];
        UIColor *highLightColor = TimeLineCellHighlightedColor;
        label.linkTextAttributes = @{NSForegroundColorAttributeName:highLightColor};
        label.font = [UIFont systemFontOfSize:14];
        label.delegate = self;
        [self addSubview:label];
        [self.commentLabelsArray addObject:label];
    }
    
    for (int i = 0; i < commentItemsArray.count; i++) {
        SDTimeLineCellCommentItemModel *model = commentItemsArray[i];
        MLLinkLabel *label = self.commentLabelsArray[i];
        label.attributedText = [self generateAttributedStringWithCommentItemModel:model];
    }
    
}

-(void)setLikeItemsArray:(NSArray *)likeItemsArray
{
    _likeItemsArray = likeItemsArray;
    
    _likeLabel.text = likeItemsArray.firstObject;
}

-(NSMutableArray *)commentLabelsArray
{
    if (!_commentLabelsArray) {
        _commentLabelsArray = [NSMutableArray array];
    }
    return _commentLabelsArray;
}

-(void)setupWithLikeItemsArray:(NSArray*)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray
{
    self.likeItemsArray = likeItemsArray;
    self.commentItemsArray = commentItemsArray;
    
    [_likeLabel sd_clearAutoLayoutSettings];
    _likeLabel.frame = CGRectZero;
    
    if (self.commentLabelsArray.count) {
        [self.commentLabelsArray enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL * _Nonnull stop) {
            [label sd_clearAutoLayoutSettings];
            label.frame = CGRectZero;
        }];
    }
    
    CGFloat margin = 5;
    
    if (likeItemsArray.count) {
        _likeLabel.sd_layout
        .rightSpaceToView(self,0)
        .topSpaceToView(self,margin)
        .leftSpaceToView(self,0)
        .autoHeightRatio(0);
        
        _likeLabel.isAttributedContent = YES;
    }
    
    UIView *lastBottom = _likeLabel;
    
    for (int i = 0; i<self.commentItemsArray.count; i++) {
        UILabel *label = self.commentLabelsArray[i];
        CGFloat topMargin = i == 0 ? 10 :5 ;
        label.sd_layout
        .leftSpaceToView(self, 8)
        .rightSpaceToView(self, 5)
        .topSpaceToView(lastBottom,topMargin)
        .autoHeightRatio(0);
        
        label.isAttributedContent = YES;
        lastBottom = label;
    }
    
    [self setupAutoHeightWithBottomView:lastBottom bottomMargin:margin];
    
}

-(NSMutableAttributedString*)generateAttributedStringWithCommentItemModel:(SDTimeLineCellCommentItemModel*)model
{
    NSString *text = model.firstUserName;
    if (model.secondUserName.length) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"回复%@",model.secondUserName]];
    }
    text =  [text stringByAppendingString:[NSString stringWithFormat:@":%@",model.commentString]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:text];
    UIColor *hightLightColor = [UIColor blueColor];
    
    [attr setAttributes:@{NSForegroundColorAttributeName:hightLightColor,NSLinkAttributeName:model.firstUserId} range:[text rangeOfString:model.firstUserName]];
    if (model.secondUserName) {
        [attr setAttributes:@{NSForegroundColorAttributeName:hightLightColor,NSLinkAttributeName:model.secondUserId} range:[text rangeOfString:model.secondUserName]];
    }

    return attr;
}


-(void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    NSLog(@"NameId = %@" , link.linkValue);
}

@end
