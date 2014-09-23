//
//  CustomMessageBox.m
//  ZhiJiaX
//
//  Created by 95190 on 13-5-30.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "CustomMessageBox.h"
#import "ResDefine.h"

@interface CustomMessageBox()
{
    UIButton *btn_left;
    UIButton *btn_right;
    UIImageView *buttonBackgroundImageView;
    UIImageView *iconImageView;
}
@end


@implementation CustomMessageBox
@synthesize lbl_text = _lbl_text;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithTitle:(NSString*)title forText:(NSString*)text forLeftButtonText:(NSString*)leftButtonText forRightButtonText:(NSString*)rightButtonText forIconImage:(UIImage*)iconImage
{
    double height = 10;
    UIImage *image = [UIImage imageNamed:NSLocalizedStringFromTable(@"messagebox_title_icon",Res_Image,@"")];
    height+=image.size.height;
    height+=10;
    image = [UIImage imageNamed:NSLocalizedStringFromTable(@"messagebox_line",Res_Image,@"")];
    height+=image.size.height;
    height+=15;
    UIFont *textFont = [UIFont systemFontOfSize:15];
    CGSize size = [text sizeWithFont:textFont constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT)  lineBreakMode:NSLineBreakByWordWrapping];
    height+=size.height;
    height+=15;
    
    if(leftButtonText != nil || rightButtonText != nil)
    {
        image = [UIImage imageNamed:NSLocalizedStringFromTable(@"messagebox_button_background",Res_Image,@"")];
        height+=image.size.height;
    }
    
    CGRect frame = CGRectMake(5, [UIScreen mainScreen].bounds.size.height/2-height/2, [UIScreen mainScreen].bounds.size.width-10, height);
    
    self = [self initWithFrame:frame];
    
    if(leftButtonText != nil || rightButtonText != nil)
    {
        buttonBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedStringFromTable(@"messagebox_button_background",Res_Image,@"")]];
        CGRect buttonBackgroundImageViewFrame = buttonBackgroundImageView.frame;
        buttonBackgroundImageViewFrame.origin.x+=1;
        buttonBackgroundImageViewFrame.origin.y = frameImageView.bounds.size.height-buttonBackgroundImageViewFrame.size.height;
        buttonBackgroundImageViewFrame.size.width = frame.size.width-2;
        buttonBackgroundImageViewFrame.size.height--;
        buttonBackgroundImageView.frame = buttonBackgroundImageViewFrame;
        buttonBackgroundImageView.userInteractionEnabled = YES;
        [frameImageView addSubview:buttonBackgroundImageView];
    }
    
    if(iconImage!=nil)
    {
        iconImageView = [[UIImageView alloc] initWithImage:iconImage];
        CGRect iconImageViewFrame = iconImageView.frame;
        iconImageViewFrame.origin.x = 10;
        iconImageViewFrame.origin.y = 10;
        iconImageView.frame = iconImageViewFrame;
        [frameImageView addSubview:iconImageView];
    }
    
    UILabel *lbl_title = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.frame.origin.x+iconImageView.frame.size.width+8, iconImageView.frame.origin.y, 140, 20)];
    lbl_title.backgroundColor = [UIColor clearColor];
    lbl_title.textAlignment = NSTextAlignmentLeft;
    lbl_title.text = title;
    lbl_title.font = [UIFont systemFontOfSize:18];
    lbl_title.textColor = [UIColor colorWithRed:28.0f/255.0f green:132.0f/255.0f  blue:156.0f/255.0f  alpha:1];
    [frameImageView addSubview:lbl_title];
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedStringFromTable(@"messagebox_line",Res_Image,@"")]];
    CGRect lineImageViewFrame = lineImageView.frame;
    lineImageViewFrame.origin.y = iconImageView.frame.origin.y+iconImageView.frame.size.height+10;
    lineImageView.frame = lineImageViewFrame;
    [frameImageView addSubview:lineImageView];
    
    
    _lbl_text = [[UILabel alloc] initWithFrame:CGRectMake(10, lineImageView.frame.origin.y+lineImageView.frame.size.height+15, frameImageView.bounds.size.width-20, size.height)];
    _lbl_text.backgroundColor = [UIColor clearColor];
    _lbl_text.textAlignment = NSTextAlignmentLeft;
    _lbl_text.text = text;
    _lbl_text.font = textFont;
    _lbl_text.textColor = [UIColor whiteColor];
    _lbl_text.numberOfLines = 0;
    _lbl_text.lineBreakMode = NSLineBreakByWordWrapping;
    [frameImageView addSubview:_lbl_text];
    
    if(leftButtonText != nil)
    {
        image = [UIImage imageNamed:NSLocalizedStringFromTable(@"messagebox_left_button",Res_Image,@"")];
        btn_left = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_left.backgroundColor = [UIColor clearColor];
        [btn_left setBackgroundImage:image forState:UIControlStateNormal];
        btn_left.titleLabel.font = textFont;
        btn_left.frame = CGRectMake(5, 5, image.size.width, image.size.height);
        [btn_left setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn_left setTitle:leftButtonText forState:UIControlStateNormal];
        [buttonBackgroundImageView addSubview:btn_left];
    }
    
    if(rightButtonText != nil)
    {
        image = [UIImage imageNamed:NSLocalizedStringFromTable(@"messagebox_right_button",Res_Image,@"")];
        btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_right.backgroundColor = [UIColor clearColor];
        [btn_right setBackgroundImage:image forState:UIControlStateNormal];
        btn_right.titleLabel.font = textFont;
        btn_right.frame = CGRectMake(btn_left.frame.origin.x+btn_left.frame.size.width+3, 5, image.size.width, image.size.height);
        [btn_right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn_right setTitle:rightButtonText forState:UIControlStateNormal];
        [buttonBackgroundImageView addSubview:btn_right];
    }
    
    
    return self;
}
-(void)setEventObserver:(id<CustomMessageBoxDelegate>)eventObserver
{
    if(btn_left!=nil)
        [btn_left addTarget:eventObserver action:@selector(messageBoxLeftButton_onClick:) forControlEvents:UIControlEventTouchUpInside];
    if(btn_right)
        [btn_right addTarget:eventObserver action:@selector(messageBoxRightButton_onClick:) forControlEvents:UIControlEventTouchUpInside];

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
