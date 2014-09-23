//
//  NtspHeader.h
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NtspHeader : NSObject
{
    int _errcode;
}

@property(strong , nonatomic) NSString * apikey;
@property(strong , nonatomic) NSString * version;
@property(strong , nonatomic) NSString * sessionid;
@property(nonatomic) int errcode;
@property(strong , nonatomic) NSString * errmsg;
// from object to json style
- (NSDictionary *)toDicValue;
- (void)initWithJson:(NSDictionary*)jsonDic;
@end
