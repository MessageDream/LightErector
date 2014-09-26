//
//  CustomSwipTableCellTableViewCell.h
//  LightErector
//
//  Created by Jayden Zhao on 9/26/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>

/** Transition types */
typedef enum CustomSwipeTransition {
    CustomSwipeTransitionBorder = 0,
    CustomSwipeTransitionStatic,
    CustomSwipeTransitionDrag,
    CustomSwipeTransitionClipCenter,
    CustomSwipeTransition3D,
    
} CustomSwipeTransition;

/** Swipe directions */
typedef enum CustomSwipeDirection {
    CustomSwipeDirectionLeftToRight = 0,
    CustomSwipeDirectionRightToLeft
    
} CustomSwipeDirection;


/**
 * Swipe settings
 **/
@interface CustomSwipeSettings: NSObject
/** Transition used while swipping buttons */
@property (nonatomic, assign) CustomSwipeTransition transition;
/** Size proportional threshold to hide/keep the buttons when the user ends swipping. Default value 0.5 */
@property (nonatomic, assign) CGFloat threshold;
@end


/**
 * Expansion settings to make expandable buttons
 * Swipe button are not expandable by default
 **/
@interface CustomSwipeExpansionSettings: NSObject
/** index of the expandable button (in the left or right buttons arrays) */
@property (nonatomic, assign) NSInteger buttonIndex;
/** if true the button fills the cell on trigger, else it bounces back to its initial position */
@property (nonatomic, assign) BOOL fillOnTrigger;
/** Size proportional threshold to trigger the expansion button. Default value 1.5 */
@property (nonatomic, assign) CGFloat threshold;
@end


/** helper forward declaration */
@class CustomSwipeTableCell;

/**
 * Optional delegate to configure swipe buttons or to receive triggered actions.
 * Buttons can be configured inline when the cell is created instead of using this delegate,
 * but using the delegate improves memory usage because buttons are only created in demand
 */
@protocol CustomSwipeTableCellDelegate <NSObject>

@optional
/**
 * Delegate method to enable/disable swipe gestures
 * @return YES if swipe is allowed
 **/
-(BOOL) swipeTableCell:(CustomSwipeTableCell*) cell canSwipe:(CustomSwipeDirection) direction;
/**
 * Called when the user clicks a swipe button or when a expandable button is automatically triggered
 * @return YES to autohide the current swipe buttons
 **/
-(BOOL) swipeTableCell:(CustomSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(CustomSwipeDirection)direction fromExpansion:(BOOL) fromExpansion;
/**
 * Delegate method to setup the swipe buttons and swipe/expansion settings
 * Buttons can be any kind of UIView but it's recommended to use the convenience CustomSwipeButton class
 * Setting up buttons with this delegate instead of using cell properties improves memory usage because buttons are only created in demand
 * @param swipeTableCell the UITableVieCel to configure. You can get the indexPath using [tableView indexPathForCell:cell]
 * @param direction The swipe direction (left to right or right to left)
 * @param swipeSettings instance to configure the swipe transition and setting (optional)
 * @param expansionSettings instance to configure button expansions (optional)
 * @return Buttons array
 **/
-(NSArray*) swipeTableCell:(CustomSwipeTableCell*) cell swipeButtonsForDirection:(CustomSwipeDirection)direction
             swipeSettings:(CustomSwipeSettings*) swipeSettings expansionSettings:(CustomSwipeExpansionSettings*) expansionSettings;

@end


/**
 * Swipe Cell class
 * To implement swipe cells you have to override from this class
 * You can create the cells programmatically, using xibs or storyboards
 */
@interface CustomSwipeTableCell : UITableViewCell

/** optional delegate (not retained) */
@property (nonatomic, assign) id<CustomSwipeTableCellDelegate> delegate;

/**
 * Left and right swipe buttons and its settings.
 * Buttons can be any kind of UIView but it's recommended to use the convenience CustomSwipeButton class
 */
@property (nonatomic, copy) NSArray * leftButtons;
@property (nonatomic, copy) NSArray * rightButtons;
@property (nonatomic, strong) CustomSwipeSettings * leftSwipeSettings;
@property (nonatomic, strong) CustomSwipeSettings * rightSwipeSettings;

/** Optional settings to allow expandable buttons */
@property (nonatomic, strong) CustomSwipeExpansionSettings * leftExpansion;
@property (nonatomic, strong) CustomSwipeExpansionSettings * rightExpansion;

/** Optional background color for swipe overlay. If not set, its inferred automatically from the cell contentView */
@property (nonatomic, strong) UIColor * swipeBackgroundColor;
/** Property to read or change the current swipe offset programmatically */
@property (nonatomic, assign) CGFloat swipeOffset;

/** Utility methods to show or hide swipe buttons programmatically */
-(void) hideSwipeAnimated: (BOOL) animated;
-(void) showSwipe: (CustomSwipeDirection) direction animated: (BOOL) animated;
-(void) setSwipeOffset:(CGFloat)offset animated: (BOOL) animated completion:(void(^)()) completion;

@end