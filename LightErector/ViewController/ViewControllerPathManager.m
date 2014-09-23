//
//  ViewControllerPathManager.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "ViewControllerPathManager.h"

@implementation Stack
-(id)init
{
	if ( (self = [super init]) ) {
		array = [[NSMutableArray alloc] init];
	}
    
	return self;
}

-(id)pop
{
	id object = [self peek];
	[array removeLastObject];
	return object;
}

-(void)push:(id)element
{
    [array addObject:element];
}

-(void)pushElementsFromArray:(NSArray*)arr
{
    [array addObjectsFromArray:arr];
}

-(id)peek
{
    return [array lastObject];
}

-(NSInteger)size
{
    return [array count];
}

-(BOOL)isEmpty
{
    return [array count] == 0;
}

-(void)clear
{
    [array removeAllObjects];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len;
{
    return [array countByEnumeratingWithState:state objects:buffer count:len];
}

@end

static Stack *idStack;
static  Stack *cacheStack;

@implementation ViewControllerPathManager


+(id)shareIdStack
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        idStack =  [[Stack alloc]init];
    });
    
    return idStack;
}

+(id)shareCacheStack
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cacheStack =  [[Stack alloc]init];
    });
    
    return cacheStack;
}

+(void)pushId:(NSNumber*)vid
{
    [[ViewControllerPathManager shareIdStack] push:vid];
}

+(void)pushCache:(BaseViewController*)vcache
{
    [[ViewControllerPathManager shareCacheStack] push:vcache];
}


+(NSNumber*)popId
{
   return [[ViewControllerPathManager shareIdStack] pop];
}

+(BaseViewController*)popCache
{
   return  [[ViewControllerPathManager shareCacheStack] pop];
}


+(void)clearIds
{
    [[ViewControllerPathManager shareIdStack] clear];
}

+(void)clearCache
{
    [[ViewControllerPathManager shareCacheStack] clear];
}


+(NSNumber*)peekId
{
    return  [[ViewControllerPathManager shareIdStack]peek];
}

+(BaseViewController*)peekCache
{
    return  [[ViewControllerPathManager shareCacheStack]peek];
}
@end
