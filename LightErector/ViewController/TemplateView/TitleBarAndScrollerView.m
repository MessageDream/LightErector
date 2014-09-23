//
//  TitleBarAndScrollerView.m
//  ZhiJiaX
//
//  Created by 95190 on 13-5-23.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "TitleBarAndScrollerView.h"

@implementation TitleBarAndScrollerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        frame.origin.y = _customTitleBar.bounds.size.height;
        frame.size.height=frame.size.height-_customTitleBar.bounds.size.height;
        _scrollerView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollerView.backgroundColor = [UIColor clearColor];
        [self addSubview:_scrollerView];
        
        self.activeKeyboardControlOfScrollView = _scrollerView;
        
        
    }
    return self;
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
