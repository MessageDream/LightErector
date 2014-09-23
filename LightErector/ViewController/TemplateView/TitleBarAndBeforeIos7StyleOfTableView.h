//
//  TitleBarAndBeforeIos7StyleOfTableView.h
//  ZhiJiaAnX
//
//  Created by 95190 on 13-12-13.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleBarView.h"
#import "BeforeIos7StyleOfTableView.h"

//在Ios7中将强制把cell的backgroundColor设置为clearColor
@interface TitleBarAndBeforeIos7StyleOfTableView : TitleBarView
{
@protected
    BeforeIos7StyleOfTableView *_tableView;
}
@property(nonatomic,readonly)BeforeIos7StyleOfTableView *tableView;
- (id)initWithFrame:(CGRect)frame tableViewStyle:(UITableViewStyle)style;
@end
