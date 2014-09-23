//
//  CustomUIRadioButton.m
//  ZhiJiaX
//
//  Created by jishu on 13-5-21.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "CustomUIRadioButton.h"
#import "ResDefine.h"

@implementation CustomUIRadioButton
@synthesize selected = _selected;
@synthesize selectionDelegate=_selectionDelegate;

static UIImage * selectedImage=nil;
static UIImage * unSelectedImage=nil;

-(id)init
{
    return [self initWithSelected:NO];
}

//单击事件
-(void)clicked{
    self.selected=!self.selected;
    
    //发送到代理
    [self.selectionDelegate selectionButton:self didChangedTo:self.selected];
    
    if(self.selected!=NO)[self setBackgroundImage:selectedImage forState:UIControlStateNormal];
    else[self setBackgroundImage:unSelectedImage forState:UIControlStateNormal];
}

//初始化
-(id)initWithSelected:(BOOL)isSelected
{
    self = [super init];
    if(selectedImage==nil) selectedImage=[UIImage imageNamed:NSLocalizedStringFromTable(@"radio_button_checked",Res_Image,@"")];
    
    if(unSelectedImage==nil)unSelectedImage=[UIImage imageNamed:NSLocalizedStringFromTable(@"radio_button_unchecked",Res_Image,@"")];
    
    [self addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self setFrame:CGRectMake(0, 0, unSelectedImage.size.width, unSelectedImage.size.height)];
    
    self.selected=isSelected;
    
    if(isSelected!=NO)[self setBackgroundImage:selectedImage forState:UIControlStateNormal];
    else[self setBackgroundImage:unSelectedImage forState:UIControlStateNormal];
    return self;
}
//Setter
-(void)setSelected:(BOOL)isSelected
{
    _selected=isSelected;
    
    
    if(isSelected!=NO)
        [self setBackgroundImage:selectedImage forState:UIControlStateNormal];
    else
        [self setBackgroundImage:unSelectedImage forState:UIControlStateNormal];
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
