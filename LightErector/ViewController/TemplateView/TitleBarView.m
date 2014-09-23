//
//  TitleBarView.m
//  ZhiJiaX
//
//  Created by 95190 on 13-5-23.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "TitleBarView.h"

@implementation TitleBarView
@synthesize customTitleBar = _customTitleBar;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _customTitleBar = [[CustomTitleBar alloc] initWithBackgroundImage:[UIImage imageNamed:NSLocalizedStringFromTable(@"nav_bar_back",Res_Image,@"")]];
        _customTitleBar.titleFontSize = 18;
        _customTitleBar.style = CustomTitleBar_Style_None;
        _customTitleBar.backgroundColor = [UIColor clearColor];
          [self addSubview:_customTitleBar];
        _customTitleBar.textColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1];
        
        _customTitleBar.leftButtonImage = [UIImage imageNamed:NSLocalizedStringFromTable(@"title_bar_return",Res_Image,@"")];
        _customTitleBar.rightButtonImage = [UIImage imageNamed:NSLocalizedStringFromTable(@"title_bar_home",Res_Image,@"")];
        _customTitleBar.titleText = NSLocalizedStringFromTable(@"SubProductName9",Res_String,@"");
      
    }
    return self;
}
-(void)setDelegate_soon:(id<CustomTitleBar_ButtonDelegate>)delegate_soon
{
    [_customTitleBar.leftButton addTarget:delegate_soon action:@selector(leftButton_onClick:) forControlEvents:UIControlEventTouchUpInside];
    [_customTitleBar.rightButton addTarget:delegate_soon action:@selector(rightButton_onClick:) forControlEvents:UIControlEventTouchUpInside];
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
