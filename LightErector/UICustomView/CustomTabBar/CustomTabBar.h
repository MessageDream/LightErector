//
//  CustomTabBar.h
//  TOYOTA_ZhijiaX
//
//  Created by jayden on 14-8-1.
//  Copyright (c) 2014年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBarItem.h"

typedef struct HorizontalEdgeInsets {
    CGFloat left, right;
} HorizontalEdgeInsets;

static inline HorizontalEdgeInsets HorizontalEdgeInsetsMake (CGFloat left, CGFloat right) {
    HorizontalEdgeInsets insets = {left, right};
    return insets;
}

@class CustomTabBarItem;
@class CustomTabBar;

@protocol CustomTabBarDelegate <NSObject>

//Called for all types except TabTypeButton
- (void)tabBar:(CustomTabBar *)tabBar tabBecameEnabledAtIndex:(int)index tab:(CustomTabBarItem *)tabItem;
//Called Only for unexcludable items. (TabTypeUnexcludable)
- (void)tabBar:(CustomTabBar *)tabBar tabBecameDisabledAtIndex:(int)index tab:(CustomTabBarItem *)tabItem;

@end

@interface CustomTabBar : UIView

@property (nonatomic, assign) IBOutlet id<CustomTabBarDelegate> delegate;
@property (readwrite) BOOL darkensBackgroundForEnabledTabs;
@property (readwrite) BOOL drawSeparators;
@property (nonatomic, strong) UIColor *enabledTabBackgrondColor;
@property (nonatomic, strong) UIFont *titlesFont;
@property (nonatomic, strong) UIColor *titlesFontColor;
@property (nonatomic, strong) NSArray *tabItems;
@property (nonatomic, readwrite) HorizontalEdgeInsets horizontalInsets;

- (id)initWithFrame:(CGRect)frame andTabItems:(NSArray *)tabItems;
- (void)swtichTab:(CustomTabBarItem *)tabItem;
@end
