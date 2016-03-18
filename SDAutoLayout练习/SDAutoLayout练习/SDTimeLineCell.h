//
//  SDTimeLineCell.h
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/11.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDTimeLineCellModel;

@interface SDTimeLineCell : UITableViewCell

@property (nonatomic , strong) SDTimeLineCellModel *model;

@property (nonatomic , strong) NSIndexPath *indexPath;

@property (nonatomic , copy) void (^moreButtonClickedBlock)(NSIndexPath* indexPath);
@end
