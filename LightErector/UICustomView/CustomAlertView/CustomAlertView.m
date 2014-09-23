//
//  CustomAlertView.m
//  ZhiJiaX
//
//  Created by 95190 on 13-5-24.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "CustomAlertView.h"
#import "ResDefine.h"

@interface CustomAlertView()
{
    NSTimer *timer;
}
-(IBAction)closeButton_onClick:(id)sender;
@end


@implementation CustomAlertView
@synthesize autoCloseTimer = _autoCloseTimer;
@synthesize btn_close = _btn_close;
@synthesize animation = _animation;

- (id)initWithFrame:(CGRect)frame
{
    CGRect outFrame = [UIScreen mainScreen].applicationFrame;
    outFrame.origin.y = 0;
    
    self = [super initWithFrame:outFrame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.8;
        
        UIImage *image = [UIImage imageNamed:NSLocalizedStringFromTable(@"alertview_frame",Res_Image,@"")];
        frameImageView = [[UIImageView alloc] initWithFrame:frame];
        frameImageView.contentMode    = UIViewContentModeScaleToFill;
        frameImageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10,10,image.size.height-10,image.size.width-10)];
        frameImageView.backgroundColor = [UIColor blackColor];
        frameImageView.userInteractionEnabled = YES;
        [self addSubview:frameImageView];
        
        
        image = [UIImage imageNamed:NSLocalizedStringFromTable(@"alertview_close_button",Res_Image,@"")];
        _btn_close = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_close.contentMode = UIViewContentModeScaleToFill;
        [_btn_close setBackgroundImage:image forState:UIControlStateNormal];
        [_btn_close addTarget:self action:@selector(closeButton_onClick:) forControlEvents:UIControlEventTouchUpInside];
        _btn_close.frame = CGRectMake(frameImageView.bounds.size.width-image.size.width-10, 10, image.size.width, image.size.height);
        [frameImageView addSubview:_btn_close];
    }
    return self;
}
-(void)setAnimation:(BOOL)animation
{
    _animation = animation;
    if(animation)
    {
        self.alpha = 0;
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.6];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.alpha = 0.8;
        [UIView commitAnimations];
    }
}
-(void)setCloseTimer:(double)closeTimer
{
    _autoCloseTimer = closeTimer;
    
    if(timer!=nil)
    {
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:_autoCloseTimer target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
}
- (void)onTimer:(id)sender
{
    [self closeButton_onClick:nil];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSUInteger numTaps = [[touches anyObject] tapCount];
    if(numTaps == 1)
    {
        for (UITouch *touch in touches)
        {
            CGPoint point = [touch locationInView:frameImageView];
            CGRect btn_closeFrame = _btn_close.frame;
            btn_closeFrame.origin.x-=10;
            btn_closeFrame.origin.y = 0;
            btn_closeFrame.size.width+=20;
            btn_closeFrame.size.height+=20;
            if(CGRectContainsPoint(btn_closeFrame, point))
            {
                [self closeButton_onClick:nil];
                return;
            }
        }
    }
}
-(IBAction)closeButton_onClick:(id)sender
{
    [self removeFromSuperview];
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
