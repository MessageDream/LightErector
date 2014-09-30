//
//  TodayTaskViewController.h
//  LightErector
//
//  Created by Jayden Zhao on 9/26/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "BaseViewController.h"
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

@interface TodayTaskViewController : BaseViewController
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
