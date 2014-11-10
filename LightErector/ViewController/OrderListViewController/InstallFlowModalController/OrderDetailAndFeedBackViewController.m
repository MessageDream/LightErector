//
//  OrderDetailAndFeedBackViewController.m
//  LightErector
//
//  Created by Jayden on 14-10-5.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "OrderDetailAndFeedBackViewController.h"
#import "OrderDetailAndFeedBackView.h"
#import "Order.h"
#import "MZFormSheetController.h"
#import "ImageUtils.h"
#import "BaseCustomMessageBox.h"
#define VIEWHEIGHT 260
#define VIEWWIDTH 260
#define VIEWSPACE 20

@interface OrderDetailAndFeedBackViewController ()<OrderDetailAndFeedBackViewDelegate>
{
    OrderDetailAndFeedBackView *selfView;
}
@end

@implementation OrderDetailAndFeedBackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView
{
    CGRect rect=[self createViewFrame];
    OrderDetailAndFeedBackView *view=[[OrderDetailAndFeedBackView alloc] initWithFrame:CGRectMake((rect.size.width-VIEWWIDTH)/2, (rect.size.height-VIEWHEIGHT)/2, VIEWWIDTH, VIEWHEIGHT)];
    view.observer=self;
    self.view=selfView=view;
    if (_isDetail) {
        [self showDetail];
    }else{
        [self showFeed];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showDetail
{
    selfView.titleLable.text=@"订单详情";
    OrderInfoView *cell=selfView.infoView;
    cell.hidden=NO;
    selfView.feedBackView.hidden=YES;
    
    cell.nameLable.text=_order.tradeLinkman;
    cell.phoneLable.text=_order.tradeMobile;
    cell.subscribeTimeLable.text=_order.tradeAcreated;
    
    CGSize maximumLabelSize = CGSizeMake(cell.subscribeTimeLable.frame.size.width,MAXFLOAT);
    
    
    CGRect frame;
    if (_order.tradeAddress!=nil) {
        CGSize expectedLabelSizeAddr = [_order.tradeAddress sizeWithFont:cell.nameLable.font
                                                      constrainedToSize:maximumLabelSize
                                                          lineBreakMode:NSLineBreakByWordWrapping];
        
        frame=cell.addressLable.frame;
        frame.size=expectedLabelSizeAddr;
        cell.addressLable.frame=frame;
        cell.addressLable.numberOfLines=0;
        cell.addressLable.text=_order.tradeAddress;
        
        frame=cell.sDetailLable.frame;
        frame.origin.y=cell.addressLable.frame.origin.y+expectedLabelSizeAddr.height+cell.nameLable.font.lineHeight/2;
        cell.sDetailLable.frame=frame;
    }
    
    if (_order.tradeMasscontent!=nil) {
        CGSize expectedLabelSizeDetail = [_order.tradeMasscontent sizeWithFont:cell.nameLable.font
                                                        constrainedToSize:maximumLabelSize
                                                            lineBreakMode:NSLineBreakByWordWrapping];
        
        frame=cell.detailLable.frame;
        frame.origin.y=cell.sDetailLable.frame.origin.y;
        frame.size=expectedLabelSizeDetail;
        cell.detailLable.frame=frame;
        cell.detailLable.numberOfLines=0;
        cell.detailLable.text=_order.tradeMasscontent;
        
        frame=cell.sRemarkLable.frame;
        frame.origin.y=cell.detailLable.frame.origin.y+expectedLabelSizeDetail.height+cell.nameLable.font.lineHeight/2;
        cell.sRemarkLable.frame=frame;
    }
    
    if (_order.tradeContent!=nil) {
        
        CGSize expectedLabelSizeRemark = [_order.tradeContent sizeWithFont:cell.nameLable.font
                                                         constrainedToSize:maximumLabelSize
                                                             lineBreakMode:NSLineBreakByWordWrapping];
        
        frame=cell.remarkLable.frame;
        frame.origin.y=cell.sRemarkLable.frame.origin.y;
        frame.size=expectedLabelSizeRemark;
        cell.remarkLable.frame=frame;
        cell.remarkLable.numberOfLines=0;
        cell.remarkLable.text=_order.tradeContent;
    }
    
    frame=cell.frame;
    frame.size.height=cell.remarkLable.frame.origin.y+cell.remarkLable.frame.size.height+cell.nameLable.font.lineHeight/2;
    cell.frame=frame;
    
    selfView.frame=CGRectMake(selfView.frame.origin.x, selfView.frame.origin.y, selfView.frame.size.width, selfView.frame.size.height+(cell.frame.size.height-selfView.feedBackView.frame.size.height));
}
-(void)setOrder:(Order *)order
{
     _order=order;
}

-(void)showFeed
{
    selfView.infoView.hidden=YES;
    selfView.feedBackView.hidden=NO;
    selfView.titleLable.text=@"失败反馈";
    CGFloat heightspace=selfView.infoView.frame.size.height-selfView.feedBackView.frame.size.height;
    selfView.frame=CGRectMake(selfView.frame.origin.x, selfView.frame.origin.y, selfView.frame.size.width, selfView.frame.size.height-(heightspace<0?0:heightspace));
}

#pragma mark - OrderDetailAndFeedBackViewDelegate
-(void)feedBackButton_Clicked:(NSString *)feed
{
    if (self.order) {
        self.order.observer=self;
        [self.order installErrorFeedback:feed];
    }
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

-(void)didDataModelNoticeSucess:(BaseDataModel *)baseDataModel forBusinessType:(BusinessType)businessID
{
    [super didDataModelNoticeSucess:baseDataModel forBusinessType:businessID];
     [self dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {
         UIImage *image=[ImageUtils createImageWithColor:[[MainStyle mainLightColor] colorWithAlphaComponent:0.8f] andSize:CGSizeMake(200.0f, 50.0f)];
         BaseCustomMessageBox *baseCustomMessageBox = [[BaseCustomMessageBox alloc] initWithText:@"反馈提交成功" forBackgroundImage:image];
         baseCustomMessageBox.animation = YES;
         baseCustomMessageBox.autoCloseTimer = 2;
         [formSheetController.fromViewController.view addSubview:baseCustomMessageBox];
     }];
}
-(void)didDataModelNoticeFail:(BaseDataModel *)baseDataModel forBusinessType:(BusinessType)businessID forErrorCode:(NSInteger)errorCode forErrorMsg:(NSString *)errorMsg
{
    [self dismissFormSheetControllerAnimated:YES completionHandler:nil];
    [super didDataModelNoticeFail:baseDataModel forBusinessType:businessID forErrorCode:errorCode forErrorMsg:errorMsg];
}

-(void)dealloc
{
    selfView=nil;
}
@end
