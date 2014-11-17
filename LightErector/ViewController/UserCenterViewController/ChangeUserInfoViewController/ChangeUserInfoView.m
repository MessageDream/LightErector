//
//  ChangeUserInfoView.m
//  LightErector
//
//  Created by Jayden Zhao on 10/21/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "ChangeUserInfoView.h"
#import "ImageUtils.h"

@interface ChangeUserInfoView ()<CustomTextFieldDelegate>
{
    
}
@end

@implementation ChangeUserInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[MainStyle mainBackColor];
        self.customTitleBar.titleText= @"修改信息";
        self.customTitleBar.leftButtonImage=[UIImage imageNamed:@"nav_btn_right_return"];
        CGFloat space=10.0f;
        _address=[self createTextFiled:@"地址:" andFrame:CGRectMake(space,space, frame.size.width-space*2, 40)];
        [_scrollerView addSubview:_address];
        
        _telephone=[self createTextFiled:@"固话:" andFrame:CGRectMake(space, _address.frame.origin.y+_address.frame.size.height+space, frame.size.width-space*2, 40)];
        [_scrollerView addSubview:_telephone];
        
        _mobilephone=[self createTextFiled:@"手机:" andFrame:CGRectMake(space, _telephone.frame.origin.y+_telephone.frame.size.height+space, frame.size.width-space*2, 40)];
        [_scrollerView addSubview:_mobilephone];
        
        _email=[self createTextFiled:@"邮箱:" andFrame:CGRectMake(space, _mobilephone.frame.origin.y+_mobilephone.frame.size.height+space, frame.size.width-space*2, 40)];
        [_scrollerView addSubview:_email];
        
        _qq=[self createTextFiled:@"QQ:" andFrame:CGRectMake(space, _email.frame.origin.y+_email.frame.size.height+space, frame.size.width-space*2, 40)];
        [_scrollerView addSubview:_qq];
        
        _address.observer=self;
        _telephone.observer=self;
        _mobilephone.observer=self;
        _email.observer=self;
        _qq.observer=self;
        
        
        UIImage *btn_changeImage = [ImageUtils createImageWithColor:[MainStyle mainGreenColor] andSize:CGSizeMake(frame.size.width-2*space, 40)];
        UIImage *btn_changeDisableImage = [ImageUtils createImageWithColor:[MainStyle mainDarkColor] andSize:CGSizeMake(frame.size.width-20, 40)];
        _btn_change = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_change.frame = CGRectMake(10, _qq.frame.origin.y+_qq.frame.size.height+2*space,btn_changeImage.size.width, btn_changeImage.size.height);
        [_btn_change setBackgroundImage:btn_changeImage forState:UIControlStateNormal];
        [_btn_change setBackgroundImage:btn_changeDisableImage forState:UIControlStateDisabled];
        _btn_change.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn_change setTitle:@"确认修改" forState:UIControlStateNormal];
        [_btn_change addTarget:self action:@selector(submitChange_click:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollerView addSubview:_btn_change];
         _scrollerView.contentSize = CGSizeMake(self.bounds.size.width, _btn_change.frame.origin.y+_btn_change.frame.size.height+10);
    }
    return self;
}


-(CustomTextField *)createTextFiled:(NSString *)title andFrame:(CGRect)frame
{
  CustomTextField *txt=  [[CustomTextField alloc] initWithFrame:frame];
    txt.placeholder=title;
    txt.textColor=[MainStyle mainTitleColor];
    txt.font=[UIFont systemFontOfSize:16];
    txt.layer.cornerRadius=8.0f;
    txt.layer.borderWidth=1.0f;
    txt.layer.borderColor=[[MainStyle mainGreenColor] CGColor];
    return txt;
}

-(void)setObserver:(id<ChangeUserInfoViewDelegate>)observer
{
    _observer=observer;
    [_address addTarget:observer action:@selector(textFiledReturnEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_telephone addTarget:observer action:@selector(textFiledReturnEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_mobilephone addTarget:observer action:@selector(textFiledReturnEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_email addTarget:observer action:@selector(textFiledReturnEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_qq addTarget:observer action:@selector(textFiledReturnEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];

}

-(void)submitChange_click:(id)sender
{
    if (self.observer&&[self.observer respondsToSelector:@selector(submit_change_onclick:)]) {
        [self.observer submit_change_onclick:sender];
    }
}

-(BOOL)customTextFieldShouldBeginEditing:(CustomTextField *)textField
{
    if([textField isEqual:_qq]||[textField isEqual:_email]){
         self.activeKeyboardControl=_btn_change;
    }else{
        self.activeKeyboardControl=textField;
    }
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)dealloc
{
    self.observer=nil;
}
@end
