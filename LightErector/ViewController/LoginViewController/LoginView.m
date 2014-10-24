//
//  LoginView.m
//  LightErector
//
//  Created by Jayden Zhao on 9/24/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "LoginView.h"

#import "UIHyperlinksButton.h"
#import "ImageUtils.h"

@interface LoginView()
{
    UIImageView *rememberCheckboxMarkImageView;
    UIImageView *autoLoginCheckboxMarkImageView;
    UIButton *btn_login;
    UIButton *btn_register;
    UIHyperlinksButton *btn_findPassword;
}
-(IBAction)rememberCheckbox_onClick:(id)sender;
-(IBAction)autoLoginCheckbox_onClick:(id)sender;
@end

@implementation LoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self.aboveRefreshView removeFromSuperview];
        [self.belowRefreshView removeFromSuperview];
        self.aboveRefreshView = nil;
        self.belowRefreshView = nil;
//[self setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:53.0f/255.0f  blue:65.0f/255.0f  alpha:1.0f]];
        
        UIImage *image ;//= [ImageUtils createImageWithColor:[MainStyle mainBackColor] andSize:frame.size];
//        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(5,5,image.size.height-10,image.size.width-10)]];
//        backgroundImageView.contentMode    = UIViewContentModeScaleToFill;
//        backgroundImageView.userInteractionEnabled = YES;
//        CGRect backgroundImageViewFrame = backgroundImageView.frame;
//        backgroundImageViewFrame.size.width = self.bounds.size.width;
//        backgroundImageViewFrame.size.height = self.bounds.size.height;
//        backgroundImageView.frame = backgroundImageViewFrame;
//        [self insertSubview:backgroundImageView atIndex:0];
        
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
        
        CGRect iconImageViewFrame = iconImageView.frame;
        iconImageViewFrame.origin.x = self.bounds.size.width/2-iconImageViewFrame.size.width/2;
        iconImageViewFrame.origin.y = 50;
        iconImageView.frame = iconImageViewFrame;
        [_scrollerView addSubview:iconImageView];
        
        
        image=[UIImage imageNamed:@"txt_login_line"];
        
        UIView *userNameView=[[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-image.size.width/2, iconImageView.frame.origin.y+iconImageView.frame.size.height+33, image.size.width, 30)];
        //userNameView.backgroundColor=[UIColor greenColor];
        
        iconImageView=[[UIImageView alloc] initWithImage:image];
        iconImageViewFrame=iconImageView.frame;
        iconImageViewFrame.origin.y=userNameView.frame.size.height-iconImageView.frame.size.height;
        iconImageView.frame=iconImageViewFrame;
        [userNameView addSubview:iconImageView];
        
        iconImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"txt_username_back"]];
        iconImageViewFrame=iconImageView.frame;
        iconImageViewFrame.origin.x=10;
        iconImageViewFrame.origin.y=userNameView.frame.size.height-image.size.height-iconImageView.frame.size.height;
        iconImageView.frame=iconImageViewFrame;
        [userNameView addSubview:iconImageView];
        
        
        _txt_userName = [[CustomTextField alloc] initWithFrame:CGRectMake(iconImageView.frame.origin.x+iconImageView.frame.size.width, userNameView.frame.size.height/2-20, image.size.width-iconImageView.frame.size.width-10, 40)];
        _txt_userName.font = [UIFont systemFontOfSize:15];
        _txt_userName.textColor = [UIColor whiteColor];
        _txt_userName.contentPlaceholder = NSLocalizedStringFromTable(@"UserNameLogin",Res_String,@"");
        _txt_userName.keyboardType=UIKeyboardTypeDefault;
        _txt_userName.text=@"yangjingwei";
        [userNameView addSubview:_txt_userName];
        
        [_scrollerView addSubview:userNameView];
        
        
        UIView *passwordView=[[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-image.size.width/2, userNameView.frame.origin.y+userNameView.frame.size.height+10, image.size.width, 30)];
        //passwordView.backgroundColor=[UIColor redColor];
        
        iconImageView=[[UIImageView alloc] initWithImage:image];
        iconImageViewFrame=iconImageView.frame;
        iconImageViewFrame.origin.y=userNameView.frame.size.height-iconImageView.frame.size.height;
        iconImageView.frame=iconImageViewFrame;
        [passwordView addSubview:iconImageView];
        
        iconImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"txt_password_back"]];
        iconImageViewFrame=iconImageView.frame;
        iconImageViewFrame.origin.x=10;
        iconImageViewFrame.origin.y=userNameView.frame.size.height-image.size.height-iconImageView.frame.size.height;
        iconImageView.frame=iconImageViewFrame;
        [passwordView addSubview:iconImageView];
        
        
        _txt_password = [[CustomTextField alloc] initWithFrame:CGRectMake(iconImageView.frame.origin.x+iconImageView.frame.size.width, passwordView.frame.size.height/2-20, image.size.width-iconImageView.frame.size.width-10, 40)];
        _txt_password.secureTextEntry = YES;
        _txt_password.font = [UIFont systemFontOfSize:15];
        _txt_password.textColor = [UIColor whiteColor];
        _txt_password.contentPlaceholder = NSLocalizedStringFromTable(@"UserPasswordLogin",Res_String,@"");
        _txt_password.text=@"198688";
        [passwordView addSubview:_txt_password];
        [_scrollerView addSubview:passwordView];
        
        
        image = [UIImage imageNamed:@"check_box_frame"];
        UIButton *btn_rememberCheckbox = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_rememberCheckbox.frame = CGRectMake(passwordView.frame.origin.x, passwordView.frame.origin.y+passwordView.frame.size.height+15, image.size.width, image.size.height);
        [btn_rememberCheckbox setBackgroundImage:image forState:UIControlStateNormal];
        [btn_rememberCheckbox addTarget:self action:@selector(rememberCheckbox_onClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn_rememberCheckbox setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn_rememberCheckbox setTitle:NSLocalizedStringFromTable(@"RememberMe",Res_String,@"")  forState:UIControlStateNormal];
        [btn_rememberCheckbox setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -(image.size.width+70))];
        btn_rememberCheckbox.titleLabel.font = [UIFont systemFontOfSize:15];
        [_scrollerView addSubview:btn_rememberCheckbox];
        
        
        rememberCheckboxMarkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check_box_frame_checked"]];
        [btn_rememberCheckbox addSubview:rememberCheckboxMarkImageView];
        
        
        UIButton *btn_autoLoginCheckbox = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_autoLoginCheckbox.frame = CGRectMake(btn_rememberCheckbox.frame.origin.x+btn_rememberCheckbox.frame.size.width+155, btn_rememberCheckbox.frame.origin.y, image.size.width, image.size.height);
        [btn_autoLoginCheckbox setBackgroundImage:image forState:UIControlStateNormal];
        [btn_autoLoginCheckbox addTarget:self action:@selector(autoLoginCheckbox_onClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn_autoLoginCheckbox setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn_autoLoginCheckbox setTitle:NSLocalizedStringFromTable(@"AutoLogin",Res_String,@"") forState:UIControlStateNormal];
        [btn_autoLoginCheckbox setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -(image.size.width+70))];
        btn_autoLoginCheckbox.titleLabel.font = [UIFont systemFontOfSize:15];
        [_scrollerView addSubview:btn_autoLoginCheckbox];
        
        
        autoLoginCheckboxMarkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check_box_frame_checked"]];
        [btn_autoLoginCheckbox addSubview:autoLoginCheckboxMarkImageView];
        
        
        image = [ImageUtils createImageWithColor:[MainStyle mainGreenColor] andSize:CGSizeMake(260, 40)];
        btn_login = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_login.contentMode = UIViewContentModeScaleToFill;
        btn_login.frame = CGRectMake(passwordView.frame.origin.x, btn_autoLoginCheckbox.frame.origin.y+btn_autoLoginCheckbox.frame.size.height+15, image.size.width, image.size.height);
        [btn_login setBackgroundImage:image forState:UIControlStateNormal];
        //        [btn_login setBackgroundImage:[UIImage imageNamed:NSLocalizedStringFromTable(@"button_long_cornerRadius1",Res_Image,@"")] forState:UIControlStateHighlighted];
        [btn_login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn_login setTitle:NSLocalizedStringFromTable(@"Login",Res_String,@"") forState:UIControlStateNormal];
        [_scrollerView addSubview:btn_login];
        
        
        UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(btn_login.frame.origin.x, btn_login.frame.origin.y+btn_login.frame.size.height+10, btn_login.frame.size.width, 20)];
        bottomView.backgroundColor=[UIColor clearColor];
        
        [_scrollerView addSubview:bottomView];
        UILabel *lbl_forgetPassword = [[UILabel alloc] initWithFrame:CGRectMake((btn_login.frame.size.width-180)/2, (bottomView.frame.size.height-20)/2, 120, 20)];
        lbl_forgetPassword.backgroundColor = [UIColor clearColor];
        lbl_forgetPassword.textColor = [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:204.0f/255.0f alpha:1];
        lbl_forgetPassword.font = [UIFont systemFontOfSize:15];
        lbl_forgetPassword.textAlignment = NSTextAlignmentRight;
        lbl_forgetPassword.text = NSLocalizedStringFromTable(@"ForgetPassword",Res_String,@"");
        lbl_forgetPassword.text = [lbl_forgetPassword.text stringByAppendingString:@"？"];
        [bottomView addSubview:lbl_forgetPassword];
        
        
        btn_findPassword = [UIHyperlinksButton hyperlinksButton];
        btn_findPassword.frame = CGRectMake(lbl_forgetPassword.frame.origin.x+lbl_forgetPassword.frame.size.width, lbl_forgetPassword.frame.origin.y, 60, 20);
        [btn_findPassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn_findPassword.titleLabel.font = [UIFont systemFontOfSize:15];
        NSString *str = NSLocalizedStringFromTable(@"FindPassword",Res_String,@"");
        [btn_findPassword setTitle:str forState:UIControlStateNormal];
        [btn_findPassword setColor:[UIColor whiteColor]];
        [bottomView addSubview:btn_findPassword];
        
        _scrollerView.contentSize = CGSizeMake(self.bounds.size.width, btn_findPassword.frame.origin.y+btn_findPassword.frame.size.height+10);
    }
    return self;
}

