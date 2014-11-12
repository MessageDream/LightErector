//
//  OrderCategoryViewController.m
//  LightErector
//
//  Created by Jayden on 14-10-2.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "OrderCategoryViewController.h"
#import "OrderCategoryView.h"
#import "OrderDetailTableViewCell.h"
#import "OrderTitleTableViewCell.h"
#import "TradeInfo.h"
#import "Order.h"
#import <MessageUI/MFMessageComposeViewController.h>
#import "InstallFlowModalController.h"

@interface OrderCategoryViewController ()<UITableViewDelegate,UITableViewDataSource,CustomPullRefreshTableViewDelegate,MFMessageComposeViewControllerDelegate,CustomUIDatePickerDelegate,UIAlertViewDelegate>
{
    __weak OrderCategoryView *orderCategoryView;
    
}
@property(nonatomic,assign)NSInteger setupRequestCount;
@property(nonatomic,assign)NSInteger currentUnAcceptPageIndex;
@property(nonatomic,assign)NSInteger currentUnSubPageIndex;
@property(nonatomic,assign)NSInteger currentUnInstallPageIndex;
@property(nonatomic,assign)NSInteger currentSubAgainPageIndex;
@property(nonatomic,assign)NSInteger currentUnFeedBackPageIndex;
@property(nonatomic,strong)TradeInfo *trade;
@property(nonatomic,strong)Order *currentOrder;
@property(nonatomic,strong)NSMutableArray *unAcceptDataArray;
@property(nonatomic,strong)NSMutableArray *unSubDataArray;
@property(nonatomic,strong)NSMutableArray *unInstallDataArray;
@property(nonatomic,strong)NSMutableArray *subAgainDataArray;
@property(nonatomic,strong)NSMutableArray *unFeedBackDataArray;
@end

@implementation OrderCategoryViewController

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
    _viewControllerId=VIEWCONTROLLER_ORDERCATEGORYLIST;
}

-(void)loadView
{
    CGRect frame=[self createViewFrame];
    frame.size.height=frame.size.height-DefaultTabBarHeight;
    
    OrderCategoryView* view=[[OrderCategoryView alloc] initWithFrame:frame];
    self.view=view;
    orderCategoryView=view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUnAccept) name:PUSHNOTIFICATIONID object:nil];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [orderCategoryView createTables];
    
    orderCategoryView.unAcceptTable.delegate=self;
    orderCategoryView.unSubTable.delegate=self;
    orderCategoryView.unInstallTable.delegate=self;
    orderCategoryView.subAgainTable.delegate=self;
    orderCategoryView.unFeedBackTable.delegate=self;
    
    orderCategoryView.unAcceptTable.dataSource=self;
    orderCategoryView.subAgainTable.dataSource=self;
    orderCategoryView.unSubTable.dataSource=self;
    orderCategoryView.unInstallTable.dataSource=self;
    orderCategoryView.unFeedBackTable.dataSource=self;
    
    orderCategoryView.unAcceptTable.pullRefreshDelegate=self;
    orderCategoryView.unSubTable.pullRefreshDelegate=self;
    orderCategoryView.unInstallTable.pullRefreshDelegate=self;
    orderCategoryView.subAgainTable.pullRefreshDelegate=self;
    orderCategoryView.unFeedBackTable.pullRefreshDelegate=self;
    
    orderCategoryView.dataPicker.observer=self;
    
    
    _currentUnAcceptPageIndex++;
    _currentUnSubPageIndex++;
    _currentUnInstallPageIndex++;
    _currentSubAgainPageIndex++;
    _currentUnFeedBackPageIndex++;
    
    self.unAcceptDataArray = [[NSMutableArray alloc]init];
    self.unSubDataArray=[[NSMutableArray alloc]init];
    self.unInstallDataArray=[[NSMutableArray alloc]init];
    self.subAgainDataArray=[[NSMutableArray alloc]init];
    self.unFeedBackDataArray=[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
    
    if (user.userLoginStatus==UserLoginStatus_Login) {
        [self afterLogin];
    }
}

