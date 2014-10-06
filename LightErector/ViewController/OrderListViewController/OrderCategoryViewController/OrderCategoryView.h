//
//  OrderCategoryView.h
//  LightErector
//
//  Created by Jayden on 14-10-2.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "TitleBarAndScrollerView.h"
#import "CustomPullRefreshView.h"
#import "CustomPullRefreshTableView.h"
#import "CustomSegmentedControl.h"

#define TABLEVIEWCOUNT 5

#define UNACCEPTTABLETAG 101
#define UNSUBTABLETAG 102
#define UNINSTALLTABLETAG 103
#define SUBAGAINTABLETAG 104
#define UNFEEDBACKTABLETAG 105

@interface OrderCategoryView : TitleBarAndScrollerView
@property(nonatomic,strong) CustomPullRefreshTableView *currentTableView;
@property(nonatomic,strong)CustomSegmentedControl *segmentedControl;
@property(nonatomic,strong)CustomPullRefreshTableView *unAcceptTable;
@property(nonatomic,strong)CustomPullRefreshTableView *unSubTable;
@property(nonatomic,strong)CustomPullRefreshTableView *unInstallTable;
@property(nonatomic,strong)CustomPullRefreshTableView *subAgainTable;
@property(nonatomic,strong)CustomPullRefreshTableView *unFeedBackTable;

-(void)stopRefresh;
@end
