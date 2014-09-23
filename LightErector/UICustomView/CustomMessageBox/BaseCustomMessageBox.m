//
//  BaseCustomMessageBox.m
//  ZhiJiaAnX
//
//  Created by 95190 on 13-7-2.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "BaseCustomMessageBox.h"

#define BaseCustomMessageBox_Width 280

@interface BaseCustomMessageBox()
{
    NSTimer *_timer;
    UIView *overView;
}
-(void)close;
- (void)onTimer:(id)sender;
-(IBAction)messageBoxConfirmButton_onClick:(id)sender;
-(IBAction)messageBoxCancelButton_onClick:(id)sender;
@end


@implementation BaseCustomMessageBox
@synthesize autoCloseTimer = _autoCloseTimer;
@synthesize animation = _animation;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        frame.origin.x = 0;
        frame.origin.y = 0;
        _backgroundImageView = [[UIImageView alloc] initWithFrame:frame];
        _backgroundImageView.contentMode    = UIViewContentModeScaleToFill;
        _backgroundImageView.image = [_backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(20,20,_backgroundImage.size.height-10,_backgroundImage.size.width-10)];
        [self addSubview:_backgroundImageView];
        
        _lbl_text = [[UILabel alloc] initWithFrame:CGRectMake(10,10,frame.size.width-20, frame.size.height-20)];
        _lbl_text.backgroundColor = [UIColor clearColor];
        _lbl_text.textAlignment = NSTextAlignmentCenter;
        _lbl_text.text = _text;
        _lbl_text.numberOfLines = 0;
        _lbl_text.font = [UIFont systemFontOfSize:15];
        _lbl_text.textColor = [UIColor whiteColor];
        [_backgroundImageView addSubview:_lbl_text];
    }
    return self;
}
-(IBAction)messageBoxConfirmButton_onClick:(id)sender
{
    if(self.observer!=nil)
    {
        [self.observer messageBoxConfirmButton_onClick:self];
    }
    [overView removeFromSuperview];
    [self removeFromSuperview];
}
-(IBAction)messageBoxCancelButton_onClick:(id)sender
{
    if(self.observer!=nil)
    {
        [self.observer messageBoxCancelButton_onClick:self];
    }
    [overView removeFromSuperview];
    [self removeFromSuperview];
}
-(id)initWithText:(NSString*)text forBackgroundImage:(UIImage*)image
{
    _backgroundImage = image;
    _text = text;
    
    double height = 15;
    UIFont *textFont = [UIFont systemFontOfSize:15];
    CGSize size = [text sizeWithFont:textFont constrainedToSize:CGSizeMake(BaseCustomMessageBox_Width-20, MAXFLOAT)  lineBreakMode:NSLineBreakByWordWrapping];
    height+=size.height;
    height+=15;
    
    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-BaseCustomMessageBox_Width/2, [UIScreen mainScreen].bounds.size.height/2-height/2, BaseCustomMessageBox_Width, height);
    
    self = [self initWithFrame:frame];
    return self;
}
-(void)setButtonImageWithButtonText:(UIImage*)buttonImage forText:(NSString*)text forColor:(UIColor*)textColor
{
    if(buttonImage!=nil)
    {
        CGRect frame = self.frame;
        frame.size.width = buttonImage.size.width+30;
        frame.size.height += buttonImage.size.height+40;
        frame.origin.x = [UIScreen mainScreen].bounds.size.width/2-frame.size.width/2;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height/2-frame.size.height/2;
        self.frame = frame;
        
        CGRect backgroundImageViewFrame = _backgroundImageView.frame;
        backgroundImageViewFrame.size.width = self.bounds.size.width;
        backgroundImageViewFrame.size.height = self.bounds.size.height;
        _backgroundImageView.frame = backgroundImageViewFrame;
        
        CGRect lbl_textFrame = _lbl_text.frame;
        lbl_textFrame.size.width = self.bounds.size.width-20;
        lbl_textFrame.size.height = self.bounds.size.height-buttonImage.size.height-20;
        _lbl_text.frame = lbl_textFrame;
        
        _btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_cancel.frame = CGRectMake(self.bounds.size.width/2-buttonImage.size.width/2,self.bounds.size.height-buttonImage.size.height-10,buttonImage.size.width,buttonImage.size.height);
        _btn_cancel.titleLabel.font = [UIFont systemFontOfSize:14];
        _btn_cancel.titleLabel.textColor = textColor;
        [_btn_cancel setTitle:text forState:UIControlStateNormal];
        [_btn_cancel setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [_btn_cancel addTarget:self action:@selector(messageBoxCancelButton_onClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn_cancel];
    }
}
-(void)setConfirmAndCancelButtonImageWithButtonText:(UIImage*)confirmButtonImage forLeftText:(NSString*)confirmText forLeftColor:(UIColor*)confirmTextColor forRightButtonImage:(UIImage*)cancelButtonImage forRightText:(NSString*)cancelText forRightColor:(UIColor*)cancelTextColor
{
    if(confirmButtonImage!=nil && cancelButtonImage!=nil)
    {
        CGRect frame = self.frame;
        frame.size.width = confirmButtonImage.size.width*2+10+30;
        frame.size.height += confirmButtonImage.size.height+40;
        frame.origin.x = [UIScreen mainScreen].bounds.size.width/2-frame.size.width/2;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height/2-frame.size.height/2;
        self.frame = frame;
        
        CGRect backgroundImageViewFrame = _backgroundImageView.frame;
        backgroundImageViewFrame.size.width = self.bounds.size.width;
        backgroundImageViewFrame.size.height = self.bounds.size.height;
        _backgroundImageView.frame = backgroundImageViewFrame;
        
        CGRect lbl_textFrame = _lbl_text.frame;
        lbl_textFrame.size.width = self.bounds.size.width-20;
        lbl_textFrame.size.height = self.bounds.size.height-confirmButtonImage.size.height-20;
        _lbl_text.frame = lbl_textFrame;
        
        _btn_confirm = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_confirm.frame = CGRectMake(10,self.bounds.size.height-confirmButtonImage.size.height-10,confirmButtonImage.size.width,confirmButtonImage.size.height);
        _btn_confirm.titleLabel.font = [UIFont systemFontOfSize:14];
        _btn_confirm.titleLabel.textColor = confirmTextColor;
        [_btn_confirm setTitle:confirmText forState:UIControlStateNormal];
        [_btn_confirm setBackgroundImage:confirmButtonImage forState:UIControlStateNormal];
        [_btn_confirm addTarget:self action:@selector(messageBoxConfirmButton_onClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn_confirm];
        
        _btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_cancel.frame = CGRectMake(_btn_confirm.frame.origin.x+_btn_confirm.frame.size.width+20,self.bounds.size.height-cancelButtonImage.size.height-10,cancelButtonImage.size.width,cancelButtonImage.size.height);
        _btn_cancel.titleLabel.font = [UIFont systemFontOfSize:14];
        _btn_cancel.titleLabel.textColor = cancelTextColor;
        [_btn_cancel setTitle:cancelText forState:UIControlStateNormal];
        [_btn_cancel setBackgroundImage:cancelButtonImage forState:UIControlStateNormal];
        [_btn_cancel addTarget:self action:@selector(messageBoxCancelButton_onClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn_cancel];
    }
}
-(void)setAutoCloseTimer:(double)autoCloseTimer
{
    _autoCloseTimer = autoCloseTimer;
    
    if(_timer!=nil)
    {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:_autoCloseTimer target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
}
-(void)close
{
    [overView removeFromSuperview];
    [self removeFromSuperview];
}
- (void)onTimer:(id)sender
{
    if(_animation)
    {
        self.alpha = 1;
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.6];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.alpha = 0;
        [UIView commitAnimations];
    }
    [_timer invalidate];
    _timer = nil;
    [self performSelector:@selector(close) withObject:nil afterDelay:1];
    
    if([self.observer respondsToSelector:@selector(messageBoxDisappear:)])
    {
        [self.observer messageBoxDisappear:self];
    }
}
-(void)didMoveToSuperview
{
    overView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    overView.backgroundColor = [UIColor clearColor];
    [self.superview insertSubview:overView belowSubview:self];
    
    if(_animation)
    {
        self.alpha = 0;
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.6];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.alpha = 1;
        [UIView commitAnimations];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
