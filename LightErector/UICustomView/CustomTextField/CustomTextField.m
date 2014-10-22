//
//  CustomTextField.m
//  ZhiJiaX
//
//  Created by 95190 on 13-5-21.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "CustomTextField.h"
#import "ResDefine.h"

#define Text_Xoffset 10

@interface CustomTextField()
{
    
}
-(void)moveControl;
@end


@implementation CustomTextField
@synthesize enable = _enable;
@synthesize text = _text;
@synthesize placeholder =_placeholder;
@synthesize font = _font;
@synthesize contentPlaceholder = _contentPlaceholder;
@synthesize keyboardType = _keyboardType;
@synthesize backgroundImage = _backgroundImage;
@synthesize textColor = _textColor;
@synthesize clearButtonMode = _clearButtonMode;
@synthesize returnKeyType = _returnKeyType;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect backgroundFrame = frame;
        backgroundFrame.origin.x = 0;
        backgroundFrame.origin.y = 0;
        
        _frameImageView = [[UIImageView alloc] initWithFrame:backgroundFrame];
        _frameImageView.contentMode    = UIViewContentModeScaleToFill;
        UIImage *image = [UIImage imageNamed:NSLocalizedStringFromTable(@"coustom_textfield",Res_Image,@"")];
        _frameImageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(15,15,15,15)];
        
        backgroundFrame.origin.x+=Text_Xoffset;
        backgroundFrame.size.width-=Text_Xoffset;
        _txt_content = [[CustomPlaceHolderTextField alloc] initWithFrame:backgroundFrame];
        _txt_content.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _txt_content.borderStyle = UITextBorderStyleNone;
        _txt_content.clearButtonMode = UITextFieldViewModeWhileEditing;
        _txt_content.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        _txt_content.delegate = self;
        
        _lbl_placeholder = [[UILabel alloc] initWithFrame:backgroundFrame];
        _lbl_placeholder.backgroundColor = [UIColor clearColor];
        _lbl_placeholder.textAlignment = NSTextAlignmentLeft;
        
        _enable = YES;
        
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:_txt_content];
    
    }
    return self;
}
-(void)setReturnKeyType:(UIReturnKeyType)returnKeyType
{
    _returnKeyType = returnKeyType;
    _txt_content.returnKeyType = returnKeyType;
}
-(void)setClearButtonMode:(UITextFieldViewMode)clearButtonMode
{
    _clearButtonMode = clearButtonMode;
    _txt_content.clearButtonMode = _clearButtonMode;
}
-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    
    _txt_content.textColor = _textColor;
}
-(void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    
    if(_backgroundImage == nil)
        _frameImageView.hidden = YES;
    else
    {
        _frameImageView.hidden = NO;
        _frameImageView.image = [_backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(15,15,15,15)];
    }
    
}
-(void)setEnable:(BOOL)enable
{
    _enable = enable;
    self.userInteractionEnabled = enable;
    if(enable)
        self.backgroundColor = [UIColor whiteColor];
    else
        self.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f  blue:245.0f/255.0f  alpha:1];
}
-(void)moveControl
{
    CGRect placeholderFrame = _lbl_placeholder.frame;
    CGSize size = [_placeholder sizeWithFont:_lbl_placeholder.font];
    placeholderFrame.origin.x = Text_Xoffset;
    placeholderFrame.size.width = size.width;
    _lbl_placeholder.frame = placeholderFrame;
    
    CGRect textViewFrame = CGRectMake(_lbl_placeholder.frame.origin.x+_lbl_placeholder.frame.size.width+Text_Xoffset, 0, self.bounds.size.width-_lbl_placeholder.frame.origin.x-_lbl_placeholder.frame.size.width-Text_Xoffset, self.bounds.size.height);
    _txt_content.frame = textViewFrame;
}
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _lbl_placeholder.text = _placeholder;
    
    [self moveControl];
}
-(void)setText:(NSString *)text
{
    if((NSNull *)text == [NSNull null])
    {
        _text = @"";
        _txt_content.text = @"";
        return;
    }
    _text = text;
    _txt_content.text = text;
}
-(NSString*)text
{
    _text = _txt_content.text;
    return _text;
}
-(BOOL)resignFirstResponder
{
    return [_txt_content resignFirstResponder];
}
-(BOOL)becomeFirstResponder
{
    return [_txt_content becomeFirstResponder];
}
-(void)setFont:(UIFont *)font
{
    _font = font;
    _txt_content.font = _font;
    _lbl_placeholder.font = font;
}
-(void)setContentPlaceholder:(NSString *)contentPlaceholder
{
    _contentPlaceholder = contentPlaceholder;
    _txt_content.placeholder = _contentPlaceholder;
}

-(void)setKeyboardType:(UIKeyboardType)keyboardType
{
    _keyboardType = keyboardType;
    _txt_content.keyboardType = keyboardType;
}
-(void)setSecureTextEntry:(BOOL)secureTextEntry
{
    _secureTextEntry = secureTextEntry;
    _txt_content.enabled = NO;
    _txt_content.secureTextEntry = secureTextEntry;
    _txt_content.enabled = YES;
}
-(UIKeyboardType)keyboardType
{
    return _txt_content.keyboardType;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(self.observer!=nil)
    {
        if ([self.observer respondsToSelector:@selector(customTextFieldShouldBeginEditing:)])
            return [self.observer customTextFieldShouldBeginEditing:self];
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(self.observer!=nil)
    {
        if ([self.observer respondsToSelector:@selector(customTextField:shouldChangeCharactersInRange:replacementString:)])
            return [self.observer customTextField:self shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.observer!=nil)
    {
        if ([self.observer respondsToSelector:@selector(customTextFieldDidBeginEditing:)])
            [self.observer customTextFieldDidBeginEditing:self];
    }
}

- (void)textFieldChanged:(UITextField *)textField
{
    if (self.observer&&[self.observer respondsToSelector:@selector(textFieldChanged:)]) {
        [self.observer textFieldChanged:self];
    }
}
-(void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    _txt_content.textAlignment = textAlignment;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(self.observer!=nil)
    {
        if ([self.observer respondsToSelector:@selector(customTextFieldDidEndEditing:)])
            [self.observer customTextFieldDidEndEditing:self];
    }
}
-(void)didMoveToSuperview
{
    [self addSubview:_frameImageView];
    [self addSubview:_txt_content];
    [self addSubview:_lbl_placeholder];
}
-(void)hideFrameWithAnimate:(BOOL)isAnimate
{
    if(!isAnimate)
        _frameImageView.alpha = 0;
    else
    {
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        _frameImageView.alpha = 0;
        [UIView commitAnimations];
    }
}
-(void)showFrameWithAnimate:(BOOL)isAnimate
{
    if(!isAnimate)
        _frameImageView.alpha = 1;
    else
    {
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        _frameImageView.alpha = 1;
        [UIView commitAnimations];
    }
}
-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [_txt_content addTarget:target action:action forControlEvents:controlEvents];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:_txt_content];
}
@end
