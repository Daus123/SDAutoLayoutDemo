//
//  NewsModel.m
//  SDAutoLayout练习
//
//  Created by qiu on 16/3/16.
//  Copyright © 2016年 qiu. All rights reserved.
//

#import "NewsModel.h"
#import "MJExtension.h"
@implementation NewsModel


+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"imgextra":@"Imgextra",
             @"editor":@"Editor",
             @"ads":@"Ads",
             @"temp":@"template"
             };
}

@end
