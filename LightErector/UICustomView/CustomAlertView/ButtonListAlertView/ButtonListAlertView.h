//
//  ProductOrderAlertView.h
//  ZhiJiaX
//
//  Created by 95190 on 13-6-3.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAlertView.h"

@class ButtonListAlertView;

@protocol ButtonListAlertViewDelegate <NSObject>
@optional
-(void)selectButtonAtPos_OnClick:(ButtonListAlertView*)object forPos:(int)pos;
@end

@interface ButtonListAlertView : CustomAlertView
{
@protected
    NSMutableArray *_buttonArray;
    UILabel *_lbl_title;
    UIScrollView *_scrollerView;
}
@property(nonatomic,readonly)NSArray *buttonArray;
@property(nonatomic,readonly)UILabel *lbl_title;
@property(nonatomic,assign)id<ButtonListAlertViewDelegate> observer;
-(id)initWithButtonCount:(int)count;
@end
