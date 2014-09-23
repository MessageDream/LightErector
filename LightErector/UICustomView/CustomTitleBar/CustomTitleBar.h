//
//  CustomTitleView.h
//  ZhiJiaX
//
//  Created by 95190 on 13-5-14.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTitleBar_ButtonDelegate.h"

//@protocol CustomTitleBar_ButtonDelegate <NSObject>
//@optional
//-(IBAction)leftButton_onClick:(id)sender;
//-(IBAction)rightButton_onClick:(id)sender;
//@end


enum CustomTitleBar_Style
{
    CustomTitleBar_Style_None,
    CustomTitleBar_Style_DecorateLine,
};

@interface CustomTitleBar : UIView
{
@protected
    UIButton *_leftButton;
    UIButton *_rightButton;
    enum CustomTitleBar_Style _style;
    NSString *_titleText;
    UIImage *_leftButtonImage;
    UIImage *_rightButtonImage;
    UIColor *_textColor;
    int _titleFontSize;
    
}
@property(nonatomic,strong)NSString *titleText;
@property(nonatomic)int titleFontSize;
@property(nonatomic,strong)UIImage *leftButtonImage;
@property(nonatomic,strong)UIImage *rightButtonImage;
@property(nonatomic,strong)UIImage *backgroundImage;
@property(nonatomic,assign)id<CustomTitleBar_ButtonDelegate> buttonEventObserver;
@property(nonatomic)NSTextAlignment titleTextAlignment;
@property(nonatomic,readonly)UIButton *leftButton;
@property(nonatomic,readonly)UIButton *rightButton;
@property(nonatomic)enum CustomTitleBar_Style style;
@property(nonatomic,strong)UIColor *textColor;

-(id)initWithBackgroundImage:(UIImage*)image;
-(void)displayBackgroundImage:(BOOL)isDisplay;
-(void)displayCustomTitleView:(BOOL)flag;
@end
