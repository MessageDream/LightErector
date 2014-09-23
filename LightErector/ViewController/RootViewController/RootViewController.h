//
//  RootViewController.h
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomTabBar.h"
#import "CustomTabBarItem.h"

@interface RootViewController : BaseViewController<CustomTabBarDelegate>
{
    @private
    NSArray *_viewControllerIDs;
}

@property (nonatomic, assign) CGFloat minimumHeightToDisplayTitle;
@property (nonatomic, assign) BOOL tabTitleIsHidden;
@property (nonatomic, strong) NSArray *iconColors;
@property (nonatomic, strong) NSArray *selectedIconColors;
@property (nonatomic, strong) NSArray *tabColors;
@property (nonatomic, strong) NSArray *selectedTabColors;
@property (nonatomic, assign) BOOL iconGlossyIsHidden;
@property (nonatomic, strong) UIColor *tabStrokeColor;
@property (nonatomic, strong) UIColor *tabEdgeColor;
@property (nonatomic, strong) NSString *backgroundImageName;
@property (nonatomic, strong) NSString *selectedBackgroundImageName;
@property (nonatomic, strong)  UIColor *textColor;
@property (nonatomic, strong)  UIColor *selectedTextColor;

- (id)initWithTabBarHeight:(NSUInteger)height;
- (id)initWithControllerIDs:(NSArray*)ids;
- (void)showTabBarWithAnimated:(BOOL)animated;
- (void)hideTabBarWithAnimated:(BOOL)animated;
@end
