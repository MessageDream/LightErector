//
//  ColorContentMessageBox.m
//  ZhiJiaAnX
//
//  Created by wei.xu.95190 on 13-9-26.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "ColorContentMessageBox.h"
#import "ResDefine.h"

#define TITLE_WIDTH 90.0f
#define OFF_X 20.0f

@interface ColorContentMessageBox()
{
    UIButton *btn_left;
    UIButton *btn_right;
    UIImageView *buttonBackgroundImageView;
    UIImageView *iconImageView;
    
    float _nextLabelY;
}

@end

@implementation ColorContentMessageBox

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
    
    
    _lbl_text = [[UILabel alloc] initWithFrame:CGRectMake(OFF_X, lineImageView.frame.origin.y+lineImageView.frame.size.height+15, frameImageView.bounds.size.width-40, size.height)];
    _lbl_text.backgroundColor = [UIColor clearColor];
    _lbl_text.textAlignment = NSTextAlignmentLeft;
    _lbl_text.text = text;
    _lbl_text.font = textFont;
    _lbl_text.textColor = [UIColor whiteColor];
    _lbl_text.numberOfLines = 0;
    _lbl_text.lineBreakMode = NSLineBreakByWordWrapping;
    [frameImageView addSubview:_lbl_text];
    
    _nextLabelY = _lbl_text.frame.origin.y + _lbl_text.frame.size.height;
    
    
    if((leftButtonText != nil) && (rightButtonText != nil))
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
    else if(leftButtonText != nil)
    {
        image = [UIImage imageNamed:NSLocalizedStringFromTable(@"messagebox_left_button",Res_Image,@"")];
        btn_left = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_left.backgroundColor = [UIColor clearColor];
        [btn_left setBackgroundImage:image forState:UIControlStateNormal];
        btn_left.titleLabel.font = textFont;
        btn_left.frame = CGRectMake((buttonBackgroundImageView.frame.size.width-image.size.width)/2.0f, 5, image.size.width, image.size.height);
        [btn_left setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn_left setTitle:leftButtonText forState:UIControlStateNormal];
        [buttonBackgroundImageView addSubview:btn_left];
    }
    else if(rightButtonText != nil)
    {
        image = [UIImage imageNamed:NSLocalizedStringFromTable(@"messagebox_right_button",Res_Image,@"")];
        btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_right.backgroundColor = [UIColor clearColor];
        [btn_right setBackgroundImage:image forState:UIControlStateNormal];
        btn_right.titleLabel.font = textFont;
        btn_right.frame = CGRectMake((buttonBackgroundImageView.frame.size.width-image.size.width)/2.0f, 5, image.size.width, image.size.height);
        [btn_right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn_right setTitle:rightButtonText forState:UIControlStateNormal];
        [buttonBackgroundImageView addSubview:btn_right];
    }
    
    
    return self;
}


-(BOOL) addTitle:(NSString *)title forColor:(UIColor*)titleColor withContent:(NSString *)content forColor:(UIColor *)contentColor
{
    
    CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(TITLE_WIDTH, MAXFLOAT)  lineBreakMode:NSLineBreakByWordWrapping];
    CGSize contentSize = [content sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20-TITLE_WIDTH, MAXFLOAT)  lineBreakMode:NSLineBreakByWordWrapping];
 
    UILabel *labTitle = [[UILabel alloc]init];
    labTitle.text = title;
    if(titleColor)
        labTitle.textColor = titleColor;
    else
        labTitle.textColor = [UIColor blackColor];
    
    labTitle.frame = CGRectMake(OFF_X, _nextLabelY, titleSize.width, titleSize.height);
    labTitle.font = [UIFont systemFontOfSize:15];
    labTitle.backgroundColor = [UIColor clearColor];
    
    UILabel *labContent = [[UILabel alloc]init];
    labContent.text = content;
    labContent.backgroundColor = [UIColor clearColor];

    if(contentColor)
        labContent.textColor = contentColor;
    else
        labContent.textColor = [UIColor blackColor];
    
    labContent.frame = CGRectMake(OFF_X + TITLE_WIDTH, _nextLabelY, contentSize.width, contentSize.height);
    labContent.font = [UIFont systemFontOfSize:15];
    
    [frameImageView addSubview:labTitle];
    [frameImageView addSubview:labContent];
    
    //计算需要增加的高度
    float addHeight = 0;
    if(titleSize.height > contentSize.height)
    {
        addHeight = titleSize.height;
    }
    else
    {
        addHeight = contentSize.height;
    }
    
    _nextLabelY += addHeight;
    
//    //将按钮下移addHeight
//    if(btn_left)
//    {
//        CGRect btnFrame = btn_left.frame;
//        btnFrame.origin.y += addHeight;
//        btn_left.frame = btnFrame;
//    }
//    if(btn_right)
//    {
//        CGRect btnFrame = btn_right.frame;
//        btnFrame.origin.y += addHeight;
//        btn_right.frame = btnFrame;
//    }
    
    CGRect btBackFrame = buttonBackgroundImageView.frame;
    btBackFrame.origin.y += addHeight;
    buttonBackgroundImageView.frame = btBackFrame;
    
    //将frameImageView增加addHeight
    CGRect frame = frameImageView.frame;
    frame.size.height += addHeight;
    frameImageView.frame = frame;
    
    return YES;
}

-(void)setEventObserver:(id<ColorMessageBoxDelegate>)eventObserver
{
    if(btn_left!=nil)
        [btn_left addTarget:eventObserver action:@selector(colorMessageBoxLeftButton_onClick:) forControlEvents:UIControlEventTouchUpInside];
    if(btn_right)
        [btn_right addTarget:eventObserver action:@selector(colorMessageBoxRightButton_onClick:) forControlEvents:UIControlEventTouchUpInside];
}

@end
