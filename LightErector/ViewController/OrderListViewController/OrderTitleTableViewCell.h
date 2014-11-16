//
//  TodayTaskTableViewDetailCellTableViewCell.h
//  LightErector
//
//  Created by Jayden Zhao on 9/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PAGESIZE 20
#define CELL @"Cell"
#define MAINCELL @"MainCell"
#define ATTACHEDCELL @"AttachedCell"
#define ISATTACHED @"isAttached"

@interface UITableViewCellModel:NSObject
@property(nonatomic,strong)NSString *cellType;
@property(nonatomic,assign)BOOL isAttached;
@property(nonatomic,strong)id contentModel;
-(id)initWithCellType:(NSString *)cellType isAttached:(BOOL) isAttached andContentModel:(id)model;
@end

@interface OrderTitleTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *nameLable;
@property(nonatomic,strong)UILabel *mobileLable;
@property(nonatomic,strong)UILabel *priceLable;
@property(nonatomic,strong)UILabel *dateLable;
-(void)createOptionButtonsWithTitles:(NSArray *)titles andIcons:(NSArray *)icons andBackgroundColors:(NSArray *)backColors andAction:(void (^)(NSInteger buttonIndex))action;
-(void)showButtons;
-(void)hideButtons;
@end
