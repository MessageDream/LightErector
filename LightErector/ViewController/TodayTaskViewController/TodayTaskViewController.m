//
//  TodayTaskViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 9/26/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "TodayTaskViewController.h"
#import "TodayTaskView.h"
#import "TodayTaskTableViewCell.h"
#import "CustomSwipeButton.h"
#import "TodayTaskTableViewTitleCell.h"
#import "TradeInfo.h"
#import "Order.h"
#define PAGESIZE 1

@implementation UITableViewCellModel
-(id)initWithCellType:(NSString *)cellType isAttached:(BOOL) isAttached andContentModel:(id)model
{
    if (self=[super init]) {
        _cellType=cellType;
        _isAttached=isAttached;
        _contentModel=model;
    }
    return self;
}
@end

@interface TodayTaskViewController () <UITableViewDelegate,UITableViewDataSource,CustomPullRefreshTableViewDelegate>
{
    NSInteger currentPageIndex;
    TradeInfo *trade;
    CustomPullRefreshTableView *mainTableView;
}
@end

@implementation TodayTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)settingViewControllerId
{
    _viewControllerId=VIEWCONTROLLER_TODAYTASK;
}

-(void)loadView
{
    
    CGRect frame=[self createViewFrame];
    frame.size.height=frame.size.height-DefaultTabBarHeight;
    TodayTaskView *taskView=[[TodayTaskView alloc]initWithFrame:frame];
    taskView.tableView.delegate=self;
    taskView.tableView.dataSource=self;
    taskView.tableView.pullRefreshDelegate=self;
    mainTableView=taskView.tableView;
    self.view=taskView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    trade=[TradeInfo shareTrade];
    trade.observer=self;
    [trade getTodayTaskOrdersById:user.userid withPageIndex:currentPageIndex forPagesize:PAGESIZE];
 
    self.dataArray = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)didDataModelNoticeSucess:(BaseDataModel *)baseDataModel forBusinessType:(BusinessType)businessID
{
    [super didDataModelNoticeSucess:baseDataModel forBusinessType:businessID];
    switch (businessID) {
        case BUSINESS_GETTODAYTASKORDER:{
            NSMutableArray *pathArray=[[NSMutableArray alloc] init];
            NSInteger count=trade.todayTaskOrders.count;
            NSInteger nowCount=self.dataArray.count;
            
            for (int i=0;i<count;i++) {
                 UITableViewCellModel *model=[[UITableViewCellModel alloc] initWithCellType:MAINCELL isAttached:NO andContentModel:trade.todayTaskOrders[i]];
                [self.dataArray addObject:model];
              NSIndexPath *path = [NSIndexPath indexPathForItem:(nowCount+i) inSection:0];
                [pathArray addObject:path];
            }
            [mainTableView beginUpdates];
            [mainTableView insertRowsAtIndexPaths:pathArray withRowAnimation:UITableViewRowAnimationNone];
            [mainTableView endUpdates];
            currentPageIndex++;
        }
            break;
        default:
            break;
    }
    [mainTableView stopRefresh];
}

