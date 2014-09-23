//
//  ViewControllerPathManager.h
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModuleAndControllerID.h"
#import "BaseViewController.h"

@interface Stack : NSObject <NSFastEnumeration>
{
    NSMutableArray* array;
}

-(id)pop;
-(void)push:(id)element;
-(void)pushElementsFromArray:(NSArray*)arr;
-(void)clear;
-(id)peek;
-(NSInteger)size;
-(BOOL)isEmpty;

@end

@interface ViewControllerPathManager : NSObject
+(id)shareIdStack;
+(id)shareCacheStack;
+(void)pushId:(NSNumber*)vid;
+(void)pushCache:(BaseViewController*)vcache;
+(NSNumber*)popId;
+(BaseViewController*)popCache;
+(void)clearIds;
+(void)clearCache;
+(NSNumber*)peekId;
+(BaseViewController*)peekCache;
@end
