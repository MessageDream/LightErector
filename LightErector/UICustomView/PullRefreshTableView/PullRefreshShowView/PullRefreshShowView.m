//
//  PullRefreshShowView.m
//  pullRefreshTableView
//
//  Created by 95190 on 13-8-13.
//  Copyright (c) 2013年 sunhao. All rights reserved.
//

#import "PullRefreshShowView.h"
#define ActivityIndicatorViewWidth   60
#define ActivityIndicatorViewHeight  60

@implementation PullRefreshShowView
@synthesize readyText = _readyText;
@synthesize refreshText = _refreshText;
@synthesize textColor = _textColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(10,self.bounds.size.height/2-ActivityIndicatorViewHeight/2,ActivityIndicatorViewWidth,ActivityIndicatorViewHeight)];
        activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self addSubview:activityIndicatorView];
        
        lbl_text = [[UILabel alloc] initWithFrame:self.bounds];
        lbl_text.backgroundColor = [UIColor clearColor];
        lbl_text.font = [UIFont systemFontOfSize:13];
        lbl_text.textColor = [UIColor whiteColor];
        lbl_text.numberOfLines = 0;
        lbl_text.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lbl_text];
    }
    return self;
}
-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    lbl_text.textColor = _textColor;
}
-(void)ready
{
    lbl_text.text = _readyText;
    [activityIndicatorView stopAnimating];
}
-(void)refresh
{
    lbl_text.text = _refreshText;
    [activityIndicatorView startAnimating];
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
