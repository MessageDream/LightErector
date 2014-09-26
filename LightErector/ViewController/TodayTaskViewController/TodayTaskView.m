//
//  TodayTaskView.m
//  LightErector
//
//  Created by Jayden Zhao on 9/26/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "TodayTaskView.h"

@implementation TodayTaskView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.customTitleBar.titleText= NSLocalizedStringFromTable(@"TodayTask",Res_String,@"");

        self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, self.customTitleBar.frame.size.height, self.frame.size.width, self.frame.size.height-self.customTitleBar.frame.size.height-DefaultTabBarHeight)];
        [self addSubview:self.tableView];
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
