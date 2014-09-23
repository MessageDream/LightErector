//
//  BaseScrollerView.m
//  ZhiJiaAnX
//
//  Created by 95190 on 13-7-1.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "BaseScrollerView.h"

@implementation BaseScrollerView
@synthesize aboveRefreshView = _aboveRefreshView;
@synthesize belowRefreshView = _belowRefreshView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        frame.origin.y = 0;
        _scrollerView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollerView.backgroundColor = [UIColor clearColor];
        [self addSubview:_scrollerView];
        
        self.activeKeyboardControlOfScrollView = _scrollerView;
        
        _aboveRefreshView = [[UIView alloc] initWithFrame:CGRectMake(0, -50, _scrollerView.bounds.size.width, 50)];
        _aboveRefreshView.backgroundColor = [UIColor clearColor];
        [_scrollerView addSubview:_aboveRefreshView];
        
        _lbl_aboveRefreshText = [[UILabel alloc] initWithFrame:_aboveRefreshView.bounds];
        _lbl_aboveRefreshText.backgroundColor = [UIColor clearColor];
        _lbl_aboveRefreshText.textAlignment = NSTextAlignmentCenter;
        _lbl_aboveRefreshText.text = NSLocalizedStringFromTable(@"Refresh",Res_String,@"");
        _lbl_aboveRefreshText.font = [UIFont systemFontOfSize:14];
        _lbl_aboveRefreshText.textColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f  blue:153.0f/255.0f  alpha:1];
        [_aboveRefreshView addSubview:_lbl_aboveRefreshText];
        
        
        int y = _scrollerView.bounds.size.height+50;
        _belowRefreshView = [[UIView alloc] initWithFrame:CGRectMake(0, y, _scrollerView.bounds.size.width, 50)];
        _belowRefreshView.backgroundColor = [UIColor clearColor];
        [_scrollerView addSubview:_belowRefreshView];
        
        _lbl_belowRefreshText = [[UILabel alloc] initWithFrame:_aboveRefreshView.bounds];
        _lbl_belowRefreshText.backgroundColor = [UIColor clearColor];
        _lbl_belowRefreshText.textAlignment = NSTextAlignmentCenter;
        _lbl_belowRefreshText.text = NSLocalizedStringFromTable(@"Refresh",Res_String,@"");
        _lbl_belowRefreshText.font = [UIFont systemFontOfSize:14];
        _lbl_belowRefreshText.textColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f  blue:153.0f/255.0f  alpha:1];
        [_belowRefreshView addSubview:_lbl_belowRefreshText];
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
