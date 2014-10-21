//
//  SystemNoticeView.m
//  LightErector
//
//  Created by Jayden Zhao on 10/21/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "SystemNoticeView.h"
@interface SystemNoticeView()
{
    
}
@end
@implementation SystemNoticeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.customTitleBar.titleText=@"系统通知";
        self.customTitleBar.leftButtonImage=[UIImage imageNamed:@"nav_btn_right_return"];
        _webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, self.customTitleBar.frame.origin.y+self.customTitleBar.frame.size.height, frame.size.width, frame.size.height-self.customTitleBar.frame.size.height)];
        _webView.backgroundColor=[MainStyle mainBackColor];
        [self addSubview:_webView];
    }
    return self;
}

-(void)startLoading
{
    NSURL *u=[NSURL URLWithString:self.url];
    [_webView loadRequest:[NSURLRequest requestWithURL:u]];
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
