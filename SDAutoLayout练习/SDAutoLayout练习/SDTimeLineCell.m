//
//  SDTimeLineCell.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/11.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "SDTimeLineCell.h"

#import "SDTimeLineCellModel.h"
#import "UIView+SDAutoLayout.h"

#import "SDTimeLineCellCommentView.h"
#import "SDPhotoContainer.h"

const CGFloat contentLabelFontSize = 15;
CGFloat maxContentLabelHeight = 0;

@implementation SDTimeLineCell
{
    UIImageView *_iconView;
    UILabel *_nameLabel;
    UILabel *_contentLabel;
    UIButton *_moreButton;
    SDPhotoContainer *_picContainerView;
    UILabel *_timeLabel;
    UIButton *_operationButton;
    SDTimeLineCellCommentView *_commentView;
    BOOL _shouldOpenContentLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setup
{
    _iconView = [[UIImageView alloc]init];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = [UIColor colorWithRed:54 / 255.0 green:71/ 255.0 blue:121 / 255.0 alpha:0.9];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.font = [UIFont systemFontOfSize:contentLabelFontSize];
    if (maxContentLabelHeight == 0 ) {
        maxContentLabelHeight = _contentLabel.font.lineHeight * 3;
    }
    
    _moreButton = [[UIButton alloc]init];
    [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
    [_moreButton setTitleColor:TimeLineCellHighlightedColor forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    _operationButton = [[UIButton alloc]init];
    [_operationButton setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
    [_operationButton addTarget:self action:@selector(operationButtonClicked) forControlEvents:UIControlEventTouchUpInside];

    _picContainerView = [[SDPhotoContainer alloc]init];
    _commentView = [[SDTimeLineCellCommentView alloc]init];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor lightGrayColor];
    
    NSArray *views = @[_nameLabel,_iconView,_contentLabel,_moreButton,_operationButton,_picContainerView,_commentView,_timeLabel];
    [self.contentView sd_addSubviews:views];
    
    CGFloat margin = 10;
    
    _iconView.sd_layout
    .leftSpaceToView(self.contentView,margin)
    .topSpaceToView(self.contentView,margin + 5)
    .heightIs(40)
    .widthIs(40);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_iconView,margin)
    .topEqualToView(_iconView)
    .heightIs(18);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _contentLabel.sd_layout
    .leftEqualToView(_nameLabel)
    .topSpaceToView(_nameLabel,margin)
    .rightSpaceToView(self.contentView,margin)
    .autoHeightRatio(0);
    
    //高度在setmodel里面设置 0/20
    _moreButton.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_contentLabel, 0)
    .widthIs(30);
    
    _picContainerView.sd_layout
    .leftEqualToView(_contentLabel);
    
    _timeLabel.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_picContainerView,margin)
    .heightIs(15)
    .autoHeightRatio(0);
    
    _operationButton.sd_layout
    .rightSpaceToView(self.contentView,margin)
    .centerYEqualToView(_timeLabel)
    .heightIs(25)
    .widthIs(25);
    
    _commentView.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_timeLabel,margin)
    .rightSpaceToView(self.contentView,margin);
    
}

-(void)setModel:(SDTimeLineCellModel *)model
{
    _model = model;
    
    _commentView.frame = CGRectZero;
    [_commentView setupWithLikeItemsArray:model.likeItemsArray commentItemsArray:model.commentItemsArray];
    
    _shouldOpenContentLabel = NO;
    
    _iconView.image = [UIImage imageNamed:model.iconName];
    _nameLabel.text = model.name;
    [_nameLabel sizeToFit];
    
    _contentLabel.text = model.msgContent;
    _picContainerView.picPathStringsArray = model.picNamesArray;
    if (model.shouldShowMoreButton) {
        _moreButton.sd_layout.heightIs(20);
        _moreButton.hidden = NO;
        if (model.isOpening) {
            _contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
            [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
        }else{
            _contentLabel.sd_layout.maxHeightIs(maxContentLabelHeight);
            [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        }
    }else{
        _moreButton.sd_layout.heightIs(0);
        _moreButton.hidden = YES;
    }
    
    CGFloat picContainerTopMargin = 0;
    if (model.picNamesArray.count) {
        picContainerTopMargin = 10;
    }
    
    _picContainerView.sd_layout.topSpaceToView(_moreButton,picContainerTopMargin);
    
    UIView *bottomView;
    
    if (!model.commentItemsArray.count && !model.likeItemsArray.count) {
        _commentView.fixedHeight = @0;
        _commentView.fixedWith = @0;
        _commentView.sd_layout.topSpaceToView(_timeLabel,0);
        bottomView = _timeLabel;
    }else{
        _commentView.fixedWith = nil;
        _commentView.fixedHeight = nil;
        _commentView.sd_layout.topSpaceToView(_timeLabel,10);
        bottomView = _commentView;
    }
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:15];
    
    _timeLabel.text = @"1分钟前";
}


#pragma mark - actions

- (void)moreButtonClicked
{
    if (self.moreButtonClickedBlock) {
        self.moreButtonClickedBlock(self.indexPath);
    }
}

-(void)operationButtonClicked
{
    NSLog(@"赞或评论");
}

@end
