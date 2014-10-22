//
//  FeedBackView.m
//  LightErector
//
//  Created by Jayden Zhao on 10/22/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "FeedBackView.h"
#import "ImageUtils.h"

@interface FeedBackView()<CustomTextViewDelegate,CustomTextFieldDelegate>
{
    UIButton *feedBackBtn;
}
@end
@implementation FeedBackView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[MainStyle mainBackColor];
        self.customTitleBar.titleText= @"意见反馈";
        self.customTitleBar.leftButtonImage=[UIImage imageNamed:@"nav_btn_right_return"];
        self.customTitleBar.rightButtonImage=[UIImage imageNamed:@"keyboard_btn"];
        [self.customTitleBar.rightButton setHidden:YES];
        CGFloat space=10.0f;
        
        self.feedTitle=[[CustomTextField alloc] initWithFrame:CGRectMake(space, space, self.frame.size.width-2*space, 40)];
        self.feedTitle.contentPlaceholder=@"请输入反馈标题";
        self.feedTitle.observer=self;
        self.feedTitle.backgroundColor=[MainStyle mainLightTwoColor];
        [self.scrollerView addSubview:self.feedTitle];
        
        self.feedContent=[[CustomTextView alloc] initWithFrame:CGRectMake(space, self.feedTitle.frame.size.height+self.feedTitle.frame.origin.y+10,  self.feedTitle.frame.size.width, 150)];
        self.feedContent.backgroundColor=[MainStyle mainLightTwoColor];
        self.feedContent.placeholder=@"请输入反馈内容";
        self.feedContent.observer=self;
        [self.scrollerView addSubview:self.feedContent];
        
        feedBackBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        feedBackBtn.frame=CGRectMake(space,self.feedContent.frame.size.height+self.feedContent.frame.origin.y+space*2, frame.size.width-2*space, 44);
        feedBackBtn.backgroundColor=[MainStyle mainLightColor];
        [feedBackBtn setBackgroundImage:[ImageUtils createImageWithColor:[MainStyle mainDarkColor] andSize:CGSizeMake(feedBackBtn.frame.size.width, feedBackBtn.frame.size.height)] forState:UIControlStateDisabled];
        [feedBackBtn setTitleColor:[MainStyle mainBackColor] forState:UIControlStateNormal];
        [feedBackBtn setTitle:@"提交反馈" forState:UIControlStateNormal];
        [feedBackBtn setEnabled:NO];
        [feedBackBtn addTarget:self action:@selector(feedBack_clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollerView addSubview:feedBackBtn];
        self.scrollerView.contentSize=CGSizeMake(frame.size.width, feedBackBtn.frame.size.height+feedBackBtn.frame.origin.y+10);

    }
    return self;
}
-(void)setObserver:(id<FeedBackViewDelegate>)observer
{
    _observer=observer;
//[self.feedContent addTarget:observer action:@selector(textFiledReturnEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
}

- (void)textFieldChanged:(CustomTextField *)textField
{
    if ([self.feedTitle.text length]&&[self.feedContent.text length]) {
        [feedBackBtn setEnabled:YES];
    }else{
        [feedBackBtn setEnabled:NO];
    }
}
//-(BOOL)customTextFieldShouldBeginEditing:(CustomTextField *)textField
//{
//    return YES;
//}

-(void)textViewDidChange:(UITextView *)textView
{
    if ([self.feedTitle.text length]&&[self.feedContent.text length]) {
        [feedBackBtn setEnabled:YES];
    }else{
         [feedBackBtn setEnabled:NO];
    }
}

-(void)textViewShouldBeginEditing:(UITextView *)textView
{
    [self.customTitleBar.rightButton setHidden:NO];
}

-(void)feedBack_clicked:(id)sender
{
    if (self.observer &&[self.observer respondsToSelector:@selector(feedBackWithTitle:andContent:)]) {
        [self.observer feedBackWithTitle:self.feedTitle.text andContent:self.feedContent.text];
    }
}

-(void)hideKeyboard
{
    [self.feedContent resignFirstResponder];
    [self.customTitleBar.rightButton setHidden:YES];
}
-(void)dealloc
{
    feedBackBtn=nil;
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
