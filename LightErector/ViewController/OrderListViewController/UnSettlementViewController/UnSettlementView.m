//
//  UnSettlementView.m
//  LightErector
//
//  Created by Jayden Zhao on 10/11/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "UnSettlementView.h"

@implementation UnSettlementView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.customTitleBar.titleText= @"待结算";
        self.infoLable=[[UILabel alloc] initWithFrame:CGRectMake(0, self.customTitleBar.frame.size.height+self.customTitleBar.frame.origin.y +10, self.frame.size.width, 20)];
        self.infoLable.font=[UIFont systemFontOfSize:16];
        self.infoLable.textColor=[MainStyle mainTitleColor];
        self.infoLable.backgroundColor=[UIColor clearColor];
        self.infoLable.textAlignment=NSTextAlignmentCenter;
        [self addSubview:self.infoLable];
        
        UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0,self.infoLable.frame.origin.y+self.infoLable.frame.size.height+10, self.frame.size.width, 1)];
        lineView.backgroundColor=[MainStyle mainDarkColor];
        [self addSubview:lineView];
        
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        CGRect rect=self.tableView.frame;
        rect.origin.y=lineView.frame.size.height+lineView.frame.origin.y;
        rect.size.height=rect.size.height-DefaultTabBarHeight- self.infoLable.frame.size.height-lineView.frame.size.height;
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
