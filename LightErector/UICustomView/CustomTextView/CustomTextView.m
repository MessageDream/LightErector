//
//  CustomTextView.m
//  ZhiJiaX
//
//  Created by 95190 on 13-6-18.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "CustomTextView.h"
#import "ResDefine.h"

#define Text_Xoffset 10

@implementation CustomTextView
@synthesize text = _text;
@synthesize placeholder = _placeholder;
@synthesize backgroundImage = _backgroundImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect backgroundFrame = frame;
        backgroundFrame.origin.x = 0;
        backgroundFrame.origin.y = 0;
        
        _frameImageView = [[UIImageView alloc] initWithFrame:backgroundFrame];
        _frameImageView.contentMode    = UIViewContentModeScaleToFill;
        UIImage *image = [UIImage imageNamed:NSLocalizedStringFromTable(@"coustom_textfield",Res_Image,@"")];
        _frameImageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(5,5,image.size.height-10,image.size.width-10)];
        _frameImageView.userInteractionEnabled = YES;
        [self addSubview:_frameImageView];
        
        backgroundFrame.origin.x+=Text_Xoffset;
        backgroundFrame.size.width-=Text_Xoffset*2;
        
        _textView = [[UITextView alloc] initWithFrame:backgroundFrame];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textColor = [UIColor blackColor];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.scrollEnabled = YES;
        _textView.delegate = self;
        [_frameImageView addSubview:_textView];
        
        
        CGRect placeholderFrame = CGRectMake(Text_Xoffset, Text_Xoffset, _textView.bounds.size.width, 20);
        _lbl_placeholder = [[UILabel alloc] initWithFrame:placeholderFrame];
        _lbl_placeholder.backgroundColor = [UIColor clearColor];
        _lbl_placeholder.textColor = [UIColor grayColor];
        _lbl_placeholder.font = _textView.font;
        _lbl_placeholder.textAlignment = NSTextAlignmentLeft;
        [_textView addSubview:_lbl_placeholder];
    }
    return self;
}
-(void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    
    _frameImageView.image = [_backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(5,5,_backgroundImage.size.height-10,_backgroundImage.size.width-10)];
}
- (void)textViewDidChange:(UITextView *)textView
{
    if(textView.text.length>0)
        _lbl_placeholder.hidden = YES;
    else if(textView.text.length == 0)
        _lbl_placeholder.hidden = NO;
}
-(void)setText:(NSString *)text
{
    _textView.text = text;
}
-(NSString*)text
{
    return _textView.text;
}
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    if(_placeholder!=nil && _placeholder.length>0)
    {
        _lbl_placeholder.text = _placeholder;
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
