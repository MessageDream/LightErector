//
//  CustomScreenFullScreen.h
//  LightErector
//
//  Created by Jayden on 14-10-3.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CustomScrollFullscreenDelegate;

@interface CustomScrollFullScreen : NSObject<UITableViewDelegate>

@property (nonatomic, weak) id<CustomScrollFullscreenDelegate> delegate;

@property (nonatomic) CGFloat upThresholdY; // up distance until fire. default 0 px.
@property (nonatomic) CGFloat downThresholdY; // down distance until fire. default 200 px.

- (id)initWithForwardTarget:(id)forwardTarget;
- (void)reset;

@end

@protocol CustomScrollFullscreenDelegate <UITableViewDelegate>
- (void)scrollFullScreen:(CustomScrollFullScreen *)fullScreenProxy scrollViewDidScrollUp:(CGFloat)deltaY;
- (void)scrollFullScreen:(CustomScrollFullScreen *)fullScreenProxy scrollViewDidScrollDown:(CGFloat)deltaY;
- (void)scrollFullScreenScrollViewDidEndDraggingScrollUp:(CustomScrollFullScreen *)fullScreenProxy;
- (void)scrollFullScreenScrollViewDidEndDraggingScrollDown:(CustomScrollFullScreen *)fullScreenProxy;
@end
