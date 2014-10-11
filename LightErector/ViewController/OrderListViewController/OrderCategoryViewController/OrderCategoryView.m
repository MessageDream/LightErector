//
//  OrderCategoryView.m
//  LightErector
//
//  Created by Jayden on 14-10-2.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "OrderCategoryView.h"


#define SEGMENTEDCONTROLHEIGHT 30

@interface OrderCategoryView ()<UIScrollViewDelegate>
{
    CustomPullRefreshTableView *currentTableView;
}
@end
@implementation OrderCategoryView
@synthesize currentTableView=currentTableView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.customTitleBar.titleText= NSLocalizedStringFromTable(@"OrderList",Res_String,@"");
        self.segmentedControl = [[CustomSegmentedControl alloc] initWithFrame:CGRectMake(0, self.customTitleBar.frame.origin.x+ self.customTitleBar.frame.size.height, frame.size.width, SEGMENTEDCONTROLHEIGHT)];
        self.segmentedControl.sectionTitles = @[ NSLocalizedStringFromTable(@"UnAccept",Res_String,@""),  NSLocalizedStringFromTable(@"UnSub",Res_String,@""), NSLocalizedStringFromTable(@"UnInstall",Res_String,@""), NSLocalizedStringFromTable(@"SubAgain",Res_String,@""), NSLocalizedStringFromTable(@"UnFeedBack",Res_String,@"")];
        self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        self.segmentedControl.backgroundColor = [UIColor clearColor];
        self.segmentedControl.textColor = [MainStyle mainTitleColor];
        self.segmentedControl.selectedTextColor = [MainStyle mainGreenColor];
        self.segmentedControl.selectionIndicatorColor = [MainStyle mainGreenColor];
        self.segmentedControl.selectionStyle = CustomSegmentedControlSelectionStyleFullWidthStripe;
        self.segmentedControl.selectionIndicatorLocation = CustomSegmentedControlSelectionIndicatorLocationDown;
        
        __block OrderCategoryView *blockSelf=self;
        [ self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
            [blockSelf.scrollerView scrollRectToVisible:CGRectMake(index*frame.size.width, 0, frame.size.width, blockSelf.scrollerView.frame.size.height) animated:NO];
        }];
        
        UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, self.segmentedControl.frame.size.height, frame.size.width, 0.5)];
        lineView.backgroundColor=[MainStyle mainDarkColor];
        [self.segmentedControl addSubview:lineView];
        
        [self addSubview:self.segmentedControl];
       // self.segmentedControl.layer.zPosition=self.customTitleBar.layer.zPosition-1;
        
        self.scrollerView.frame=CGRectMake(0,  self.segmentedControl.frame.origin.y+SEGMENTEDCONTROLHEIGHT+0.5, frame.size.width, frame.size.height-(self.segmentedControl.frame.origin.y+SEGMENTEDCONTROLHEIGHT));
        self.scrollerView.backgroundColor = [UIColor clearColor];
        //self.scrollerView.pagingEnabled = YES;
        self.scrollerView.showsHorizontalScrollIndicator = NO;
        self.scrollerView.scrollEnabled=NO;
        self.scrollerView.contentSize = CGSizeMake(frame.size.width*TABLEVIEWCOUNT, self.scrollerView.frame.size.height+10);
        self.scrollerView.delegate = self;
        
        self.scrollerView.alwaysBounceVertical = YES;
        self.scrollerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.scrollerView scrollRectToVisible:CGRectMake(0, 0, frame.size.width, self.scrollerView.frame.size.height) animated:NO];
        
        self.unAcceptTable=[self createTableViewWithFrame:CGRectMake(0, 0, frame.size.width, self.scrollerView.frame.size.height)];
        self.unAcceptTable.tag=UNACCEPTTABLETAG;
        [self.scrollerView addSubview:self.unAcceptTable];
        
        self.unSubTable=[self createTableViewWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, self.scrollerView.frame.size.height)];
         self.unSubTable.tag=UNSUBTABLETAG;
        [self.scrollerView addSubview:self.unSubTable];
        
        self.unInstallTable=[self createTableViewWithFrame:CGRectMake(frame.size.width*2, 0, frame.size.width, self.scrollerView.frame.size.height)];
        self.unInstallTable.tag=UNINSTALLTABLETAG;
        [self.scrollerView addSubview:self.unInstallTable];
        
        self.subAgainTable=[self createTableViewWithFrame:CGRectMake(frame.size.width*3, 0, frame.size.width, self.scrollerView.frame.size.height)];
         self.subAgainTable.tag=SUBAGAINTABLETAG;
        [self.scrollerView addSubview:self.subAgainTable];
        
        self.unFeedBackTable=[self createTableViewWithFrame:CGRectMake(frame.size.width*4, 0, frame.size.width, self.scrollerView.frame.size.height)];
        self.unFeedBackTable.tag=UNFEEDBACKTABLETAG;
        [self.scrollerView addSubview:self.unFeedBackTable];

        currentTableView=self.unAcceptTable;
       
        CGRect rect=frame;
        rect.origin.y=self.segmentedControl.frame.origin.y;
        rect.size.height=rect.size.height+DefaultTabBarHeight-self.segmentedControl.frame.origin.y;
        self.editTimeView=[[UIView alloc] initWithFrame:rect];
        self.editTimeView.backgroundColor=[MainStyle mainBackColor];
        //self.editTimeView.layer.opacity=0.9f;
        self.editTimeView.hidden=YES;
        [self addSubview:self.editTimeView];
        self.dataPicker=[[CustomUIDatePicker alloc]initWithFrame:CGRectMake(0,  self.editTimeView.frame.size.height-216, frame.size.width, 216)];
        [self.editTimeView addSubview:self.dataPicker];
        self.textReson=[[CustomTextView alloc] initWithFrame:CGRectMake(10, 10, frame.size.width-20,self.editTimeView.frame.size.height-self.dataPicker.frame.size.height-20)];
        self.textReson.backgroundColor=[MainStyle mainLightTwoColor];
        self.textReson.placeholder=@"请输入修改安装时间原因";
        [self.editTimeView addSubview:self.textReson];
    }
    return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    switch (page) {
        case 0:
            currentTableView=self.unAcceptTable;
            break;
        case 1:
            currentTableView=self.unSubTable;
            break;
        case 2:
            currentTableView=self.unInstallTable;
            break;
        case 3:
            currentTableView=self.subAgainTable;
            break;
        case 4:
            currentTableView=self.unFeedBackTable;
            break;
        default:
            break;
    }
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}

-(CustomPullRefreshTableView *)createTableViewWithFrame:(CGRect )frame
{
    CustomPullRefreshTableView *tableView=[[CustomPullRefreshTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
  //  tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor=[UIColor clearColor];
    tableView.showsVerticalScrollIndicator=NO;
    tableView.pullRefreshViewPositionBottomEnable=YES;
    return tableView;
}

-(UIView *)creatContentView:(CustomPullRefreshTableView *)tableView
{
    UIView *view=[[UIView alloc] initWithFrame:tableView.frame];
    view.backgroundColor=[UIColor clearColor];
    CGRect rect= tableView.frame;
    rect.origin=CGPointMake(0, 0);
    tableView.frame=rect;
    [view addSubview:tableView];
    return view;
}

-(void)stopRefresh
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
