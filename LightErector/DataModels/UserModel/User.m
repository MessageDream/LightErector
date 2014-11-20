//
//  User.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "User.h"
#import "UserInfo.h"
#import "NtspHeader.h"
#import "MD5.h"
#import "JPushNotification.h"

#define SAVE_FILE_NAME @"userSeting.json"

@interface User()
{
    NSString *saveNewPassword;
    NSString *saveFilePath;
}
-(void)destroyUser;
-(void)writeLocalFile;
-(void)readLocalFile;
@end

@implementation User

+(User*)shareUser
{
    static User *user;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user =  [[User alloc] init];
    });
    
    return user;
}

-(id)init
{
    if (self = [super init]) {
        _autoLoginFlag=YES;
        _rememberFlag=YES;
         _setting=[[UserSetting alloc] init];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        saveFilePath = [paths objectAtIndex:0];
        saveFilePath = [saveFilePath stringByAppendingString:@"/"];
        saveFilePath = [saveFilePath stringByAppendingString:SAVE_FILE_NAME];
        [self readLocalFile];
    }
    return self;
}

-(void)updateInfo
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:[_userInfo convertToDic]];
    [dic setObject:@(self.userid) forKey:@"memberid"];
    [self creatBusinessWithId:BUSINESS_UPDATEUSERINFO andExecuteWithData:dic];
}

-(void)login:(NSString  *)userName withPassword:(NSString  *)password
{
    _userName=userName;
    _password=password;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:userName forKey:@"username"];
    [dict setObject:[MD5 stringConvertMD5Len32:password] forKey:@"password"];
    
    [self creatBusinessWithId:BUSINESS_LOGIN andExecuteWithData:dict];
}

-(void)logout
{
     //[self creatBusinessWithId:BUSINESS_LOGOUT andExecuteWithData:nil];
    [self destroyUser];
}


-(void)destroyUser
{
    _userInfo=nil;
    _userLoginStatus=UserLoginStatus_Logout;
}

-(void)writeLocalFile
{
    if(_userName == nil || _password == nil)
        return;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSNumber numberWithInt:self.userid] forKey:@"userId"];
    [dic setObject:[NSNumber numberWithBool:self.autoLoginFlag] forKey:@"autoLoginFlag"];
    [dic setObject:[NSNumber numberWithBool:self.rememberFlag] forKey:@"rememberFlag"];
    [dic setObject:_userName forKey:@"username"];
    [dic setObject:_password forKey:@"password"];
    [dic setObject:[NSNumber numberWithBool:self.wifiCheck] forKey:@"wifiCheck"];
    [dic setObject:[self.setting toDic]forKey:@"setting"];
    if(![NSJSONSerialization isValidJSONObject:dic])
        return;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    [data writeToFile:saveFilePath atomically:YES];
}

-(void)readLocalFile
{
    NSData *data = [[NSData alloc] initWithContentsOfFile:saveFilePath];
    if(data==nil)
        return;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    if(dic==nil)
        return;
    _userid=[[dic objectForKey:@"userId"] integerValue];
    _userName = [dic objectForKey:@"username"];
    _password = [dic objectForKey:@"password"];
    _autoLoginFlag = [[dic objectForKey:@"autoLoginFlag"] boolValue];
    _rememberFlag = [[dic objectForKey:@"rememberFlag"] boolValue];
    _wifiCheck = [[dic objectForKey:@"wifiCheck"] boolValue];
    
    NSDictionary *set=[dic objectForKey:@"setting"];
    if (!set) {
        _setting.taskReminde=YES;
    }else{
        _setting=[[UserSetting alloc] initWithDic:set];
    }
}

-(void)setAutoLoginFlag:(BOOL)autoLogin
{
    _autoLoginFlag=autoLogin;
    [self writeLocalFile];
}

-(void)setRememberFlag:(BOOL)remember
{
    _rememberFlag=remember;
    [self writeLocalFile];
}

-(void)getVeryCode:(NSString *)userName
{
    NSDictionary *dic=[NSDictionary dictionaryWithObject:userName forKey:@"username"];
    [self creatBusinessWithId:BUSINESS_GETVERYCODE andExecuteWithData:dic];
}

-(void)changePwd:(NSString *)pwd
{
 NSDictionary *dic=[NSDictionary dictionaryWithObjects:@[_userName,pwd] forKeys:@[@"username",@"userpwd"]];
    [self creatBusinessWithId:BUSINESS_CHANGEPWD andExecuteWithData:dic];
}

-(void)uploadUserName:(NSString *)userName andVeryCode:(NSString *)veryCode
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjects:@[userName,veryCode] forKeys:@[@"username",@"verify"]];
    [self creatBusinessWithId:BUSINESS_UPLOADNAMEANDCODE andExecuteWithData:dic];

}

-(void)feedbackWithTitle:(NSString *)title andContent:(NSString *)content
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjects:@[@(self.userid),title,content] forKeys:@[@"memberid",@"title",@"content"]];
    [self creatBusinessWithId:BUSINESS_OTHER_FEEDBACK andExecuteWithData:dic];
}

-(void)saveUserSetting
{
    [self writeLocalFile];
}
-(void)loadUserSetting
{
    [self readLocalFile];
}
#pragma mark - BusinessProtocol
- (void)didBusinessSucess:(BaseBusiness *)business withData:(NSDictionary*)businessData
{
    if(business.businessId == BUSINESS_LOGIN)
    {
         NSArray *subTags=[businessData objectForKey:@"subscribearr"];
        //设置推送的对象为当前用户
        [((JPushNotification*)[PushNotification sharePushNotification]) registerUserTags:[NSSet setWithArray:@[subTags[1],subTags[2],subTags[3]]]andAlias:[NSString stringWithFormat:@"%@",subTags[4]] callbackSelector:@selector(jpushCallBack:tags:alias:) target:self];
        
        NSDictionary *data=[businessData objectForKey:@"userinfo"];
         _userid=[[data objectForKey:@"memberid"] integerValue];
        _userName=[data objectForKey:@"username"];
        _userInfo=[[UserInfo alloc] initWithDic:data];
        //if (_rememberFlag) {
            [self writeLocalFile];
       // }
        _userLoginStatus=UserLoginStatus_Login;
    }
    else if (business.businessId == BUSINESS_LOGOUT)
    {
        [self destroyUser];
    }
    else if (business.businessId == BUSINESS_COMMITFEEDBACK)
    {
        
    }
    else if (business.businessId == BUSINESS_UPLOADNAMEANDCODE)
    {
        _userName=[businessData objectForKey:@"username"];
    }
    
    [super didBusinessSucess:business withData:businessData];
}

- (void)jpushCallBack:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
#ifdef DEBUG_LOG
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
#endif
}
@end
