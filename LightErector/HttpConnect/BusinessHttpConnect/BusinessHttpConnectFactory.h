//
//  BusinessHttpConnectFactory.h
//  LightErector
//
//  Created by Jayden Zhao on 13-4-8.
//  Copyright (c) 2013年 LightErector. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessHttpConnectType.h"
@interface BusinessHttpConnectFactory : NSObject
+(id)createBusinessHttpConnect:(enum BusinessHttpConnectType)type;
@end
