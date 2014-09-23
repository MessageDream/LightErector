//
//  CustomTextField.h
//  ZhiJiaX
//
//  Created by 95190 on 13-5-21.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPlaceHolderTextField.h"

@class CustomTextField;

@protocol CustomTextFieldDelegate <NSObject>
@optional
-(BOOL)customTextFieldShouldBeginEditing:(CustomTextField *)textField;
- (BOOL)customTextField:(CustomTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (void)customTextFieldDidEndEditing:(CustomTextField *)textField;
- (void)customTextFieldDidBeginEditing:(CustomTextField *)textField;
@end


@interface CustomTextField : UIView<UITextFieldDelegate>
{
@protected
    UIImageView *_frameImageView;
    CustomPlaceHolderTextField *_txt_content;
    UILabel *_lbl_placeholder;
    BOOL _enable;
    NSString *_text;
    NSString *_placeholder;
    UIFont *_font;
    NSString *_contentPlaceholder;
    UIKeyboardType _keyboardType;
    BOOL _setKeyboardType;
    UIImage *_backgroundImage;
    UIColor *_textColor;
    UITextFieldViewMode  _clearButtonMode;
    UIReturnKeyType _returnKeyType;
    NSTextAlignment _textAlignment;
}
@property(nonatomic)BOOL enable;
@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)NSString *placeholder;
@property(nonatomic,strong)NSString *contentPlaceholder;
@property(nonatomic,strong)UIFont *font;
@property(nonatomic)UIKeyboardType keyboardType;
@property(nonatomic)UIReturnKeyType returnKeyType;
@property(nonatomic)BOOL secureTextEntry;
@property(nonatomic)UITextFieldViewMode  clearButtonMode;
@property(nonatomic,assign)id<CustomTextFieldDelegate> observer;
@property(nonatomic,strong)UIImage *backgroundImage;
@property(nonatomic,strong)UIColor *textColor;
@property(nonatomic)NSTextAlignment textAlignment;
-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
-(void)hideFrameWithAnimate:(BOOL)isAnimate;
-(void)showFrameWithAnimate:(BOOL)isAnimate;
@end
