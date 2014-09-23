//
//  ProductOrderAlertView.m
//  ZhiJiaX
//
//  Created by 95190 on 13-6-3.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "ButtonListAlertView.h"
#import "ResDefine.h"

@interface ButtonListAlertView()
{
    UIImageView *lineImageView;
}
-(IBAction)selectButtonAtPos_OnClick:(id)sender;
@end

@implementation ButtonListAlertView
@synthesize buttonArray = _buttonArray;
@synthesize lbl_title = _lbl_title;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _lbl_title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 180, 20)];
        _lbl_title.backgroundColor = [UIColor clearColor];
        _lbl_title.textAlignment = NSTextAlignmentLeft;
        _lbl_title.font = [UIFont systemFontOfSize:18];
        _lbl_title.textColor = [UIColor colorWithRed:28.0f/255.0f green:132.0f/255.0f  blue:156.0f/255.0f  alpha:1];
        [frameImageView addSubview:_lbl_title];
        
        lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedStringFromTable(@"messagebox_line",Res_Image,@"")]];
        CGRect lineImageViewFrame = lineImageView.frame;
        lineImageViewFrame.origin.y = _lbl_title.frame.origin.y+_lbl_title.frame.size.height+10;
        lineImageView.frame = lineImageViewFrame;
        [frameImageView addSubview:lineImageView];
        
        
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(1, lineImageView.frame.origin.y+lineImageView.frame.size.height+1, frameImageView.bounds.size.width-2, frameImageView.bounds.size.height-lineImageView.frame.origin.y-lineImageView.frame.size.height-1)];
        _scrollerView.backgroundColor = [UIColor clearColor];
        [frameImageView addSubview:_scrollerView];
    }
    return self;
}
-(id)initWithButtonCount:(int)count
{
    double height = 30+11+count*([UIImage imageNamed:NSLocalizedStringFromTable(@"button_long2",Res_Image,@"")].size.height+10)+10;
    
    CGRect frame = CGRectMake(5, [UIScreen mainScreen].bounds.size.height/2-height/2, [UIScreen mainScreen].bounds.size.width-10, height);
    
    self = [self initWithFrame:frame];
    
    _buttonArray = [[NSMutableArray alloc] init];
    
    double buttonY = 10;
    for(int n=0;n<count;n++)
    {
        UIImage *image = [UIImage imageNamed:NSLocalizedStringFromTable(@"button_long2",Res_Image,@"")];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectButtonAtPos_OnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = n;
        button.frame = CGRectMake(5, buttonY, image.size.width, image.size.height);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonY = buttonY+10+image.size.height;
        [_scrollerView addSubview:button];
        
        [_buttonArray addObject:button];
    }
    _scrollerView.contentSize = CGSizeMake(_scrollerView.bounds.size.width, buttonY);
    return self;
}
-(IBAction)selectButtonAtPos_OnClick:(id)sender
{
    [self removeFromSuperview];
    UIButton *button = (UIButton*)sender;
    if(self.observer!=nil)
        [self.observer selectButtonAtPos_OnClick:self forPos:button.tag];
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
