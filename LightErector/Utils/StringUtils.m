//
//  StringUtils.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "StringUtils.h"

@implementation NSString(StringUtil)

-(BOOL)isValidateEmail
{
    NSString *emailRegex = @"^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
-(BOOL)isValidateMobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:self];
}

- (BOOL) isValidateCall
{
    NSString *callRegex = @"^0\\d{2}-\\d{8}|0\\d{2}-\\d{7}|0\\d{3}-\\d{7}|0\\d{3}-\\d{8}$";
    NSPredicate *callTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",callRegex];
    return [callTest evaluateWithObject:self];
}

-(BOOL)isValidateCarNo
{
    NSString *carRegex = @"^[\u4E00-\u9FA5][A-Za-z][\\dA-za-z]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}

-(BOOL) isValidateMobileLevel1
{
    NSString *carRegex = @"^[\\d-]{1,20}";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}


-(BOOL) isValidateMobileLevel0
{
    NSString *carRegex = @"^(1(3[4-9]|5[012789]|8[23478])\\d{8})$|^(1(3[0-2]|5[56]|8[56]|45)\\d{8})$|^((133|153|180|181|189)\\d{8})$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}

-(BOOL) isValidateZip
{
    NSString *carRegex = @"^\\d{6}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}

-(BOOL) isValidateZJ
{
    NSString *carRegex = @"^\\d{8}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}

-(BOOL) isValidateUserName
{
    NSString *carRegex = @"^(?![0-9]{8}$)[a-zA-Z0-9\u4E00-\u9FA5_-]{1,20}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}

-(BOOL) isValidateAreaName
{
    NSString *carRegex = @"^(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|$!:,.;]*[A-Za-z0-9+&@#/%=~_|$]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}

-(BOOL) isValidatelat
{
    NSString *carRegex = @"^-?(([0-9]|[1-9]\\d|1[0-7]\\d)(\\.\\d{1,6})?|180(\\.0{1,6})?)$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}

-(BOOL) isValidatelot
{
    NSString *carRegex = @"^-?([0-9]|[1-8]\\d)(\\.\\d{1,6})?$|^90(\\.0{1,6})?$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}

-(BOOL) isValidateTotalMiles
{
    NSString *carRegex = @"^[1-9]\\d{0,5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}

-(BOOL) isValidateIdentity
{
    NSString *carRegex = @"^\\d{17}[\\d|x|X]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}


-(BOOL) isValidateNumber
{
    NSString *numberRegex = @"^\\+?[1-9][0-9]*$";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
    NSLog(@"carTest is %@",numberTest);
    return [numberTest evaluateWithObject:self];
}

-(BOOL) isValidatePassword
{
    NSString *pwdRegex = @"^[\\S]{6,14}$";
    NSPredicate *pwdrTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pwdRegex];
    NSLog(@"passwordTest is %@",pwdrTest);
    return [pwdrTest evaluateWithObject:self];
}
@end
