//
//  UserCenterView.m
//  LightErector
//
//  Created by Jayden Zhao on 10/15/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "UserCenterView.h"

@implementation UserCenterView

-(id)initWithFrame:(CGRect)frame tableViewStyle:(UITableViewStyle)style{
    if (self=[super initWithFrame:frame tableViewStyle:style]) {
        self.customTitleBar.titleText= @"账户管理";
        
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        CGRect rect=self.tableView.frame;
        rect.size.height=rect.size.height-DefaultTabBarHeight;
        self.tableView.frame=rect;
        [self addSubview:self.tableView];
        self.tableView.contentSize=CGSizeMake(rect.size.width, rect.size.height);
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
