//
//  CustomActivityIndicatorView.m
//  ZhiJiaX
//
//  Created by 95190 on 13-6-6.
//  Copyright (c) 2013年 95190. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "CustomActivityIndicatorView.h"
#define ActivityIndicatorViewWidth   60
#define ActivityIndicatorViewHeight  60

@implementation CustomActivityIndicatorView
@synthesize color = _color;
@synthesize showText = _showText;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-ActivityIndicatorViewWidth/2,[UIScreen mainScreen].bounds.size.height/2-ActivityIndicatorViewHeight/2,ActivityIndicatorViewWidth,ActivityIndicatorViewHeight)];
        _backgroundView.layer.masksToBounds = YES;
        _backgroundView.layer.cornerRadius = 6.0f;
        _backgroundView.layer.borderWidth = 0.1f;
        _backgroundView.backgroundColor = [UIColor blackColor];
        [self addSubview:_backgroundView];
        
        
        activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(_backgroundView.bounds.size.width/2-ActivityIndicatorViewWidth/2,_backgroundView.bounds.size.height/2-ActivityIndicatorViewHeight/2,ActivityIndicatorViewWidth,ActivityIndicatorViewHeight)];
        activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [_backgroundView addSubview:activityIndicatorView];
        
        
        self.hidden = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)startAnimating
{
    self.hidden = NO;
    [activityIndicatorView startAnimating];
}
-(void)stopAnimating
{
    self.hidden = YES;
    [activityIndicatorView stopAnimating];
}
-(BOOL)isAnimating
{
    return [activityIndicatorView isAnimating];
}
-(void)setColor:(UIColor *)color
{
    _color = color;
    _backgroundView.backgroundColor = color;
}
-(void)setShowText:(NSString *)showText
{
    _showText = showText;
    
    if(_showText==nil)
    {
        if(_lbl_text!=nil)
        {
            _backgroundView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-ActivityIndicatorViewWidth/2,[UIScreen mainScreen].bounds.size.height/2-ActivityIndicatorViewHeight/2,ActivityIndicatorViewWidth,ActivityIndicatorViewHeight);
            
            activityIndicatorView.frame = CGRectMake(_backgroundView.bounds.size.width/2-ActivityIndicatorViewWidth/2,_backgroundView.bounds.size.height/2-ActivityIndicatorViewHeight/2,ActivityIndicatorViewWidth,ActivityIndicatorViewHeight);
            [_lbl_text removeFromSuperview];
            _lbl_text = nil;
        }
        return;
    }

    CGSize size = [_showText sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(200, MAXFLOAT)  lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect backgroundViewFrame = _backgroundView.frame;
    backgroundViewFrame.size.width = size.width;
    backgroundViewFrame.size.height = size.height+activityIndicatorView.bounds.size.height+10;
    backgroundViewFrame.origin.x = [UIScreen mainScreen].bounds.size.width/2-size.width/2;
    backgroundViewFrame.origin.y = [UIScreen mainScreen].bounds.size.height/2-size.height/2;
    _backgroundView.frame = backgroundViewFrame;
    
    _lbl_text = [[UILabel alloc] initWithFrame:CGRectMake(0, 10,size.width, size.height)];
    _lbl_text.backgroundColor = [UIColor clearColor];
    _lbl_text.textAlignment = NSTextAlignmentCenter;
    _lbl_text.text = _showText;
    _lbl_text.font = [UIFont systemFontOfSize:15];
    _lbl_text.textColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f  blue:153.0f/255.0f  alpha:1];
    _lbl_text.numberOfLines = 0;
    [_backgroundView addSubview:_lbl_text];
    
    CGRect activityIndicatorViewFrame = activityIndicatorView.frame;
    activityIndicatorViewFrame.origin.x = backgroundViewFrame.size.width/2-activityIndicatorViewFrame.size.width/2;
    activityIndicatorViewFrame.origin.y = _lbl_text.frame.origin.y+_lbl_text.frame.size.height;
    activityIndicatorView.frame = activityIndicatorViewFrame;
}
-(void)setAlpha:(CGFloat)alpha
{
    _backgroundView.alpha = alpha;
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
