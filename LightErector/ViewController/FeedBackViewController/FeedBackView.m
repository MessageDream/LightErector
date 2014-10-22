//
//  FeedBackView.m
//  LightErector
//
//  Created by Jayden Zhao on 10/22/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "FeedBackView.h"

@interface FeedBackView()<CustomTextViewDelegate>

@end
@implementation FeedBackView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//       UIButton *feedBackBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        feedBackBtn.frame=CGRectMake(0,self.feedBackView.frame.size.height-54, frame.size.width, 44);
//        feedBackBtn.backgroundColor=[MainStyle mainLightColor];
//        [feedBackBtn setBackgroundImage:[ImageUtils createImageWithColor:[MainStyle mainDarkColor] andSize:CGSizeMake(feedBackBtn.frame.size.width, feedBackBtn.frame.size.height)] forState:UIControlStateDisabled];
//        [feedBackBtn setTitleColor:[MainStyle mainBackColor] forState:UIControlStateNormal];
//        [feedBackBtn setTitle:@"提交反馈" forState:UIControlStateNormal];
//        [feedBackBtn setEnabled:NO];
//        [feedBackBtn addTarget:self action:@selector(feedBack_clicked:) forControlEvents:UIControlEventTouchUpInside];
//        [self.feedBackView addSubview:feedBackBtn];
        
        CGFloat space=10.0f;
        
        self.feedTitle=[[CustomTextField alloc] initWithFrame:CGRectMake(space, space, self.frame.size.width-2*space, 40)];
        self.feedTitle.contentPlaceholder=@"请输入反馈标题";
        [self addSubview:self.feedTitle];
        
        self.feedContent=[[CustomTextView alloc] initWithFrame:CGRectMake(space, self.feedTitle.frame.size.height+self.feedTitle.frame.origin.y+10,  self.feedTitle.frame.size.width, 150)];
        self.feedContent.backgroundColor=[MainStyle mainLightTwoColor];
        self.feedContent.placeholder=@"请输入安装失败原因";
        self.feedContent.observer=self;
        [self addSubview:self.feedContent];

    }
    return self;
}

-(void)textViewDidChange:(UITextView *)textView
{

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
