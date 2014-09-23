//
//  Message.h
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommandID.h"
#import "ModuleAndControllerID.h"

@interface Message : NSObject
{
@protected
    enum ModuleAndControllerID _receiveObjectID;
    enum ModuleAndControllerID _sendObjectID;
    enum commandID _commandID;
    BOOL _doCache;
    id _externData;
}
@property(nonatomic)enum ModuleAndControllerID receiveObjectID;
@property(nonatomic)enum ModuleAndControllerID sendObjectID;
@property(nonatomic)enum commandID commandID;
@property(nonatomic)BOOL doCache;
@property(nonatomic,strong)id externData;
@end
