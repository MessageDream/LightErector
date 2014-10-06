//
//  CustomScreenFullScreen.m
//  LightErector
//
//  Created by Jayden on 14-10-3.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "CustomScrollFullScreen.h"

typedef NS_ENUM(NSInteger, CustomScrollDirection) {
    CustomScrollDirectionNone,
    CustomScrollDirectionUp,
    CustomScrollDirectionDown,
};

CustomScrollDirection detectScrollDirection(currentOffsetY, previousOffsetY)
{
    return currentOffsetY > previousOffsetY ? CustomScrollDirectionUp   :
    currentOffsetY < previousOffsetY ? CustomScrollDirectionDown :
    CustomScrollDirectionNone;
}

@interface CustomScrollFullScreen ()
@property (nonatomic) CustomScrollDirection previousScrollDirection;
@property (nonatomic) CGFloat previousOffsetY;
@property (nonatomic) CGFloat accumulatedY;
@property (nonatomic, weak) id<UIScrollViewDelegate> forwardTarget;
@end

@implementation CustomScrollFullScreen

- (id)initWithForwardTarget:(id)forwardTarget
{
    self = [super init];
    if (self) {
        [self reset];
        _downThresholdY = 200.0;
        _upThresholdY = 0.0;
        _forwardTarget = forwardTarget;
    }
    return self;
}

- (void)reset
{
    _previousOffsetY = 0.0;
    _accumulatedY = 0.0;
    _previousScrollDirection = CustomScrollDirectionNone;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([_forwardTarget respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [_forwardTarget scrollViewDidScroll:scrollView];
    }
    
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    
    CustomScrollDirection currentScrollDirection = detectScrollDirection(currentOffsetY, _previousOffsetY);
    CGFloat topBoundary = -scrollView.contentInset.top;
    CGFloat bottomBoundary = scrollView.contentSize.height + scrollView.contentInset.bottom;
    
    BOOL isOverTopBoundary = currentOffsetY <= topBoundary;
    BOOL isOverBottomBoundary = currentOffsetY >= bottomBoundary;
    
    BOOL isBouncing = (isOverTopBoundary && currentScrollDirection != CustomScrollDirectionDown) || (isOverBottomBoundary && currentScrollDirection != CustomScrollDirectionUp);
    if (isBouncing || !scrollView.isDragging) {
        return;
    }
    
    CGFloat deltaY = _previousOffsetY - currentOffsetY;
    _accumulatedY += deltaY;
    
    switch (currentScrollDirection) {
        case CustomScrollDirectionUp:
        {
            BOOL isOverThreshold = _accumulatedY < -_upThresholdY;
            
            if (isOverThreshold || isOverBottomBoundary)  {
                if ([_delegate respondsToSelector:@selector(scrollFullScreen:scrollViewDidScrollUp:)]) {
                    [_delegate scrollFullScreen:self scrollViewDidScrollUp:deltaY];
                }
            }
        }
            break;
        case CustomScrollDirectionDown:
        {
            BOOL isOverThreshold = _accumulatedY > _downThresholdY;
            
            if (isOverThreshold || isOverTopBoundary) {
                if ([_delegate respondsToSelector:@selector(scrollFullScreen:scrollViewDidScrollDown:)]) {
                    [_delegate scrollFullScreen:self scrollViewDidScrollDown:deltaY];
                }
            }
        }
            break;
        case CustomScrollDirectionNone:
            break;
    }
    
    // reset acuumulated y when move opposite direction
    if (!isOverTopBoundary && !isOverBottomBoundary && _previousScrollDirection != currentScrollDirection) {
        _accumulatedY = 0;
    }
    
    _previousScrollDirection = currentScrollDirection;
    _previousOffsetY = currentOffsetY;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([_forwardTarget respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [_forwardTarget scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
    
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    
    CGFloat topBoundary = -scrollView.contentInset.top;
    CGFloat bottomBoundary = scrollView.contentSize.height + scrollView.contentInset.bottom;
    
    switch (_previousScrollDirection) {
        case CustomScrollDirectionUp:
        {
            BOOL isOverThreshold = _accumulatedY < -_upThresholdY;
            BOOL isOverBottomBoundary = currentOffsetY >= bottomBoundary;
            
            if (isOverThreshold || isOverBottomBoundary) {
                if ([_delegate respondsToSelector:@selector(scrollFullScreenScrollViewDidEndDraggingScrollUp:)]) {
                    [_delegate scrollFullScreenScrollViewDidEndDraggingScrollUp:self];
                }
            }
            break;
        }
        case CustomScrollDirectionDown:
        {
            BOOL isOverThreshold = _accumulatedY > _downThresholdY;
            BOOL isOverTopBoundary = currentOffsetY <= topBoundary;
            
            if (isOverThreshold || isOverTopBoundary) {
                if ([_delegate respondsToSelector:@selector(scrollFullScreenScrollViewDidEndDraggingScrollDown:)]) {
                    [_delegate scrollFullScreenScrollViewDidEndDraggingScrollDown:self];
                }
            }
            break;
        }
        case CustomScrollDirectionNone:
            break;
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    BOOL ret = YES;
    if ([_forwardTarget respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        ret = [_forwardTarget scrollViewShouldScrollToTop:scrollView];
    }
    if ([_delegate respondsToSelector:@selector(scrollFullScreenScrollViewDidEndDraggingScrollDown:)]) {
        [_delegate scrollFullScreenScrollViewDidEndDraggingScrollDown:self];
    }
    return ret;
}

#pragma mark -
#pragma mark Method Forwarding

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if(!signature) {
        if([_forwardTarget respondsToSelector:selector]) {
            return [(id)_forwardTarget methodSignatureForSelector:selector];
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation*)invocation
{
    if ([_forwardTarget respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:_forwardTarget];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    BOOL ret = [super respondsToSelector:aSelector];
    if (!ret) {
        ret = [_forwardTarget respondsToSelector:aSelector];
    }
    return ret;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.delegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0)
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]) {
        [self.delegate tableView:tableView willDisplayHeaderView:view forSection:section];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0)
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)]) {
        [self.delegate tableView:tableView willDisplayFooterView:view forSection:section];
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0)
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0)
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)]) {
        [self.delegate tableView:tableView didEndDisplayingHeaderView:view forSection:section];
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0)
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)]) {
        [self.delegate tableView:tableView didEndDisplayingFooterView:view forSection:section];
    }
}

// Variable height support

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
      return   [self.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return   [self.delegate tableView:tableView heightForHeaderInSection:section];
    }
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        return   [self.delegate tableView:tableView heightForFooterInSection:section];
    }
    return 0.0f;
}


// Section header & footer information. Views are preferred over title should you decide to provide both

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return   [self.delegate tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return   [self.delegate tableView:tableView viewForFooterInSection:section];
    }
    return nil;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
           [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }

}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0)
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}

@end
