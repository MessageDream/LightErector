//
//  CustomMessageBox.h
//  ZhiJiaX
//
//  Created by 95190 on 13-5-30.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAlertView.h"

@protocol CustomMessageBoxDelegate <NSObject>
@optional
-(IBAction)messageBoxLeftButton_onClick:(id)sender;
-(IBAction)messageBoxRightButton_onClick:(id)sender;
@end

@interface CustomMessageBox : CustomAlertView
{
@protected
    UILabel *_lbl_text;
}
@property(nonatomic,readonly)UILabel *lbl_text;
@property(nonatomic,assign)id<CustomMessageBoxDelegate> eventObserver;
-(id)initWithTitle:(NSString*)title forText:(NSString*)text forLeftButtonText:(NSString*)leftButtonText forRightButtonText:(NSString*)rightButtonText forIconImage:(UIImage*)iconImage;
@end
