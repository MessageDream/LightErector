//
//  JPushNotification.h
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "PushNotification.h"

@interface JPushNotification : PushNotification
-(void)registerUserTags:(NSSet *)tags andAlias:(NSString*)alias callbackSelector:(SEL) sel target:(id)observer;
@end
