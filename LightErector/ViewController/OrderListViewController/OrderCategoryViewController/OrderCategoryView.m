//
//  OrderCategoryView.m
//  LightErector
//
//  Created by Jayden on 14-10-2.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "OrderCategoryView.h"
#define SEGMENTEDCONTROLHEIGHT 30
#define TABLEVIEWCOUNT 5
@interface OrderCategoryView ()<UIScrollViewDelegate>

@end
@implementation OrderCategoryView

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
        self.segmentedControl.selectedTextColor = [MainStyle mainLightColor];
        self.segmentedControl.selectionIndicatorColor = [MainStyle mainLightColor];
        self.segmentedControl.selectionStyle = CustomSegmentedControlSelectionStyleFullWidthStripe;
        self.segmentedControl.selectionIndicatorLocation = CustomSegmentedControlSelectionIndicatorLocationDown;
        
        __block OrderCategoryView *blockSelf=self;
        [ self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
            NSLog(@"Selected index %ld (via block)", (long)index);
            [blockSelf.scrollerView scrollRectToVisible:CGRectMake(index*frame.size.width, 0, frame.size.width, blockSelf.scrollerView.frame.size.height) animated:YES];
        }];
        
        UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, self.segmentedControl.frame.size.height-0.5, frame.size.width, 0.5)];
        lineView.backgroundColor=[MainStyle mainTitleColor];
        [self.segmentedControl addSubview:lineView];
        
        [self addSubview:self.segmentedControl];
        
        self.scrollerView.frame=CGRectMake(0,  self.segmentedControl.frame.origin.y+SEGMENTEDCONTROLHEIGHT, frame.size.width, frame.size.height-(self.segmentedControl.frame.origin.y+SEGMENTEDCONTROLHEIGHT));
        self.scrollerView.backgroundColor = [UIColor clearColor];
        self.scrollerView.pagingEnabled = YES;
        self.scrollerView.showsHorizontalScrollIndicator = NO;
        self.scrollerView.contentSize = CGSizeMake(frame.size.width*TABLEVIEWCOUNT, self.scrollerView.frame.size.height);
        self.scrollerView.delegate = self;
        [self.scrollerView scrollRectToVisible:CGRectMake(0, 0, frame.size.width, self.scrollerView.frame.size.height) animated:NO];
        
        self.unAcceptTable=[self createTableViewWithFrame:CGRectMake(0, 0, frame.size.width, self.scrollerView.frame.size.height)];
        self.unAcceptTable.tag=UNACCEPTTABLETAG;
        self.unAcceptTable.backgroundColor=[UIColor redColor];
        [self.scrollerView addSubview:self.unAcceptTable];
        
        self.unSubTable=[self createTableViewWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, self.scrollerView.frame.size.height)];
         self.unSubTable.tag=UNSUBTABLETAG;
        self.unSubTable.backgroundColor=[UIColor greenColor];
        [self.scrollerView addSubview:self.unSubTable];
        
        self.unInstallTable=[self createTableViewWithFrame:CGRectMake(frame.size.width*2, 0, frame.size.width, self.scrollerView.frame.size.height)];
        self.unInstallTable.tag=UNINSTALLTABLETAG;
        self.unInstallTable.backgroundColor=[UIColor grayColor];
        [self.scrollerView addSubview:self.unInstallTable];
        
        self.subAgainTable=[self createTableViewWithFrame:CGRectMake(frame.size.width*3, 0, frame.size.width, self.scrollerView.frame.size.height)];
         self.subAgainTable.tag=SUBAGAINTABLETAG;
        self.subAgainTable.backgroundColor=[UIColor yellowColor];
        [self.scrollerView addSubview:self.subAgainTable];
        
        self.unFeedBackTable=[self createTableViewWithFrame:CGRectMake(frame.size.width*4, 0, frame.size.width, self.scrollerView.frame.size.height)];
        self.unFeedBackTable.tag=UNFEEDBACKTABLETAG;
         self.unFeedBackTable.backgroundColor=[UIColor orangeColor];
        [self.scrollerView addSubview:self.unFeedBackTable];
    }
    return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}

-(CustomPullRefreshTableView *)createTableViewWithFrame:(CGRect )frame
{
    CustomPullRefreshTableView *tableView=[[CustomPullRefreshTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.pullRefreshViewPositionBottomEnable=YES;
    tableView.backgroundColor=[UIColor clearColor];
    return tableView;
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
