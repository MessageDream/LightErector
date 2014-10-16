//
//  BaseUIView.h
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainStyle.h"
#import "../Resources/ResDefine.h"
#define DefaultTabBarHeight  50
#define MESSAGEBOXTAG 93257648
@interface BaseUIView : UIView
{
    
}
@property(nonatomic,assign)UIView *activeKeyboardControl;//同activeKeyboardControlOfScrollView配对使用，针对于被键盘遮挡的情况进行的处理。
@property(nonatomic,assign)UIScrollView *activeKeyboardControlOfScrollView;
@property(nonatomic,assign)UIInterfaceOrientation orientation;
-(void)keepOutViewWillShown:(UIView*)view;
-(void)keepOutViewWasHidden;
@end
