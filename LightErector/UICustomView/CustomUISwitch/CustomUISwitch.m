//
//  CustomUISwitch.m
//  ZhiJiaX
//
//  Created by 95190 on 13-5-17.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "CustomUISwitch.h"
#import <QuartzCore/QuartzCore.h>

@interface CustomUISwitch()
{
    UIButton *switchButton;
    UIImageView *onImageView;
    UIImageView *offImageView;
    UILabel *lbl_left;
    UILabel *lbl_right;
}
-(void)createControl;
@end

@implementation CustomUISwitch
@synthesize status = _status;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithImage:(UIImage*)onBackgroundImage forOffBackgroundImage:(UIImage*)offBackgroundImage forSwitchButtonImage:(UIImage*)switchButtonImage
{
    CGRect frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = onBackgroundImage.size.width;
    frame.size.height = onBackgroundImage.size.height;
    self = [self initWithFrame:frame];
    _onBackgroundImage = onBackgroundImage;
    _offBackgroundImage = offBackgroundImage;
    _switchButtonImage = switchButtonImage;
    self.clipsToBounds = YES;
    self.status = YES;
    return self;
}
-(void)createControl
{
    onImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    onImageView.image = _onBackgroundImage;
    [self addSubview:onImageView];
    
    offImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    offImageView.image = _offBackgroundImage;
    [self addSubview:offImageView];
    
    
    switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [switchButton setBackgroundImage:_switchButtonImage forState:UIControlStateNormal];
    [switchButton addTarget:self action:@selector(switchButton_onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:switchButton];
    
    
    CGRect onImageViewFrame = onImageView.frame;
    CGRect offImageViewFrame = offImageView.frame;
    CGRect buttonFrame;
    if(self.status)
    {
        buttonFrame = CGRectMake(self.bounds.size.width-_switchButtonImage.size.width, 0.7, _switchButtonImage.size.width, _switchButtonImage.size.height);
        onImageViewFrame.origin.x = 0;
        offImageViewFrame.origin.x+=100;
    }
    else
    {
        buttonFrame = CGRectMake(0, 0.7, _switchButtonImage.size.width, _switchButtonImage.size.height);
        onImageViewFrame.origin.x-=onImageViewFrame.size.width;
        offImageViewFrame.origin.x=0;
    }
    switchButton.frame = buttonFrame;
    onImageView.frame = onImageViewFrame;
    offImageView.frame = offImageViewFrame;
    
    lbl_left = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width-switchButton.bounds.size.width, self.bounds.size.height)];
    lbl_left.backgroundColor = [UIColor clearColor];
    lbl_left.shadowOffset = CGSizeMake(0, -1);
    lbl_left.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    lbl_left.font = [UIFont systemFontOfSize:10];
    lbl_left.textAlignment = NSTextAlignmentCenter;
    lbl_left.text = @"ON";
    [self insertSubview:lbl_left belowSubview:switchButton];
    
    
    lbl_right = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-switchButton.bounds.size.width, 0, self.bounds.size.width-switchButton.bounds.size.width, self.bounds.size.height)];
    lbl_right.backgroundColor = [UIColor clearColor];
    lbl_right.shadowOffset = CGSizeMake(0, -1);
    lbl_right.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    lbl_right.font = [UIFont systemFontOfSize:10];
    lbl_right.textAlignment = NSTextAlignmentCenter;
    lbl_right.text = @"OFF";
    [self insertSubview:lbl_right belowSubview:switchButton];
    
    
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSUInteger numTaps = [[touches anyObject] tapCount];
    if(numTaps == 1)
    {
        for (UITouch *touch in touches)
        {
            CGPoint point = [touch locationInView:self];
            if(CGRectContainsPoint(self.bounds, point))
            {
                [self switchButton_onClick:nil];
                return;
            }
        }
    }
}
-(IBAction)switchButton_onClick:(id)sender
{
    CGRect buttonFrame = switchButton.frame;
    CGRect onImageViewFrame = onImageView.frame;
    CGRect offImageViewFrame = offImageView.frame;
    
    [UIView beginAnimations:@"Animation" context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    if(self.status)
    {
        buttonFrame.origin.x = 0;
        onImageViewFrame.origin.x-=onImageViewFrame.size.width;
        offImageViewFrame.origin.x=0;
        self.status = NO;
        switchButton.layer.frame = buttonFrame;
        onImageView.frame = onImageViewFrame;
        offImageView.frame = offImageViewFrame;
    }
    else
    {
        onImageViewFrame.origin.x = 0;
        offImageViewFrame.origin.x+=100;
        buttonFrame.origin.x = self.bounds.size.width-_switchButtonImage.size.width;
        self.status = YES;
        switchButton.layer.frame = buttonFrame;
        onImageView.frame = onImageViewFrame;
        offImageView.frame = offImageViewFrame;
    }
    [UIView commitAnimations];
    
    if(self.observer!=nil)
        [self.observer didSwitchButton:self forStatus:self.status];
}
-(void)didMoveToSuperview
{
    [self createControl];
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
