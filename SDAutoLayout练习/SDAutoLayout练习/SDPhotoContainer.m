//
//  SDPhotoContainer.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/10.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "SDPhotoContainer.h"

#import "UIView+SDAutoLayout.h"
#import "SDPhotoBrowser.h"
@interface SDPhotoContainer ()<SDPhotoBrowserDelegate>

@property(nonatomic, strong) NSArray *imageViewsArray;

@end
@implementation SDPhotoContainer

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    self.imageViewsArray = [temp copy];
}


-(void)setPicPathStringsArray:(NSArray *)picPathStringsArray
{
    _picPathStringsArray = picPathStringsArray;
    
    for (long i = _picPathStringsArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = self.imageViewsArray[i];
        imageView.hidden = YES;
    }
    
    if (_picPathStringsArray.count == 0) {
        self.fixedHeight = @(0);
        self.height = 0;
        return;
    }
    
    CGFloat itemW = [self itemWitdhForPicPathArray:_picPathStringsArray];
    CGFloat itemH = 0;
    if (_picPathStringsArray.count == 1) {
        UIImage *image = [UIImage imageNamed:_picPathStringsArray.firstObject];
        if (image.size.width) {
            itemH = image.size.height / image.size.width * itemW;
        }
    }else{
        itemH = itemW;
    }
    
    long perRowItemCount = [self perRowItemCountForPicPathArray:_picPathStringsArray];
    CGFloat margin = 5;
    
    [_picPathStringsArray enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//       5 张    2
//row 行 col 列
        long row = idx % perRowItemCount;
        long col = idx / perRowItemCount;
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:idx];
        imageView.hidden = NO;
        imageView.image = [UIImage imageNamed:obj];
        imageView.frame = CGRectMake(row *(itemW + margin) , col * (itemH + margin), itemW, itemH);
        
    }];
    
    CGFloat viewW = perRowItemCount * itemW + (perRowItemCount - 1) *margin;
    int col = ceil(_picPathStringsArray.count * 1.0/ perRowItemCount);
    CGFloat viewH = col *itemH + (col - 1) *margin;
    self.width = viewW;
    self.height = viewH;
    
    self.fixedHeight = @(viewH);
    self.fixedWith = @(viewW);
    
}

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc]init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = self.picPathStringsArray.count;
    browser.delegate = self;
    [browser show];
}



-(long)perRowItemCountForPicPathArray:(NSArray*)array
{
//    if (array.count < 4) {
//        return 1;
//    }else if (array.count < 7){
//        return 2;
//    }else{
//        return 3;
//    }
    return 3;
}

-(CGFloat)itemWitdhForPicPathArray:(NSArray*)array
{
    if (array.count == 1) {
        return 120;
    }else{
        CGFloat w = [UIScreen mainScreen].bounds.size.width > 320 ? 80:70;
        return w;
    }
}


-(NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = self.picPathStringsArray[index];
    NSURL *url = [[NSBundle mainBundle]URLForResource:imageName withExtension:nil];
    return url;
}

-(UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}

@end
