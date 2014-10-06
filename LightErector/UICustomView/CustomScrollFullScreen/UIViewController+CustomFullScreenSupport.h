//
//  UIViewController+UIViewController_CustomFullScreenSupport.h
//  LightErector
//
//  Created by Jayden on 14-10-3.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CustomFullScreenSupport)
- (void)showNavigationBar:(BOOL)animated;
- (void)hideNavigationBar:(BOOL)animated;
- (void)moveNavigtionBar:(CGFloat)deltaY animated:(BOOL)animated;
- (void)setNavigationBarOriginY:(CGFloat)y animated:(BOOL)animated;

- (void)showToolbar:(BOOL)animated;
- (void)hideToolbar:(BOOL)animated;
- (void)moveToolbar:(CGFloat)deltaY animated:(BOOL)animated;
- (void)setToolbarOriginY:(CGFloat)y animated:(BOOL)animated;

- (void)showTabBar:(BOOL)animated;
- (void)hideTabBar:(BOOL)animated;
- (void)moveTabBar:(CGFloat)deltaY animated:(BOOL)animated;
- (void)setTabBarOriginY:(CGFloat)y animated:(BOOL)animated;
@end
