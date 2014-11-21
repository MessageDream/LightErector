//
//  MD5.m
//  LightErector
//
//  Created by Jayden Zhao on 9/24/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MD5
+(NSString*)stringConvertMD5Len16:(NSString*)str
{
    return [self stringConvertMD5:str withLen:16];
}

+(NSString*)stringConvertMD5Len32:(NSString*)str
{
return [self stringConvertMD5:str withLen:32];
}

+(NSString*)stringConvertMD5:(NSString*)str withLen:(int)len
{
    const char *cStr = [str UTF8String];
    unsigned char result[len];
    CC_MD5( cStr, strlen(cStr), result );
    
    NSMutableString *hash = [NSMutableString string];
    for(int i=0;i<len/2;i++)
    {
        [hash appendFormat:@"%02x",result[i]];
    }
    return [hash lowercaseString];
}
@end
