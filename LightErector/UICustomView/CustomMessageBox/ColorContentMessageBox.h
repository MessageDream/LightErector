//
//  ColorContentMessageBox.h
//  ZhiJiaAnX
//
//  Created by wei.xu.95190 on 13-9-26.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "CustomAlertView.h"

@protocol ColorMessageBoxDelegate <NSObject>
@optional
-(IBAction)colorMessageBoxLeftButton_onClick:(id)sender;
-(IBAction)colorMessageBoxRightButton_onClick:(id)sender;
@end

@interface ColorContentMessageBox : CustomAlertView


@property(nonatomic,readonly)UILabel *lbl_text;
@property(nonatomic,assign)id<ColorMessageBoxDelegate> eventObserver;

-(id)initWithTitle:(NSString*)title forText:(NSString*)text forLeftButtonText:(NSString*)leftButtonText forRightButtonText:(NSString*)rightButtonText forIconImage:(UIImage*)iconImage;

-(BOOL) addTitle:(NSString *)title forColor:(UIColor*)titleColor withContent:(NSString *)content forColor:(UIColor *)contentColor;

@end
