//
//  MD5.h
//  LightErector
//
//  Created by Jayden Zhao on 9/24/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5 : NSObject
+(NSString*)stringConvertMD5Len16:(NSString*)str;
+(NSString*)stringConvertMD5Len32:(NSString*)str;
@end
