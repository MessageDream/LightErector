//
//  OrderDetailView.m
//  LightErector
//
//  Created by Jayden on 14-10-5.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "OrderDetailAndFeedBackView.h"
#import "BaseCustomMessageBox.h"
#import "ImageUtils.h"

@interface OrderDetailAndFeedBackView()<CustomTextViewDelegate>
{
    UIButton *feedBackBtn;
}
@end
@implementation OrderDetailAndFeedBackView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        
       UIView * titleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
        titleView.backgroundColor=[UIColor colorWithWhite:0.9f alpha:1];
        self.titleLable=[[UILabel alloc] initWithFrame:CGRectMake(0, (titleView.frame.size.height-16)/2, frame.size.width, 16)];
        self.titleLable.backgroundColor=[UIColor clearColor];
        self.titleLable.font=[UIFont systemFontOfSize:16];
        self.titleLable.backgroundColor=[UIColor clearColor];
    
        self.titleLable.textAlignment=NSTextAlignmentCenter;
        [titleView addSubview:self.titleLable];
        [self addSubview:titleView];
        
        self.infoView=[[OrderInfoView alloc] initWithFrame:CGRectMake(0, titleView.frame.origin.y+titleView.frame.size.height+10, frame.size.width, 0)];
        self.infoView.backgroundColor=[MainStyle mainLightTwoColor];
        self.infoView.hidden=YES;
        [self addSubview:self.infoView];
        
        self.feedBackView =[[UIView alloc] initWithFrame:CGRectMake(0,  self.infoView.frame.origin.y, frame.size.width, frame.size.height-titleView.frame.size.height-10)];
        self.feedBackView.backgroundColor=[UIColor clearColor];
        
        
        
        feedBackBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        feedBackBtn.frame=CGRectMake(0,self.feedBackView.frame.size.height-54, frame.size.width, 44);
        feedBackBtn.backgroundColor=[MainStyle mainLightColor];
        [feedBackBtn setBackgroundImage:[ImageUtils createImageWithColor:[MainStyle mainDarkColor] andSize:CGSizeMake(feedBackBtn.frame.size.width, feedBackBtn.frame.size.height)] forState:UIControlStateDisabled];
        [feedBackBtn setTitleColor:[MainStyle mainBackColor] forState:UIControlStateNormal];
        [feedBackBtn setTitle:@"提交反馈" forState:UIControlStateNormal];
        [feedBackBtn setEnabled:NO];
        [feedBackBtn addTarget:self action:@selector(feedBack_clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.feedBackView addSubview:feedBackBtn];
        
        self.feedText=[[CustomTextView alloc] initWithFrame:CGRectMake(feedBackBtn.frame.origin.x, 0, feedBackBtn.frame.size.width, self.feedBackView.frame.size.height-feedBackBtn.frame.size.height-20)];
        self.feedText.backgroundColor=[MainStyle mainLightTwoColor];
        self.feedText.placeholder=@"请输入安装失败原因";
        self.feedText.observer=self;
        [self.feedBackView addSubview:self.feedText];
        
        [self addSubview:self.feedBackView];
    }
    return self;
}

-(void)feedBack_clicked:(id)sender
{
    NSString *text=self.feedText.text;
    if (self.observer&&[self.observer respondsToSelector:@selector(feedBackButton_Clicked:)]) {
        [self.observer feedBackButton_Clicked:text];
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text&&[textView.text length]) {
        [feedBackBtn setEnabled:YES];
    }else{
        [feedBackBtn setEnabled:NO];
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
