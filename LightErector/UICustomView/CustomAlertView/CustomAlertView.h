//
//  CustomAlertView.h
//  ZhiJiaX
//
//  Created by 95190 on 13-5-24.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIView
{
@protected
    double _autoCloseTimer;
    UIButton *_btn_close;
    UIImageView *frameImageView;
    BOOL _animation;
}
@property(nonatomic)double autoCloseTimer;
@property(nonatomic,readonly)UIButton *btn_close;
@property(nonatomic)BOOL animation;
@end