-(void)afterLogin
{
    _trade=[TradeInfo shareTrade];
    _trade.observer=self;
    _setupRequestCount=1;
    [_trade getWaitForReceiveOrdersById:user.userid withPageIndex:_currentUnAcceptPageIndex forPagesize:PAGESIZE];
    [self lockView];
}

-(void)refreshUnAccept
{
    _currentUnAcceptPageIndex=1;
    [self.unAcceptDataArray removeAllObjects];
    [_trade getWaitForReceiveOrdersById:user.userid withPageIndex:_currentUnAcceptPageIndex forPagesize:PAGESIZE];
    [self lockView];
}

-(void)refresh
{
    _currentUnAcceptPageIndex =_currentUnSubPageIndex=_currentUnInstallPageIndex=_currentSubAgainPageIndex=_currentUnFeedBackPageIndex=1;
    [self.unAcceptDataArray removeAllObjects];
    [self.unInstallDataArray removeAllObjects];
    [self.unFeedBackDataArray removeAllObjects];
    [self.unSubDataArray removeAllObjects];
    [self.subAgainDataArray removeAllObjects];
    [self afterLogin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didDataModelNoticeSucess:(BaseDataModel *)baseDataModel forBusinessType:(BusinessType)businessID
{
    switch (businessID) {
        case BUSINESS_GETWAITFORRECEIVEORDER:{
            NSInteger count=_trade.waitForReceiveOrders.count;
            
            for (int i=0;i<count;i++) {
                UITableViewCellModel *model=[[UITableViewCellModel alloc] initWithCellType:MAINCELL isAttached:NO andContentModel:_trade.waitForReceiveOrders[i]];
                [self.unAcceptDataArray addObject:model];
            }
            if (count>0||self.unAcceptDataArray.count==0) {
                [orderCategoryView.unAcceptTable reloadData];
                if (count!=0) {
                    _currentUnAcceptPageIndex++;
                }
                
            }
            if (_setupRequestCount==1) {
                _setupRequestCount++;
                [_trade getWaitSubOrdersById:user.userid withPageIndex:_currentUnSubPageIndex forPagesize:PAGESIZE];
                [self lockViewAddCount];
            }else
                [orderCategoryView.unAcceptTable stopRefresh];
        }
            break;
        case BUSINESS_GETWAITSUBORDER:{
            NSInteger count=_trade.waitSubOrders.count;
            
            for (int i=0;i<count;i++) {
                UITableViewCellModel *model=[[UITableViewCellModel alloc] initWithCellType:MAINCELL isAttached:NO andContentModel:_trade.waitSubOrders[i]];
                [self.unSubDataArray addObject:model];;
            }
            if (count>0||self.unSubDataArray.count==0) {
                [orderCategoryView.unSubTable reloadData];
                if (count!=0) {
                    _currentUnSubPageIndex++;
                }
            }
            if (_setupRequestCount==2) {
                _setupRequestCount++;
                [_trade getWaitForInstallOrdersById:user.userid withPageIndex:_currentUnInstallPageIndex forPagesize:PAGESIZE];
                [self lockViewAddCount];
            }else
                [orderCategoryView.unSubTable stopRefresh];
        }
            break;
        case BUSINESS_GETWAITFORINSTALLORDER:{
            NSInteger count=_trade.waitForInstallOrders.count;
            
            for (int i=0;i<count;i++) {
                UITableViewCellModel *model=[[UITableViewCellModel alloc] initWithCellType:MAINCELL isAttached:NO andContentModel:_trade.waitForInstallOrders[i]];
                [self.unInstallDataArray addObject:model];
            }
            if (count>0||self.unInstallDataArray.count==0) {
                [orderCategoryView.unInstallTable reloadData];
                if (count!=0) {
                    _currentUnInstallPageIndex++;
                }
            }
            
            if (_setupRequestCount==3) {
                _setupRequestCount++;
                [_trade getUnTimedOrdersById:user.userid withPageIndex:_currentSubAgainPageIndex forPagesize:PAGESIZE];
                [self lockViewAddCount];
            }else
                [orderCategoryView.unInstallTable stopRefresh];
        }
            break;
        case BUSINESS_GETUNTIMEDORDER:{
            NSInteger count=_trade.unTimedOrders.count;
            
            for (int i=0;i<count;i++) {
                UITableViewCellModel *model=[[UITableViewCellModel alloc] initWithCellType:MAINCELL isAttached:NO andContentModel:_trade.unTimedOrders[i]];
                [self.subAgainDataArray addObject:model];
            }
            if (count>0||self.subAgainDataArray.count==0) {
                [orderCategoryView.subAgainTable reloadData];
                if (count!=0) {
                    _currentSubAgainPageIndex++;
                }
            }
            
            if (_setupRequestCount==4) {
                _setupRequestCount++;
                [_trade getWaitForFeedBackOrdersById:user.userid withPageIndex:_currentUnFeedBackPageIndex forPagesize:PAGESIZE];
                [self lockViewAddCount];
            }else
                [orderCategoryView.subAgainTable stopRefresh];
        }
            break;
        case BUSINESS_GETWAITFORFEEDBACKORDER:{
            NSInteger count=_trade.waitForFeedBackOrders.count;
            
            for (int i=0;i<count;i++) {
                UITableViewCellModel *model=[[UITableViewCellModel alloc] initWithCellType:MAINCELL isAttached:NO andContentModel:_trade.waitForFeedBackOrders[i]];
                [self.unFeedBackDataArray addObject:model];
            }
            if (count>0||self.unFeedBackDataArray.count==0) {
                [orderCategoryView.unFeedBackTable reloadData];
                if (count!=0) {
                    _currentUnFeedBackPageIndex++;
                }
            }
            if (_setupRequestCount==5) {
                _setupRequestCount++;
            }else
                [orderCategoryView.unFeedBackTable stopRefresh];
        }
            break;
        case BUSINESS_UPDATEORDERSTATUS:{
            [self showTip:@"接单成功"];
            Order *order=(Order *)baseDataModel;
            for (int i=0; i<self.unAcceptDataArray.count; i++) {
                UITableViewCellModel *model=self.unAcceptDataArray[i];
                if ([((Order *)model.contentModel).tradeId isEqualToString:order.tradeId]) {
                    model.cellType=MAINCELL;
                    model.isAttached=NO;
                    if (self.unSubDataArray.count>=PAGESIZE) {
                        [self.unSubDataArray removeLastObject];//移除最后一项，防止下拉加载重复显示
                    }
                    [self.unSubDataArray insertObject:model atIndex:0];
                    
                    
                    [self.unAcceptDataArray removeObjectAtIndex:i];
                    [self.unAcceptDataArray removeObjectAtIndex:i];
                    break;
                }
            }
            [orderCategoryView setCurrentIndex: orderCategoryView.segmentedControl.selectedSegmentIndex+1];
            [orderCategoryView.segmentedControl setSelectedSegmentIndex:orderCategoryView.segmentedControl.selectedSegmentIndex+1 animated:YES];
            [orderCategoryView.unSubTable reloadData];
            [orderCategoryView.unSubTable scrollsToTop];
            
            [orderCategoryView.unAcceptTable reloadData];
        }
            break;
        case BUSINESS_UPDATESUBTIME:
            orderCategoryView.editTimeView.hidden=YES;
            [self showTip:@"修改安装时间成功"];
            [orderCategoryView.unInstallTable reloadData];
            break;
        case BUSINESS_GETORDERSTATUS:{
            __weak OrderCategoryViewController *blockSelf=self;
            InstallFlowModalController *install=[[InstallFlowModalController alloc] initWithOrder:(Order *)baseDataModel andClosedBlock:^(InstallFlowModalController *controller) {
                if ([controller.extData isKindOfClass:[Message class]]) {
                    Message *msg=controller.extData;
                    if (msg.receiveObjectID==blockSelf.viewControllerId) {
                        blockSelf.currentUnFeedBackPageIndex=1;
                        [blockSelf.unFeedBackDataArray removeAllObjects];
                        [blockSelf.trade getWaitForFeedBackOrdersById:user.userid withPageIndex:blockSelf.currentUnFeedBackPageIndex forPagesize:PAGESIZE];
                        [((OrderCategoryView*)blockSelf.view).segmentedControl setSelectedSegmentIndex:4 animated:YES];
                    }else{
                        [blockSelf sendSwichTabBarMessageAtIndex:2];
                    }
                }else if ([controller.extData boolValue]){
                    [blockSelf refresh];
                }
                
            }];
            [self presentViewController:install animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
    [super didDataModelNoticeSucess:baseDataModel forBusinessType:businessID];
}

-(void)didDataModelNoticeFail:(BaseDataModel *)baseDataModel forBusinessType:(BusinessType)businessID forErrorCode:(NSInteger)errorCode forErrorMsg:(NSString *)errorMsg
{
    [orderCategoryView stopRefresh];
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
    switch (tableView.tag) {
        case UNACCEPTTABLETAG:
            return self.unAcceptDataArray.count;
        case UNSUBTABLETAG:
            return self.unSubDataArray.count;
        case UNINSTALLTABLETAG:
            return self.unInstallDataArray.count;
        case SUBAGAINTABLETAG:
            return self.subAgainDataArray.count;
        case UNFEEDBACKTABLETAG:
            return self.unFeedBackDataArray.count;
        default:
            return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellModel *model;
    switch (tableView.tag) {
        case UNACCEPTTABLETAG:
            model= self.unAcceptDataArray[indexPath.row];
            break;
        case UNSUBTABLETAG:
            model=  self.unSubDataArray[indexPath.row];
            break;
        case UNINSTALLTABLETAG:
            model=  self.unInstallDataArray[indexPath.row];
            break;
        case SUBAGAINTABLETAG:
            model=  self.subAgainDataArray[indexPath.row];
            break;
        case UNFEEDBACKTABLETAG:
            model=  self.unFeedBackDataArray[indexPath.row];
            break;
        default:
            break;
    }
    if (!model) {
        return nil;
    }
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
        NSArray *btnTitles=nil;
        NSArray *colors=nil;
        switch (tableView.tag) {
            case UNACCEPTTABLETAG:
                btnTitles=@[@"立即接单"];
                colors=@[[MainStyle mainLightTwoColor]];
                break;
            case UNSUBTABLETAG:
                btnTitles=@[@"转发",@"预约"];
                colors=@[[MainStyle mainDarkColor],[MainStyle mainLightTwoColor]];
                break;
            case UNINSTALLTABLETAG:
                btnTitles=@[@"修改时间"];
                colors=@[[MainStyle mainLightTwoColor]];
                break;
            case SUBAGAINTABLETAG:
                btnTitles=@[@"再次预约"];
                colors=@[[MainStyle mainLightTwoColor]];
                break;
            case UNFEEDBACKTABLETAG:
                btnTitles=@[@"立即反馈"];
                colors=@[[MainStyle mainLightTwoColor]];
                break;
            default:
                break;
        }
        __weak OrderCategoryViewController *blockSelf=self;
        __weak UITableView *blockTableView=tableView;
        __weak Order *blockOrder=order;
        [cell createOptionButtonsWithTitles:btnTitles andIcons:nil andBackgroundColors:colors andAction:^(NSInteger buttonIndex) {
            
            switch (blockTableView.tag) {
                case UNACCEPTTABLETAG:{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"确定立即接单吗？"
                                                                   delegate:blockSelf
                                                          cancelButtonTitle:@"取消"
                                                          otherButtonTitles:@"确定",nil];
                    alert.tag=blockTableView.tag;
                    blockSelf.currentOrder=blockOrder;
                    [alert show];
                }
                    break;
                case UNSUBTABLETAG:
                    if (buttonIndex==0) {
                        [blockSelf sendSMS:order.tradeMasscontent recipientList:nil];
                    }else{
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                        message:@"确定立即预约吗？"
                                                                       delegate:blockSelf
                                                              cancelButtonTitle:@"取消"
                                                              otherButtonTitles:@"确定",nil];
                        alert.tag=blockTableView.tag;
                        blockSelf.currentOrder=blockOrder;
                        [alert show];
                    }
                    break;
                case UNINSTALLTABLETAG:{
                    if (blockOrder.tradeAcreated) {
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSDate *date = [dateFormatter dateFromString:blockOrder.tradeAcreated];
                        ((OrderCategoryView *)blockSelf.view).dataPicker.date=date;
                    }
                    ((OrderCategoryView *)blockSelf.view).editTimeView.hidden=NO;
                    blockSelf.currentOrder=blockOrder;
                }
                    break;
                case SUBAGAINTABLETAG:{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"确定立即预约吗？"
                                                                   delegate:blockSelf
                                                          cancelButtonTitle:@"取消"
                                                          otherButtonTitles:@"确定",nil];
                    alert.tag=blockTableView.tag;
                    blockSelf.currentOrder=blockOrder;
                    [alert show];
                }
                    break;
                case UNFEEDBACKTABLETAG:{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"确定立即反馈吗？"
                                                                   delegate:blockSelf
                                                          cancelButtonTitle:@"取消"
                                                          otherButtonTitles:@"确定",nil];
                    alert.tag=blockTableView.tag;
                    blockSelf.currentOrder=blockOrder;
                    [alert show];
                }
                    break;
                default:
                    break;
            }
        }];
        cell.textLabel.text=order.typeProductname;
        if (order.tradeAprices!=nil) {
            cell.priceLable.text=[order.tradeAprices stringByAppendingString:@" 元"];
        }
        cell.nameLable.text=order.tradeLinkman;
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
   __weak NSMutableArray *array;
    switch (tableView.tag) {
        case UNACCEPTTABLETAG:
            array= self.unAcceptDataArray;
            break;
        case UNSUBTABLETAG:
            array=  self.unSubDataArray;
            break;
        case UNINSTALLTABLETAG:
            array=  self.unInstallDataArray;
            break;
        case SUBAGAINTABLETAG:
            array=  self.subAgainDataArray;
            break;
        case UNFEEDBACKTABLETAG:
            array=  self.unFeedBackDataArray;
            break;
        default:
            break;
    }
    if (!array) {
        return;
    }
    
    NSIndexPath *path = nil;
    
    UITableViewCellModel *cmodel= array[indexPath.row];
    if ([cmodel.cellType isEqualToString:MAINCELL]) {
        path = [NSIndexPath indexPathForItem:(indexPath.row+1) inSection:indexPath.section];
    }else{
        path = indexPath;
    }
    
    NSIndexPath *pathlast = [NSIndexPath indexPathForItem:(path.row-1) inSection:indexPath.section];
    
    UITableViewCellModel *model= array[(path.row-1)];
    if (cmodel.isAttached) {
        // 关闭附加cell
        model.cellType=MAINCELL;
        model.isAttached=NO;
        [array removeObjectAtIndex:path.row];
        
        [tableView beginUpdates];
        [tableView reloadRowsAtIndexPaths:@[pathlast] withRowAnimation:UITableViewRowAnimationRight];
        [tableView deleteRowsAtIndexPaths:@[path]  withRowAnimation:UITableViewRowAnimationMiddle];
        [tableView endUpdates];
        
    }else{
        // 打开附加cell
        UITableViewCellModel *addModel=[[UITableViewCellModel alloc] initWithCellType:ATTACHEDCELL isAttached:YES andContentModel:model.contentModel];
        [array insertObject:addModel atIndex:path.row];
        
        model= array[(path.row-1)];
        
        model.cellType=MAINCELL;
        model.isAttached=YES;
        
        [tableView beginUpdates];
        [tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationBottom];
        [tableView reloadRowsAtIndexPaths:@[pathlast] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView endUpdates];
    }
    
}

-(void)PullRefreshTableViewBottomRefresh:(CustomPullRefreshTableView *)tableView;
{
    switch (tableView.tag) {
        case UNACCEPTTABLETAG:
            [_trade getWaitForReceiveOrdersById:user.userid withPageIndex:_currentUnAcceptPageIndex forPagesize:PAGESIZE];
            break;
        case UNSUBTABLETAG:
            [_trade getWaitSubOrdersById:user.userid withPageIndex:_currentUnSubPageIndex forPagesize:PAGESIZE];
            break;
        case UNINSTALLTABLETAG:
            [_trade getWaitForInstallOrdersById:user.userid withPageIndex:_currentUnInstallPageIndex forPagesize:PAGESIZE];
            break;
        case SUBAGAINTABLETAG:
            [_trade getUnTimedOrdersById:user.userid withPageIndex:_currentSubAgainPageIndex forPagesize:PAGESIZE];
            break;
        case UNFEEDBACKTABLETAG:
            [_trade getWaitForFeedBackOrdersById:user.userid withPageIndex:_currentUnFeedBackPageIndex forPagesize:PAGESIZE];
            break;
    }
}


- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    
    if([MFMessageComposeViewController canSendText])
        
    {
        controller.body = bodyOfMessage;
        
        controller.recipients = recipients;
        
        controller.messageComposeDelegate = self;
        
        [self presentModalViewController:controller animated:YES];
        
    }else{
        
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (result == MessageComposeResultCancelled){
        [self showTip:@"已取消短信转发。"];
    }else if (result == MessageComposeResultSent){
        [self showTip:@"转发短信已发送。"];
    }else{
        [self showTip:@"转发短信发送失败。"];
    }
}

#pragma mark - CustomDataPicker
-(IBAction)cancelButton_onClick:(id)sender
{
    orderCategoryView.editTimeView.hidden=YES;
}

-(IBAction)confirmButton_onClick:(id)sender forDate:(NSDate*)date
{
    if ([orderCategoryView.textReson.text length]==0) {
        [self showTip:@"修改原因不能为空"];
        return;
    }
    self.currentOrder.observer=self;
    [self.currentOrder updateSubTime:date withReason:orderCategoryView.textReson.text withMemberId:user.userid];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    Order *order=self.currentOrder;
    order.observer=self;
    if (buttonIndex==1) {
        
        switch (alertView.tag) {
            case UNACCEPTTABLETAG:
                [order updateOrderStatusWithMemberId:user.userid flowStatus:ReceivedStatus];
                [self lockView];
                break;
            case UNSUBTABLETAG:
            case SUBAGAINTABLETAG:{
                Message *message = [[Message alloc] init];
                message.commandID = MC_CREATE_POPFROMBOTTOM_VIEWCONTROLLER;
                message.cacheMode=DO_CACHE_WITH_RECEIVEMESSAGE;
                message.externData=self.currentOrder;
                message.receiveObjectID = VIEWCONTROLLER_SUBCLIENT;
                [self sendMessage:message];
            }
                break;
            case UNINSTALLTABLETAG:
                
                break;
            case UNFEEDBACKTABLETAG:
                [order getOrderInstallStatus];
                [self lockView];
                break;
        }
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PUSHNOTIFICATIONID object:nil];
}
-(void)receiveMessage:(Message *)message
{
    [super receiveMessage:message];
    if (message.sendObjectID==VIEWCONTROLLER_SUBCLIENT&&message.externData&&[message.externData boolValue]) {
        [self refresh];
    }
}

-(void)dealloc
{
    _trade=nil;
    orderCategoryView=nil;
    self.currentOrder=nil;
}
@end
