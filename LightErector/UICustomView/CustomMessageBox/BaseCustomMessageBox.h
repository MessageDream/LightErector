//
//  BaseCustomMessageBox.h
//  ZhiJiaAnX
//
//  Created by 95190 on 13-7-2.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseCustomMessageBox;
@protocol BaseCustomMessageBoxDelegate <NSObject>
@optional
-(void)messageBoxConfirmButton_onClick:(id)sender;
-(void)messageBoxCancelButton_onClick:(id)sender;
-(void)messageBoxDisappear:(BaseCustomMessageBox*)box;
@end

@interface BaseCustomMessageBox : UIView
{
@protected
    UIImageView *_backgroundImageView;
    UIImage *_backgroundImage;
    UILabel *_lbl_text;
    NSString *_text;
    double _autoCloseTimer;
    BOOL _animation;
    UIButton *_btn_cancel;
    UIButton *_btn_confirm;
}
@property(nonatomic)double autoCloseTimer;
@property(nonatomic)BOOL animation;
@property(nonatomic,assign)id<BaseCustomMessageBoxDelegate> observer;
-(id)initWithText:(NSString*)text forBackgroundImage:(UIImage*)image;
-(void)setButtonImageWithButtonText:(UIImage*)buttonImage forText:(NSString*)text forColor:(UIColor*)textColor;
-(void)setConfirmAndCancelButtonImageWithButtonText:(UIImage*)confirmButtonImage forLeftText:(NSString*)confirmText forLeftColor:(UIColor*)confirmTextColor forRightButtonImage:(UIImage*)cancelButtonImage forRightText:(NSString*)cancelText forRightColor:(UIColor*)cancelTextColor;
@end