-(void)setEventObserver:(id<LoginViewDelegate>)eventObserver
{
    _eventObserver = eventObserver;
    [btn_login addTarget:eventObserver action:@selector(loginButton_onClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn_findPassword addTarget:eventObserver action:@selector(findPasswordButton_onClick:) forControlEvents:UIControlEventTouchUpInside];
    [_txt_userName addTarget:eventObserver action:@selector(textFiledReturnEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_txt_password addTarget:eventObserver action:@selector(textFiledReturnEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    _txt_userName.observer = _eventObserver;
    _txt_password.observer = _eventObserver;
}

-(IBAction)rememberCheckbox_onClick:(id)sender
{
    BOOL isSelect = NO;
    if(!rememberCheckboxMarkImageView.hidden)
    {
        rememberCheckboxMarkImageView.hidden = YES;
        isSelect = NO;
    }
    else
    {
        rememberCheckboxMarkImageView.hidden = NO;
        isSelect = YES;
    }
    if(self.eventObserver!=nil)
        [self.eventObserver rememberCheckbox_onClick:isSelect];
}

-(IBAction)autoLoginCheckbox_onClick:(id)sender
{
    BOOL isSelect = NO;
    if(!autoLoginCheckboxMarkImageView.hidden)
    {
        autoLoginCheckboxMarkImageView.hidden = YES;
        isSelect = NO;
    }
    else
    {
        autoLoginCheckboxMarkImageView.hidden = NO;
        isSelect = YES;
    }
    if(self.eventObserver!=nil)
        [self.eventObserver autoLoginCheckbox_onClick:isSelect];
}

-(void)setRememberStatus:(BOOL)rememberStatus
{
    _rememberStatus = rememberStatus;
    rememberCheckboxMarkImageView.hidden = !rememberStatus;
}

-(void)setAutoLoginStatus:(BOOL)autoLoginStatus
{
    _autoLoginStatus = autoLoginStatus;
    autoLoginCheckboxMarkImageView.hidden = !autoLoginStatus;
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
    self.eventObserver=nil;
}
@end
