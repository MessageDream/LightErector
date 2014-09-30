//
//  TodayTaskTableViewDetailCellTableViewCell.h
//  LightErector
//
//  Created by Jayden Zhao on 9/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TodayTaskTableViewTitleCell : UITableViewCell
-(void)createOptionButtonsWithTitles:(NSArray *)titles andIcons:(NSArray *)icons andBackgroundColors:(NSArray *)backColors andAction:(void (^)(NSInteger buttonIndex))action;
-(void)showButtons;
-(void)hideButtons;
@end
