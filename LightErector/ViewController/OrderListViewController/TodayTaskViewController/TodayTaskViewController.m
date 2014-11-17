//
//  TodayTaskViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 9/26/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "TodayTaskViewController.h"
#import "TodayTaskView.h"
#import "OrderDetailTableViewCell.h"
#import "OrderTitleTableViewCell.h"
#import "TradeInfo.h"
#import "Order.h"
#import "InstallFlowModalController.h"

@interface TodayTaskViewController () <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,CustomPullRefreshTableViewDelegate>
{
     __weak CustomPullRefreshTableView *mainTableView;
}
@property(nonatomic,strong)TradeInfo *trade;
@property(nonatomic,assign)NSInteger currentPageIndex;
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
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    _currentPageIndex++;
    if (user.userLoginStatus==UserLoginStatus_Login) {
        [self afterLogin];
    }
    self.dataArray = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)afterLogin
{
    _trade=[TradeInfo shareTrade];
    _trade.observer=self;
    [_trade getTodayTaskOrdersById:user.userid withPageIndex:_currentPageIndex forPagesize:PAGESIZE];
    [self lockView];
}

-(void)didDataModelNoticeSucess:(BaseDataModel *)baseDataModel forBusinessType:(BusinessType)businessID
{
    [super didDataModelNoticeSucess:baseDataModel forBusinessType:businessID];
    switch (businessID) {
        case BUSINESS_GETTODAYTASKORDER:{
            NSInteger count=_trade.todayTaskOrders.count;
            
            for (int i=0;i<count;i++) {
                UITableViewCellModel *model=[[UITableViewCellModel alloc] initWithCellType:MAINCELL isAttached:NO andContentModel:_trade.todayTaskOrders[i]];
                [self.dataArray addObject:model];
            }
            
            if (count>0||self.dataArray.count==0) {
                [mainTableView reloadData];
                if (count!=0) {
                    _currentPageIndex++;
                }
            }else if(_currentPageIndex==1){
                [self showTip:@"今天暂无安装任务。"];
            }
        }
            break;
        case BUSINESS_GETORDERSTATUS:
        {
            __weak TodayTaskViewController *blockSelf=self;
            InstallFlowModalController *install=[[InstallFlowModalController alloc] initWithOrder:(Order *)baseDataModel andClosedBlock:^(InstallFlowModalController *controller) {
                if ([controller.extData isKindOfClass:[Message class]]) {
                  [blockSelf sendSwichTabBarMessageAtIndex:2];
                }else if ([controller.extData boolValue]){
                    blockSelf.currentPageIndex=1;
                    [blockSelf.dataArray removeAllObjects];
                    [blockSelf afterLogin];
                }
            }];
            [self presentViewController:install animated:YES completion:nil];
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
        OrderTitleTableViewCell *cell;//= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[OrderTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        __weak TodayTaskViewController *blockSelf=self;
        [cell createOptionButtonsWithTitles:@[NSLocalizedStringFromTable(@"GoInstall",Res_String,@"")] andIcons:nil andBackgroundColors:@[[MainStyle mainLightTwoColor]] andAction:^(NSInteger buttonIndex) {
            if (buttonIndex==0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"确定去安装吗？"
                                                               delegate:blockSelf
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"确定",nil];
                alert.tag=indexPath.row;
                [alert show];
            }
        }];
        cell.textLabel.text=order.typeProductname;
        if (order.tradeAprices!=nil) {
            cell.priceLable.text=[order.tradeAprices stringByAppendingString:@" 元"];
        }
        cell.nameLable.text=order.tradeLinkman;
        if (order.tradeAcreated&&[order.tradeAcreated length]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *date = [dateFormatter dateFromString:order.tradeAcreated];
            [dateFormatter setDateFormat:@"MM-dd HH:mm"];
            NSString *dstr=[dateFormatter stringFromDate:date];
            cell.dateLable.text=dstr;
        }
        cell.mobileLable.text=order.tradeMobile;
        if (model.isAttached) {
            [cell showButtons];
            cell.accessoryType=UITableViewCellAccessoryNone;
        }else{
            [cell hideButtons];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
        
        
    }else if([model.cellType isEqualToString:ATTACHEDCELL]){
        
        static NSString *CellIdentifier = ATTACHEDCELL;
        
        OrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        if (cell == nil) {
            cell = [[OrderDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
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
        
        if (order.tradeMasscontent!=nil) {
            CGSize expectedLabelSizeDetail = [order.tradeMasscontent sizeWithFont:cell.nameLable.font
                                                                constrainedToSize:maximumLabelSize
                                                                    lineBreakMode:NSLineBreakByWordWrapping];
            
            frame=cell.detailLable.frame;
            frame.origin.y=cell.sDetailLable.frame.origin.y;
            frame.size=expectedLabelSizeDetail;
            cell.detailLable.frame=frame;
            cell.detailLable.numberOfLines=0;
            cell.detailLable.text=order.tradeMasscontent;
            
            frame=cell.sRemarkLable.frame;
            frame.origin.y=cell.detailLable.frame.origin.y+expectedLabelSizeDetail.height+cell.nameLable.font.lineHeight/2;
            cell.sRemarkLable.frame=frame;
            
            
        }
        
        if (order.tradeContent!=nil) {
            
            CGSize expectedLabelSizeRemark = [order.tradeContent sizeWithFont:cell.nameLable.font
                                                            constrainedToSize:maximumLabelSize
                                                                lineBreakMode:NSLineBreakByWordWrapping];
            
            frame=cell.remarkLable.frame;
            frame.origin.y=cell.sRemarkLable.frame.origin.y;
            frame.size=expectedLabelSizeRemark;
            cell.remarkLable.frame=frame;
            cell.remarkLable.numberOfLines=0;
            cell.remarkLable.text=order.tradeContent;
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
        [tableView reloadRowsAtIndexPaths:@[pathlast] withRowAnimation:UITableViewRowAnimationRight];
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
        [tableView reloadRowsAtIndexPaths:@[pathlast] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView endUpdates];
    }
    
}

-(void)PullRefreshTableViewBottomRefresh:(CustomPullRefreshTableView *)tableView
{
    [_trade getTodayTaskOrdersById:user.userid withPageIndex:_currentPageIndex forPagesize:PAGESIZE];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        UITableViewCellModel *model=self.dataArray[alertView.tag];
        Order *order=model.contentModel;
        order.observer=self;
        [order getOrderInstallStatus];
        [self lockView];
    }
}
-(void)dealloc
{
    _trade=nil;
    mainTableView=nil;
}
@end
