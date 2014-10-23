//
//  KTStackView.h
//  YoPingSDK
//
//  Created by dengjian 2012-11-15
//  Copyright (c) 2012年 ktplay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomStackItemView.h"



@interface CustomStackView : UIView

-(void)pushView:(CustomStackItemView *) view;
-(void)popView;
-(void)pushViewFromLeft2Right:(CustomStackItemView *) newView;

-(void)pushView:(CustomStackItemView *) newView animation:(BOOL)animation;
-(void)popView:(BOOL)animation;
-(void)pushViewFromLeft2Right:(CustomStackItemView *) newView animation:(BOOL)animation;

-(void)presentView:(CustomStackItemView *) newView result:(void (^)(id params))result;
-(void)presentView:(CustomStackItemView *) newView animation:(BOOL)animation result:(void (^)(id params))result;
-(void)dismissView:(BOOL)animation;
-(void)dismissView:(BOOL)animation completion:(void (^)(BOOL finished))completion;

-(CustomStackItemView *)topView;
-(void)popAllView;
@end
