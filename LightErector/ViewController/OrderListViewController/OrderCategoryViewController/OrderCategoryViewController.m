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

@interface OrderCategoryViewController ()<UITableViewDelegate,UITableViewDataSource,CustomPullRefreshTableViewDelegate>
{
    OrderCategoryView *orderCategoryView;
    TradeInfo *trade;
    NSInteger currentUnAcceptPageIndex;
    NSInteger currentUnSubPageIndex;
    NSInteger currentUnInstallPageIndex;
    NSInteger currentSubAgainPageIndex;
    NSInteger currentUnFeedBackPageIndex;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
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
    orderCategoryView=[[OrderCategoryView alloc] initWithFrame:frame];
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
    orderCategoryView.subAgainTable.pullRefreshDelegate=self;
    orderCategoryView.unSubTable.pullRefreshDelegate=self;
    orderCategoryView.unInstallTable.pullRefreshDelegate=self;
    orderCategoryView.unFeedBackTable.pullRefreshDelegate=self;
    
    self.view=orderCategoryView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    trade=[TradeInfo shareTrade];
    trade.observer=self;
    // Do any additional setup after loading the view.
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
        case BUSINESS_GETWAITFORRECEIVEORDER:{
            NSMutableArray *pathArray=[[NSMutableArray alloc] init];
            NSInteger count=trade.todayTaskOrders.count;
            NSInteger nowCount=self.dataArray.count;
            
            for (int i=0;i<count;i++) {
                UITableViewCellModel *model=[[UITableViewCellModel alloc] initWithCellType:MAINCELL isAttached:NO andContentModel:trade.todayTaskOrders[i]];
                [self.dataArray addObject:model];
                NSIndexPath *path = [NSIndexPath indexPathForItem:(nowCount+i) inSection:0];
                [pathArray addObject:path];
            }
            [orderCategoryView.unAcceptTable beginUpdates];
            [orderCategoryView.unAcceptTable insertRowsAtIndexPaths:pathArray withRowAnimation:UITableViewRowAnimationNone];
            [orderCategoryView.unAcceptTable endUpdates];
            currentUnAcceptPageIndex++;
        }
            break;
        default:
            break;
    }
    [orderCategoryView.unAcceptTable stopRefresh];
}

-(void)didDataModelNoticeFail:(BaseDataModel *)baseDataModel forBusinessType:(BusinessType)businessID forErrorCode:(NSInteger)errorCode forErrorMsg:(NSString *)errorMsg
{
    [orderCategoryView.unAcceptTable stopRefresh];
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
        OrderTitleTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[OrderTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [cell createOptionButtonsWithTitles:@[NSLocalizedStringFromTable(@"GoInstall",Res_String,@"")] andIcons:nil andBackgroundColors:@[[UIColor orangeColor]] andAction:^(NSInteger buttonIndex) {
            if (buttonIndex==0) {
                NSLog(@"clicked...");
            }
        }];
        cell.textLabel.text=order.typeProductname;
        
        if (order.tradeAprices!=nil) {
            cell.priceLable.text=[order.tradeAprices stringByAppendingString:@" 元"];
        }
        
        if (model.isAttached) {
            [cell showButtons];
            cell.accessoryType=UITableViewCellAccessoryNone;
        }else{
            [cell hideButtons];
            cell.nameLable.text=order.tradeLinkman;
            cell.mobileLable.text=order.tradeMobile;
            cell.priceLable.text=order.tradeAprices;
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
    switch (tableView.tag) {
        case UNACCEPTTABLETAG:
            [trade getWaitForReceiveOrdersById:user.userid withPageIndex:currentUnAcceptPageIndex forPagesize:PAGESIZE];
            break;
        case UNSUBTABLETAG:
            [trade getWaitSubOrdersById:user.userid withPageIndex:currentSubAgainPageIndex forPagesize:PAGESIZE];
            break;
        case UNINSTALLTABLETAG:
            [trade getWaitForInstallOrdersById:user.userid withPageIndex:currentUnInstallPageIndex forPagesize:PAGESIZE];
            break;
        case SUBAGAINTABLETAG:
            [trade getUnTimedOrdersById:user.userid withPageIndex:currentUnSubPageIndex forPagesize:PAGESIZE];
            break;
        case UNFEEDBACKTABLETAG:
            [trade getWaitForFeedBackOrdersById:user.userid withPageIndex:currentUnFeedBackPageIndex forPagesize:PAGESIZE];
            break;
    }
}

-(void)dealloc
{
    trade=nil;
    orderCategoryView=nil;
}
@end