-(void)didDataModelNoticeFail:(BaseDataModel *)baseDataModel forBusinessType:(BusinessType)businessID forErrorCode:(NSInteger)errorCode forErrorMsg:(NSString *)errorMsg
{
    [mainTableView stopRefresh];
    [super didDataModelNoticeFail:baseDataModel forBusinessType:businessID forErrorCode:errorCode forErrorMsg:errorMsg];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellModel *model=self.dataArray[indexPath.row];
    Order *order=model.contentModel;
    if ([model.cellType isEqualToString:MAINCELL])
    {
        
        static NSString *CellIdentifier = MAINCELL;
        
        TodayTaskTableViewTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        if (cell == nil) {
            cell = [[TodayTaskTableViewTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.optionButton.hidden=YES;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [cell createOptionButtonWithTitle:NSLocalizedStringFromTable(@"GoInstall",Res_String,@"") andIcon:nil andBackgroundColor:[UIColor lightGrayColor]];
        cell.textLabel.text=[NSString stringWithFormat:NSLocalizedStringFromTable(@"CellTitle",Res_String,@""),order.typeProductname,order.tradeAprices];
        if (model.isAttached) {
            cell.optionButton.hidden=NO;
            cell.accessoryType=UITableViewCellAccessoryNone;
        }else{
             cell.optionButton.hidden=YES;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
        
        
    }else if([model.cellType isEqualToString:ATTACHEDCELL]){
        
        static NSString *CellIdentifier = ATTACHEDCELL;
        
        TodayTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        if (cell == nil) {
            cell = [[TodayTaskTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.nameLable.text=order.tradeLinkman;
        cell.phoneLable.text=order.tradeMobile;
        cell.subscribeTimeLable.text=order.tradeAcreated;
        
        CGSize maximumLabelSize = CGSizeMake(cell.subscribeTimeLable.frame.size.width,MAXFLOAT);
        
        
        CGRect frame;
        if (order.tradeAddress!=nil) {
            CGSize expectedLabelSizeAddr = [order.tradeAddress sizeWithFont:cell.nameLable.font
                                           constrainedToSize:maximumLabelSize
                                               lineBreakMode:NSLineBreakByWordWrapping];
            
            frame=cell.addressLable.frame;
            frame.size=expectedLabelSizeAddr;
            cell.addressLable.frame=frame;
            cell.addressLable.numberOfLines=0;
            cell.addressLable.text=order.tradeAddress;
            
            frame=cell.sDetailLable.frame;
            frame.origin.y=cell.addressLable.frame.origin.y+expectedLabelSizeAddr.height+cell.nameLable.font.lineHeight/2;
            cell.sDetailLable.frame=frame;
        }
        
        if (order.tradeContent!=nil) {
            CGSize expectedLabelSizeDetail = [order.tradeContent sizeWithFont:cell.nameLable.font
                                             constrainedToSize:maximumLabelSize
                                                 lineBreakMode:NSLineBreakByWordWrapping];
            
            frame=cell.detailLable.frame;
            frame.origin.y=cell.sDetailLable.frame.origin.y;
            frame.size=expectedLabelSizeDetail;
            cell.detailLable.frame=frame;
            cell.detailLable.numberOfLines=0;
            cell.detailLable.text=order.tradeContent;
            
            frame=cell.sRemarkLable.frame;
            frame.origin.y=cell.detailLable.frame.origin.y+expectedLabelSizeDetail.height+cell.nameLable.font.lineHeight/2;
            cell.sRemarkLable.frame=frame;
            
            
        }
        
        if (order.tradeContent2!=nil) {
            
            CGSize expectedLabelSizeRemark = [order.tradeContent2 sizeWithFont:cell.nameLable.font
                                             constrainedToSize:maximumLabelSize
                                                 lineBreakMode:NSLineBreakByWordWrapping];
            
            frame=cell.remarkLable.frame;
            frame.origin.y=cell.sRemarkLable.frame.origin.y;
            frame.size=expectedLabelSizeRemark;
            cell.remarkLable.frame=frame;
            cell.remarkLable.numberOfLines=0;
            cell.remarkLable.text=order.tradeContent2;
        }
        
        frame=cell.frame;
        frame.size.height=cell.remarkLable.frame.origin.y+cell.remarkLable.frame.size.height+cell.nameLable.font.lineHeight/2;
        cell.frame=frame;
        return cell;
        
    }
    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSIndexPath *path = nil;
    
    UITableViewCellModel *cmodel= self.dataArray[indexPath.row];
    if ([cmodel.cellType isEqualToString:MAINCELL]) {
        path = [NSIndexPath indexPathForItem:(indexPath.row+1) inSection:indexPath.section];
    }else{
        path = indexPath;
    }
    
    NSIndexPath *pathlast = [NSIndexPath indexPathForItem:(path.row-1) inSection:indexPath.section];
    
    UITableViewCellModel *model= self.dataArray[(path.row-1)];
    if (cmodel.isAttached) {
        // 关闭附加cell
        model.cellType=MAINCELL;
        model.isAttached=NO;
        [self.dataArray removeObjectAtIndex:path.row];
        
        [tableView beginUpdates];
        [tableView reloadRowsAtIndexPaths:@[pathlast] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView deleteRowsAtIndexPaths:@[path]  withRowAnimation:UITableViewRowAnimationMiddle];
        [tableView endUpdates];
        
    }else{
        // 打开附加cell
        UITableViewCellModel *addModel=[[UITableViewCellModel alloc] initWithCellType:ATTACHEDCELL isAttached:YES andContentModel:model.contentModel];
        [self.dataArray insertObject:addModel atIndex:path.row];
        
        model= self.dataArray[(path.row-1)];
        
        model.cellType=MAINCELL;
        model.isAttached=YES;
        
        [tableView beginUpdates];
        [tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationBottom];
        [tableView reloadRowsAtIndexPaths:@[pathlast] withRowAnimation:UITableViewRowAnimationRight];
        [tableView endUpdates];
    }
    
}

-(void)PullRefreshTableViewBottomRefresh:(CustomPullRefreshTableView *)tableView
{
     [trade getTodayTaskOrdersById:user.userid withPageIndex:currentPageIndex forPagesize:PAGESIZE];
}
-(void)dealloc
{
    trade=nil;
    mainTableView=nil;
}
@end
