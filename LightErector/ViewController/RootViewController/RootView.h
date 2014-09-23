//
//  RootView.h
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "BaseUIView.h"
#import "CustomTabBar.h"

@interface RootView : BaseUIView
@property (nonatomic, strong) CustomTabBar *tabBar;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) BOOL isTabBarHidding;
@end
