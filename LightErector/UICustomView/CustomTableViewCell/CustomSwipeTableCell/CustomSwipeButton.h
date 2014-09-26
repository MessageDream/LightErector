//
//  CustomSwipButton.h
//  LightErector
//
//  Created by Jayden Zhao on 9/26/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomSwipeTableCell;

/**
 * This is a convenience class to create CustomSwipeTableCell buttons
 * Using this class is optional because CustomSwipeTableCell is button agnostic and can use any UIView for that purpose
 * Anyway, it's recommended that you use this class because is totally tested and easy to use ;)
 */
@interface CustomSwipeButton : UIButton

/**
 * Convenience block callback for developers lazy to implement the CustomSwipeTableCellDelegate.
 * @return Return YES to autohide the swipe view
 */
typedef BOOL(^CustomSwipeButtonCallback)(CustomSwipeTableCell * sender);
@property (nonatomic, strong) CustomSwipeButtonCallback callback;

/**
 * Convenience static constructors
 */
+(instancetype) buttonWithTitle:(NSString *) title backgroundColor:(UIColor *) color;
+(instancetype) buttonWithTitle:(NSString *) title backgroundColor:(UIColor *) color callback:(CustomSwipeButtonCallback) callback;
+(instancetype) buttonWithTitle:(NSString *) title icon:(UIImage*) icon backgroundColor:(UIColor *) color;
+(instancetype) buttonWithTitle:(NSString *) title icon:(UIImage*) icon backgroundColor:(UIColor *) color callback:(CustomSwipeButtonCallback) callback;

@end