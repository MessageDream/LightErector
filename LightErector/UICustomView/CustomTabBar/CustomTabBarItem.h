//
//  CustomTabBarItem.h
//  TOYOTA_ZhijiaX
//
//  Created by jayden on 14-8-1.
//  Copyright (c) 2014年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBarItem : UIButton

@property (nonatomic, strong) NSString *tabImageWithName;
@property (nonatomic, strong) NSString *backgroundImageName;
@property (nonatomic, strong) NSString *selectedBackgroundImageName;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic, strong) NSString *tabTitle;
@property (nonatomic, strong) NSArray *tabIconColors;
@property (nonatomic, strong) NSArray *tabIconColorsSelected;
@property (nonatomic, strong) NSArray *tabSelectedColors;
@property (nonatomic, assign) BOOL glossyIsHidden;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *edgeColor;
@property (nonatomic, assign) CGFloat tabBarHeight;
@property (nonatomic, assign) CGFloat minimumHeightToDisplayTitle;
@property (nonatomic, assign) BOOL titleIsHidden;
@end
