//
//  CustomTabBar.m
//  TOYOTA_ZhijiaX
//
//  Created by jayden on 14-8-1.
//  Copyright (c) 2014年 95190. All rights reserved.
//

#import "CustomTabBar.h"
#define InterTabMargin 1
@implementation CustomTabBar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeRedraw;
        self.opaque = YES;
        self.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                 UIViewAutoresizingFlexibleHeight |
                                 UIViewAutoresizingFlexibleTopMargin);
    }
    return self;
}

#pragma mark - Setters and Getters

- (void)setTabs:(NSArray *)array
{
    if (_tabs != array) {
        for (CustomTabBarItem *tab in _tabs) {
            [tab removeFromSuperview];
        }
        
        _tabs = array;
        
        for (CustomTabBarItem *tab in _tabs) {
            tab.userInteractionEnabled = YES;
            [tab addTarget:self action:@selector(tabSelected:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    [self setNeedsLayout];
}

- (void)setSelectedTab:(CustomTabBarItem *)selectedTab {
    if (selectedTab != _selectedTab) {
        [_selectedTab setSelected:NO];
        _selectedTab = selectedTab;
        [_selectedTab setSelected:YES];
    }
}

#pragma mark - Delegate notification

- (void)tabSelected:(CustomTabBarItem *)sender
{
    [_delegate tabBar:self didSelectTabAtIndex:[_tabs indexOfObject:sender]];
}


#pragma mark - Drawing & Layout

- (void)drawRect:(CGRect)rect
{
    // Drawing the tab bar background
	CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // fill ingthe background with a noise pattern
    [[UIColor colorWithPatternImage:[UIImage imageNamed:_backgroundImageName ? _backgroundImageName : @"CustomTabBarItemBarController.bundle/noise-pattern"]] set];
    
    CGContextFillRect(ctx, rect);
    
    // Drawing the gradient
    CGContextSaveGState(ctx);
    {
        // We set the parameters of the gradient multiply blend
        size_t num_locations = 2;
        CGFloat locations[2] = {0.0, 1.0};
        CGFloat components[8] = {0.9, 0.9, 0.9, 1.0,    // Start color
            0.2, 0.2, 0.2, 0.8};    // End color
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = _tabColors ? CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)_tabColors, locations) : CGGradientCreateWithColorComponents (colorSpace, components, locations, num_locations);
        CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
        CGContextDrawLinearGradient(ctx, gradient, CGPointMake(0, 0), CGPointMake(0, rect.size.height), kCGGradientDrawsAfterEndLocation);
        
        CGColorSpaceRelease(colorSpace);
        CGGradientRelease(gradient);
    }
    CGContextRestoreGState(ctx);
    
    // Drawing the top dark emboss
    CGContextSaveGState(ctx);
    {
        CGContextSetFillColorWithColor(ctx, _edgeColor ? [_edgeColor CGColor] : [[UIColor colorWithRed:.1f green:.1f blue:.1f alpha:.8f] CGColor]);
        CGContextFillRect(ctx, CGRectMake(0, 0, rect.size.width, 1));
    }
    CGContextRestoreGState(ctx);
    
    // Drawing the top bright emboss
    CGContextSaveGState(ctx);
    {
        CGContextSetBlendMode(ctx, kCGBlendModeOverlay);
        CGContextSetRGBFillColor(ctx, 0.9, 0.9, 0.9, 0.7);
        CGContextFillRect(ctx, CGRectMake(0, 1, rect.size.width, 1));
        
    }
    CGContextRestoreGState(ctx);
    
    // Drawing the edge border lines
    CGContextSetFillColorWithColor(ctx, _edgeColor ? [_edgeColor CGColor] : [[UIColor colorWithRed:.1f green:.1f blue:.1f alpha:.8f] CGColor]);
    for (CustomTabBarItem *tab in _tabs)
        CGContextFillRect(ctx, CGRectMake(tab.frame.origin.x - InterTabMargin, 0, InterTabMargin, rect.size.height));
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat screenWidth = self.bounds.size.width;
    
    CGFloat tabNumber = _tabs.count;
    
    // Calculating the tabs width.
    CGFloat tabWidth = floorf(((screenWidth + 1) / tabNumber) - 1);
    
    // Because of the screen size, it is impossible to have tabs with the same
    // width. Therefore we have to increase each tab width by one until we spend
    // of the spaceLeft counter.
    CGFloat spaceLeft = screenWidth - (tabWidth * tabNumber) - (tabNumber - 1);
    
    CGRect rect = self.bounds;
    rect.size.width = tabWidth;
    
    CGFloat dTabWith;
    
    for (CustomTabBarItem *tab in _tabs) {
        
        // Here is the code that increment the width until we use all the space left
        
        dTabWith = tabWidth;
        
        if (spaceLeft != 0) {
            dTabWith = tabWidth + 1;
            spaceLeft--;
        }
        
        if ([_tabs indexOfObject:tab] == 0) {
            tab.frame = CGRectMake(rect.origin.x, rect.origin.y, dTabWith, rect.size.height);
        } else {
            tab.frame = CGRectMake(rect.origin.x + InterTabMargin, rect.origin.y, dTabWith, rect.size.height);
        }
        
        [self addSubview:tab];
        rect.origin.x = tab.frame.origin.x + tab.frame.size.width;
    }
    
}

@end
