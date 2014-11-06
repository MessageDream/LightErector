//
//  FindPasswordFromPhoneView.m
//  LightErector
//
//  Created by Jayden Zhao on 9/24/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "FindPasswordFromPhoneView.h"
#import "ResDefine.h"
#import "ImageUtils.h"

@interface FindPasswordFromPhoneView()<CustomTextFieldDelegate>
{
    UIScrollView *scroview;
    UIButton *btn_confirm;
    UIButton *btn_cancel;
    UIButton *btn_verCode;
    UIButton *btn_change;
    UIView *backView;
}
@end

@implementation FindPasswordFromPhoneView
@synthesize txt_userName = _txt_userName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
        backView=[[UIView alloc] initWithFrame:self.bounds];
        backView.backgroundColor=[UIColor blackColor];
        backView.layer.opacity=0.8;
        backView.userInteractionEnabled=YES;
        [self addSubview:backView];
        
        scroview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, frame.size.height-200,frame.size.width, 200)];
        scroview.backgroundColor = [UIColor clearColor];
       // scroview.pagingEnabled = YES;
        scroview.showsHorizontalScrollIndicator = NO;
        scroview.scrollEnabled=NO;
        scroview.contentSize = CGSizeMake(scroview.frame.size.width*2, scroview.frame.size.height);
        scroview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:scroview];
        UIView *viewOne=[[UIView alloc] initWithFrame:scroview.bounds];
        viewOne.backgroundColor=[UIColor clearColor];
        
        _txt_userName = [[CustomTextField alloc] initWithFrame:CGRectMake(10,10, scroview.frame.size.width-20, 40)];
        _txt_userName.font = [UIFont systemFontOfSize:14];
        _txt_userName.layer.borderColor=[[MainStyle mainLightColor] CGColor];
        _txt_userName.layer.borderWidth=1;
        _txt_userName.contentPlaceholder = @"请输入用户名";
        _txt_userName.observer=self;
        _txt_userName.keyboardType=UIKeyboardTypeASCIICapable;
        _txt_userName.tag=101;
        _txt_userName.textColor=[MainStyle mainBackColor];
        [viewOne addSubview:_txt_userName];
        
        _txt_veryCode=[[CustomTextField alloc] initWithFrame:CGRectMake(10,_txt_userName.frame.size.height+_txt_userName.frame.origin.y+ 10,  scroview.frame.size.width-110, 40)];
        _txt_veryCode.font = [UIFont systemFontOfSize:14];
        _txt_veryCode.contentPlaceholder = @"请输入验证码";
        _txt_veryCode.observer=self;
        _txt_veryCode.textColor=[MainStyle mainBackColor];
        _txt_veryCode.keyboardType=UIKeyboardTypeNumberPad;
         _txt_veryCode.tag=102;
        _txt_veryCode.layer.borderColor=[[MainStyle mainLightColor] CGColor];
        _txt_veryCode.layer.borderWidth=1;
        [viewOne addSubview:_txt_veryCode];
        
        
        UIImage *image=[ImageUtils createImageWithColor:[MainStyle mainLightTwoColor] andSize:CGSizeMake(80, 40)];
         UIImage *disableimage=[ImageUtils createImageWithColor:[MainStyle mainDarkColor] andSize:CGSizeMake(80, 40)];
        btn_verCode = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_verCode.frame = CGRectMake(_txt_veryCode.frame.size.width+_txt_veryCode.frame.origin.x+10,_txt_veryCode.frame.origin.y,image.size.width ,image.size.height);
        [btn_verCode setBackgroundImage:image forState:UIControlStateNormal];
        [btn_verCode setBackgroundImage:disableimage forState:UIControlStateDisabled];
        btn_verCode.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn_verCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [btn_verCode setEnabled:NO];
        [viewOne addSubview:btn_verCode];


        UIImage *btn_cancelImage = [ImageUtils createImageWithColor:[MainStyle mainLightTwoColor] andSize:CGSizeMake(frame.size.width/2-20, 40)];
        UIImage *btn_confirmImage = [ImageUtils createImageWithColor:[MainStyle mainGreenColor] andSize:CGSizeMake(frame.size.width/2-20, 40)];

        
        btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_cancel.frame = CGRectMake(10, _txt_veryCode.frame.origin.y+_txt_veryCode.frame.size.height+20, btn_confirmImage.size.width, btn_confirmImage.size.height);
        [btn_cancel setBackgroundImage:btn_cancelImage forState:UIControlStateNormal];
        btn_cancel.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [viewOne addSubview:btn_cancel];
        
        
        UIImage *btn_confirmDisableImage = [ImageUtils createImageWithColor:[MainStyle mainDarkColor] andSize:CGSizeMake(frame.size.width/2-20, 40)];
        btn_confirm = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_confirm.frame = CGRectMake(btn_confirmImage.size.width+30, btn_cancel.frame.origin.y, btn_confirmImage.size.width, btn_confirmImage.size.height);
        [btn_confirm setBackgroundImage:btn_confirmImage forState:UIControlStateNormal];
        [btn_confirm setBackgroundImage:btn_confirmDisableImage forState:UIControlStateDisabled];
        btn_confirm.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn_confirm setTitle:@"确定" forState:UIControlStateNormal];
        [btn_confirm setEnabled:NO];
        [viewOne addSubview:btn_confirm];
        
        [scroview addSubview:viewOne];
        
        UIView *viewTwo=[[UIView alloc] initWithFrame:CGRectMake(scroview.frame.size.width, 0, scroview.frame.size.width, scroview.frame.size.height)];
        viewTwo.backgroundColor=[UIColor clearColor];
        
        _txt_password = [[CustomTextField alloc] initWithFrame:CGRectMake(10,10,  scroview.frame.size.width-20, 40)];
        _txt_password.font = [UIFont systemFontOfSize:14];
        _txt_password.secureTextEntry = YES;
        _txt_password.layer.borderColor=[[MainStyle mainLightColor] CGColor];
        _txt_password.layer.borderWidth=1;
        _txt_password.contentPlaceholder = @"请输入新密码";
        _txt_password.observer=self;
        _txt_password.tag=103;
        _txt_password.textColor=[MainStyle mainBackColor];
        [viewTwo addSubview:_txt_password];
        
        _txt_confirmpassword=[[CustomTextField alloc] initWithFrame:CGRectMake(10,_txt_userName.frame.size.height+_txt_userName.frame.origin.y+ 10,  scroview.frame.size.width-20, 40)];
        _txt_confirmpassword.secureTextEntry = YES;
        _txt_confirmpassword.font = [UIFont systemFontOfSize:14];
        _txt_confirmpassword.contentPlaceholder = @"请确认新密码";
        _txt_confirmpassword.observer=self;
        _txt_confirmpassword.textColor=[MainStyle mainBackColor];
        _txt_confirmpassword.tag=104;
        _txt_confirmpassword.layer.borderColor=[[MainStyle mainLightColor] CGColor];
        _txt_confirmpassword.layer.borderWidth=1;
        [viewTwo addSubview:_txt_confirmpassword];

        UIImage *btn_changeImage = [ImageUtils createImageWithColor:[MainStyle mainGreenColor] andSize:CGSizeMake(scroview.frame.size.width-20, 40)];
        UIImage *btn_changeDisableImage = [ImageUtils createImageWithColor:[MainStyle mainDarkColor] andSize:CGSizeMake(scroview.frame.size.width-20, 40)];
        btn_change = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_change.frame = CGRectMake(10, _txt_confirmpassword.frame.origin.y+_txt_confirmpassword.frame.size.height+20,btn_changeImage.size.width, btn_changeImage.size.height);
        [btn_change setBackgroundImage:btn_changeImage forState:UIControlStateNormal];
        [btn_change setBackgroundImage:btn_changeDisableImage forState:UIControlStateDisabled];
        btn_change.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn_change setTitle:@"确认修改" forState:UIControlStateNormal];
        [btn_change setEnabled:NO];
        [viewTwo addSubview:btn_change];
        [scroview addSubview:viewTwo];
    }
    return self;
}
-(void)keyboardWasHidden:(NSNotification *)aNotification
{
    [UIView beginAnimations:@"Animation" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    CGRect frame = self.frame;
    frame.origin.y = [UIScreen mainScreen].applicationFrame.size.height-frame.size.height;
    self.frame = frame;
    [UIView commitAnimations];
}
-(void)keyboardWillShown:(NSNotification *)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    [UIView beginAnimations:@"Animation" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    CGRect frame = self.frame;
    frame.origin.y = [UIScreen mainScreen].applicationFrame.size.height - keyboardSize.height-frame.size.height;
    self.frame = frame;
    [UIView commitAnimations];
}

-(id)initWithBottom
{
    UIImage *image = [ImageUtils createImageWithColor:[MainStyle mainDarkColor] andSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 130)];
    CGRect frame = CGRectMake(0, [UIScreen mainScreen].applicationFrame.size.height-image.size.height, image.size.width, image.size.height);
    
    self = [self initWithFrame:frame];
    return self;
}

