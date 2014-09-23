//
//  StringUtils.h
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(StringUtil)
-(BOOL)isValidateEmail;
-(BOOL)isValidateMobile;
- (BOOL)isValidateCall;
-(BOOL)isValidateCarNo;

-(BOOL) isValidateMobileLevel1;
-(BOOL) isValidateMobileLevel0;


-(BOOL) isValidateZip;

-(BOOL) isValidateZJ;
-(BOOL) isValidateUserName;
-(BOOL) isValidateAreaName;
-(BOOL) isValidatelat;
-(BOOL) isValidatelot;
-(BOOL) isValidateTotalMiles;
-(BOOL) isValidateIdentity;
-(BOOL) isValidateNumber;
-(BOOL) isValidatePassword;

@end
