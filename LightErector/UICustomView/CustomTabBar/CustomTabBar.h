//
//  CustomTabBar.h
//  TOYOTA_ZhijiaX
//
//  Created by jayden on 14-8-1.
//  Copyright (c) 2014年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBarItem.h"

@class CustomTabBar;

@protocol CustomTabBarDelegate <NSObject>

@required

- (void)tabBar:(CustomTabBar *)AabBarDelegate didSelectTabAtIndex:(NSInteger)index;

@end

@interface CustomTabBar : UIImageView
@property (nonatomic, strong) NSArray *tabs;
@property (nonatomic, strong) CustomTabBarItem *selectedTab;
@property (nonatomic, assign) id <CustomTabBarDelegate> delegate;
@property (nonatomic, strong) UIColor *edgeColor;
@property (nonatomic, strong) NSArray *tabColors;
@property (nonatomic, strong) NSString *backgroundImageName;

- (void)tabSelected:(CustomTabBarItem *)sender;

@end