-(void)scrollToChangePwdView
{
     [_txt_password becomeFirstResponder];
    [scroview scrollRectToVisible:CGRectMake(scroview.frame.size.width, 0, scroview.frame.size.width, scroview.frame.size.height) animated:YES];
}

-(void)setEventObserver:(id<FindPasswordFromPhoneViewDelegate,TextFiledReturnEditingDelegate>)eventObserver
{
    _eventObserver=eventObserver;
    [_txt_userName addTarget:eventObserver action:@selector(textFiledReturnEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [btn_confirm addTarget:eventObserver action:@selector(findPasswordConfirmButton_onClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn_cancel addTarget:eventObserver action:@selector(findPasswordCancelButton_onClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn_verCode addTarget:eventObserver action:@selector(findPasswordGetVerCode_onClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn_change addTarget:eventObserver action:@selector(findPasswordChangePwd_onClick:) forControlEvents:UIControlEventTouchUpInside];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)textFieldChanged:(CustomTextField *)textField
{
    switch (textField.tag) {
        case 101:
            if ([textField.text length]) {
                [btn_verCode setEnabled:YES];
            }else{
                [btn_verCode setEnabled:NO];
            }
            break;
        case 102:
            if ([textField.text length]&&[_txt_userName.text length]) {
                [btn_confirm setEnabled:YES];
            }else{
                [btn_confirm setEnabled:NO];
            }
            break;
        case 103:
        case 104:
            if ([_txt_password.text length]&&[_txt_confirmpassword.text length]) {
                [btn_change setEnabled:YES];
            }else{
                [btn_change setEnabled:NO];
            }
            break;
        default:
            break;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   NSSet *set= [event touchesForView:backView];
   
    if (set) {
        if (self.eventObserver &&[self.eventObserver respondsToSelector:@selector(findPasswordCancelButton_onClick:)]) {
            [self.eventObserver findPasswordCancelButton_onClick:btn_cancel];
        }
    }
}
-(void)dealloc
{
    self.eventObserver=nil;
}
@end
