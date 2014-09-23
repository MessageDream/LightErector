//
//  CustomArticleAlertView.m
//  ZhiJiaX
//
//  Created by 95190 on 13-5-27.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "CustomArticleAlertView.h"
#import "ResDefine.h"

@interface CustomArticleAlertView()
{
    
}
@end

@implementation CustomArticleAlertView
@synthesize textView = _textView;
@synthesize lbl_title = _lbl_title;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGRect _textViewFrame = frameImageView.frame;
        _textViewFrame.origin.x=5;
        _textViewFrame.origin.y=_btn_close.frame.origin.y+_btn_close.frame.size.height+10;
        _textViewFrame.size.width-=10;
        _textViewFrame.size.height-=_textViewFrame.origin.y+10;
        
        _textView = [[UITextView alloc] initWithFrame:_textViewFrame];
        _textView.text = NSLocalizedStringFromTable(@"ServerArticleText",Res_String,@"");
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textColor = [UIColor whiteColor];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.scrollEnabled = YES;
        _textView.editable = NO;
        [frameImageView addSubview:_textView];
        
        _lbl_title = [[UILabel alloc] initWithFrame:CGRectMake(_textView.frame.origin.x, _btn_close.frame.origin.y-10, 140, 40)];
        _lbl_title.backgroundColor = [UIColor clearColor];
        _lbl_title.textAlignment = NSTextAlignmentLeft;
        _lbl_title.text = NSLocalizedStringFromTable(@"ServerArticle",Res_String,@"");
        _lbl_title.font = [UIFont systemFontOfSize:18];
        _lbl_title.textColor = [UIColor colorWithRed:28.0f/255.0f green:132.0f/255.0f  blue:156.0f/255.0f  alpha:1];
        [frameImageView addSubview:_lbl_title];
        
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
