//
//  AppSettingView.m
//  LightErector
//
//  Created by Jayden Zhao on 10/27/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "AppSettingView.h"

@implementation AppSettingView

-(id)initWithFrame:(CGRect)frame tableViewStyle:(UITableViewStyle)style
{
    if (self=[super initWithFrame:frame tableViewStyle:style]) {
         _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        self.backgroundColor=[MainStyle mainBackColor];
        self.customTitleBar.titleText= @"软件设置";
        self.customTitleBar.leftButtonImage=[UIImage imageNamed:@"nav_btn_right_return"];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
