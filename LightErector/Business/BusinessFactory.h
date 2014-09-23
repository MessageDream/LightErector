//
//  BusinessFactory.h
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessType.h"
@interface BusinessFactory : NSObject
+(id)createBusiness:(enum BusinessType)type;
@end
