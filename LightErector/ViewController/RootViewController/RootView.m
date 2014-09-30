//
//  RootView.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "RootView.h"
#import "CustomTabBar.h"
#import "CustomTabBarItem.h"


@implementation RootView
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        CustomTabBarItem *todayTaskItem = [CustomTabBarItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"light"]];
        todayTaskItem.titleString = NSLocalizedStringFromTable(@"TodayTask",Res_String,@"");
        
        CustomTabBarItem *orderInfoItem = [CustomTabBarItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"shopping_basket"]];
        orderInfoItem.titleString = NSLocalizedStringFromTable(@"OrderList",Res_String,@"");
        
        CustomTabBarItem *aboutItem = [CustomTabBarItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"info"]];
        aboutItem.titleString = NSLocalizedStringFromTable(@"about",Res_String,@"");
        
        CustomTabBarItem *clearItem = [CustomTabBarItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"abacus"]];
        clearItem.titleString = NSLocalizedStringFromTable(@"WaitingClearing",Res_String,@"");
        
        CustomTabBarItem *accountItem = [CustomTabBarItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"user"] ];
        accountItem.titleString = NSLocalizedStringFromTable(@"AccountManager",Res_String,@"");
        //mastercardTabItem.tabState = TabStateEnabled;
        
        self.tabBar=[[CustomTabBar alloc] initWithFrame:CGRectMake(0, self.frame.size.height-DefaultTabBarHeight, self.frame.size.width, DefaultTabBarHeight) andTabItems:@[todayTaskItem, orderInfoItem, aboutItem, clearItem, accountItem]];
        
        self.tabBar.darkensBackgroundForEnabledTabs = YES;
        self.tabBar.horizontalInsets = HorizontalEdgeInsetsMake(10, 10);
        self.tabBar.backgroundColor=[MainStyle mainTitleColor];
        self.tabBar.titlesFontColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
        [self.tabBar swtichTab:todayTaskItem];
        [self addSubview:self.tabBar];
        [self bringSubviewToFront:self.tabBar];
    }
    return self;
}
@end
