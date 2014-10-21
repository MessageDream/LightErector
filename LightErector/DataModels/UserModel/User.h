//
//  User.h
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "BaseDataModel.h"
#import "UserInfo.h"

enum UserLoginStatus
{
    UserLoginStatus_NoLogin = 0,
    UserLoginStatus_Login,
    UserLoginStatus_Logout
};

@interface User : BaseDataModel
@property (nonatomic,readonly)NSInteger  userid;
@property (nonatomic,readonly)NSString  *userName;
@property (nonatomic,readonly)NSString  *password;
@property (nonatomic,readonly)UserInfo  *userInfo;
@property(nonatomic,assign)enum UserLoginStatus userLoginStatus;
@property(nonatomic,assign)BOOL autoLoginFlag;
@property(nonatomic,assign)BOOL rememberFlag;
@property(nonatomic,assign)BOOL wifiCheck;
+(User*)shareUser;
-(void)login:(NSString  *)userName withPassword:(NSString  *)password;
-(void)logout;
-(void)updateInfo;
-(void)setAutoLoginFlag:(BOOL)autoLogin;
-(void)setRememberFlag:(BOOL)remember;
-(void)getVeryCode:(NSString *)userName;
-(void)changePwd:(NSString *)pwd;
-(void)uploadUserName:(NSString *)userName andVeryCode:(NSString *)veryCode;
@end
