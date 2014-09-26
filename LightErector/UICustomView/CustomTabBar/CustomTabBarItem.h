//
//  CustomTabBarItem.h
//  TOYOTA_ZhijiaX
//
//  Created by jayden on 14-8-1.
//  Copyright (c) 2014年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TabStateEnabled,
    TabStateDisabled
} TabState;

typedef enum {
    TabTypeUsual,
    TabTypeButton,
    TabTypeUnexcludable
} TabType;

@interface CustomTabBarItem : NSObject

@property (readwrite) TabState tabState;
@property (readonly) TabType tabType;
@property (nonatomic, assign, readonly) id target;
@property (readonly) SEL selector;
@property (nonatomic, strong) UIColor *enabledBackgroundColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleFontColor;
@property (nonatomic, strong, readonly) UIImage *imageForCurrentState;

+ (CustomTabBarItem *)createUsualItemWithImageEnabled:(UIImage *)imageEnabled
                                 imageDisabled:(UIImage *)imageDisabled;

+ (CustomTabBarItem *)createUnexcludableItemWithImageEnabled:(UIImage *)imageEnabled
                                        imageDisabled:(UIImage *)imageDisabled;

+ (CustomTabBarItem *)createButtonItemWithImage:(UIImage *)image
                                  target:(id)target
                                selector:(SEL)selector;

- (void)switchState;

@end
