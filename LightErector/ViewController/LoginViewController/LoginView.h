//
//  LoginView.h
//  LightErector
//
//  Created by Jayden Zhao on 9/24/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "BaseScrollerView.h"

#import "CustomTextField.h"
#import "TextFiledReturnEditingDelegate.h"

@protocol LoginViewDelegate <NSObject>
@optional
-(void)rememberCheckbox_onClick:(BOOL)isSelect;
-(void)autoLoginCheckbox_onClick:(BOOL)isSelect;
-(IBAction)loginButton_onClick:(id)sender;
-(IBAction)findPasswordButton_onClick:(id)sender;
@end

@interface LoginView : BaseScrollerView
{
@private
    __weak id _eventObserver;
}
@property(nonatomic,weak)id<LoginViewDelegate,TextFiledReturnEditingDelegate> eventObserver;
@property(nonatomic)BOOL rememberStatus;
@property(nonatomic)BOOL autoLoginStatus;
@property(nonatomic,readonly)CustomTextField *txt_userName;
@property(nonatomic,readonly)CustomTextField *txt_password;
@end
