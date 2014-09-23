//
//  StripCustomMessageBox.m
//  G-NetLink
//
//  Created by jayden on 14-4-24.
//  Copyright (c) 2014年 95190. All rights reserved.
//

#import "StripCustomMessageBox.h"

@interface StripCustomMessageBox()
{
    NSTimer *_timer;
}
-(void)close;
- (void)onTimer:(id)sender;
-(void)doOutAnimation;
-(void)doInAnimation:(void (^)(void))doSomething;
@end

@implementation StripCustomMessageBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        frame.origin.x = 0;
        frame.origin.y = 0;

        _lbl_text = [[UILabel alloc] initWithFrame:CGRectMake(10,frame.size.height/2-10,frame.size.width-70, 20)];
        _lbl_text.backgroundColor = [UIColor clearColor];
        _lbl_text.textAlignment = NSTextAlignmentLeft;
        _lbl_text.text = _text;
        _lbl_text.numberOfLines = 0;
        _lbl_text.font = [UIFont systemFontOfSize:15];
        _lbl_text.textColor = [UIColor whiteColor];
        [self addSubview:_lbl_text];
        
        _btn_close=[[UIHyperlinksButton alloc]initWithFrame:CGRectMake(_lbl_text.frame.origin.x+_lbl_text.frame.size.width+10,_lbl_text.frame.origin.y,50,20)];
        _btn_close.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btn_close setTitle:@"关闭" forState:UIControlStateNormal];
        [_btn_close setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn_close setColor:[UIColor whiteColor]];
        [_btn_close addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn_close];
    }
    return self;
}

-(id)initWithOriginY:(CGFloat)originY forText:(NSString*)text forBackgroundImage:(UIImage*)image
{
    _backgroundImage = image;
    _text = text;
    
    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-image.size.width/2, originY, image.size.width, image.size.height);
    
    if(self = [self initWithFrame:frame]){
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        _backgroundImageView.contentMode    = UIViewContentModeScaleToFill;
        _backgroundImageView.image = _backgroundImage;
        [self insertSubview:_backgroundImageView atIndex:0];
    }
    return self;
}

-(void)setText:(NSString *)text
{
    _text=text;
    _lbl_text.text = _text;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (_animation) {
        [self doOutAnimation];
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
    if(_animation)
        [self doInAnimation:^{
            [self removeFromSuperview];
        }];
    else
        [self removeFromSuperview];
}

-(void)doOutAnimation
{
    self.alpha=0.0;
    CGRect frame=self.frame;
    CGRect frame1=self.frame;
    frame.origin.x=-frame.size.width;
    self.frame=frame;
    [UIView animateWithDuration:0.2 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha=1.0;
        self.frame=frame1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)doInAnimation:(void (^)(void))doSomething
{
    [UIView animateWithDuration:0.2 delay:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha=0.0;
        CGRect frame=self.frame;
        frame.origin.x=frame.origin.x+frame.size.width;
        self.frame=frame;
    } completion:^(BOOL finished) {
        if (doSomething) {
             doSomething();
        }
    }];
}

- (void)onTimer:(id)sender
{
    [_timer invalidate];
    _timer = nil;
    [self performSelector:@selector(close) withObject:nil afterDelay:1];
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
