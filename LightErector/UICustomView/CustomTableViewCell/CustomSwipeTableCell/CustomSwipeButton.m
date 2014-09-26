//
//  CustomSwipButton.m
//  LightErector
//
//  Created by Jayden Zhao on 9/26/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "CustomSwipeButton.h"

@class CustomSwipeTableCell;

@implementation CustomSwipeButton

+(instancetype) buttonWithTitle:(NSString *) title backgroundColor:(UIColor *) color
{
    return [CustomSwipeButton buttonWithTitle:title icon:nil backgroundColor:color];
}

+(instancetype) buttonWithTitle:(NSString *) title backgroundColor:(UIColor *) color callback:(CustomSwipeButtonCallback) callback
{
    return [CustomSwipeButton buttonWithTitle:title icon:nil backgroundColor:color callback:callback];
}

+(instancetype) buttonWithTitle:(NSString *) title icon:(UIImage*) icon backgroundColor:(UIColor *) color
{
    return [CustomSwipeButton buttonWithTitle:title icon:icon backgroundColor:color callback:nil];
}

+(instancetype) buttonWithTitle:(NSString *) title icon:(UIImage*) icon backgroundColor:(UIColor *) color callback:(CustomSwipeButtonCallback) callback
{
    CustomSwipeButton * button = [CustomSwipeButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = color;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:icon forState:UIControlStateNormal];
    button.callback = callback;
    [button sizeToFit];
    CGRect frame = button.frame;
    frame.size.width += 10; //padding
    frame.size.width = MAX(50, frame.size.width); //initial min size
    button.frame = frame;
    return button;
}

-(BOOL) callCustomSwipeConvenienceCallback: (CustomSwipeTableCell *) sender
{
    if (_callback) {
        return _callback(sender);
    }
    return NO;
}

@end

