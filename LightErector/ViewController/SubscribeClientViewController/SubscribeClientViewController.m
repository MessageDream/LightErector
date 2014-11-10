//
//  SubscribeClientViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 10/11/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "SubscribeClientViewController.h"
#import "SubscribeClientView.h"
#import "Order.h"
#import "BMKGeoCodeSearch.h"

@interface SubscribeClientViewController ()<CustomTitleBar_ButtonDelegate,BMKGeoCodeSearchDelegate,BMKGeoCodeSearchDelegate,SubscribeClientViewDelegate>
{
    Order *order;
    SubscribeClientView *view;
    BMKMapView *_mapView;
    BMKGeoCodeSearch *_codeSearch;
}
@end

@implementation SubscribeClientViewController

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
    _viewControllerId=VIEWCONTROLLER_SUBCLIENT;
}

-(void)loadView
{
    view=[[SubscribeClientView alloc] initWithFrame:[self createViewFrame]];
    view.customTitleBar.buttonEventObserver=self;
    view.observer=self;
    _mapView=view.mapView;
    self.view=view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (order) {
        view.nameLable.text=order.tradeLinkman;
        view.phoneLable.text=order.tradeMobile;
        view.subscribeTimeLable.text=order.tradeAcreated;
        
        CGSize maximumLabelSize = CGSizeMake(view.subscribeTimeLable.frame.size.width,MAXFLOAT);
        
        
        CGRect frame;
        if (order.tradeAddress!=nil) {
            CGSize expectedLabelSizeAddr = [order.tradeAddress sizeWithFont:view.nameLable.font
                                                          constrainedToSize:maximumLabelSize
                                                              lineBreakMode:NSLineBreakByWordWrapping];
            
            frame=view.addressLable.frame;
            frame.size=expectedLabelSizeAddr;
            view.addressLable.frame=frame;
            view.addressLable.numberOfLines=0;
            view.addressLable.text=order.tradeAddress;
            
            frame=view.sDetailLable.frame;
            frame.origin.y=view.addressLable.frame.origin.y+expectedLabelSizeAddr.height+view.nameLable.font.lineHeight/2;
            view.sDetailLable.frame=frame;
        }
        
        if (order.tradeMasscontent!=nil) {
            CGSize expectedLabelSizeDetail = [order.tradeMasscontent sizeWithFont:view.nameLable.font
                                                            constrainedToSize:maximumLabelSize
                                                                lineBreakMode:NSLineBreakByWordWrapping];
            
            frame=view.detailLable.frame;
            frame.origin.y=view.sDetailLable.frame.origin.y;
            frame.size=expectedLabelSizeDetail;
            view.detailLable.frame=frame;
            view.detailLable.numberOfLines=0;
            view.detailLable.text=order.tradeMasscontent;
            
            frame=view.sRemarkLable.frame;
            frame.origin.y=view.detailLable.frame.origin.y+expectedLabelSizeDetail.height+view.nameLable.font.lineHeight/2;
            view.sRemarkLable.frame=frame;
            
            
        }
        
        if (order.tradeContent!=nil) {
            
            CGSize expectedLabelSizeRemark = [order.tradeContent sizeWithFont:view.nameLable.font
                                                             constrainedToSize:maximumLabelSize
                                                                 lineBreakMode:NSLineBreakByWordWrapping];
            
            frame=view.remarkLable.frame;
            frame.origin.y=view.sRemarkLable.frame.origin.y;
            frame.size=expectedLabelSizeRemark;
            view.remarkLable.frame=frame;
            view.remarkLable.numberOfLines=0;
            view.remarkLable.text=order.tradeContent;
        }
        
        frame=view.infoView.frame;
        frame.size.height=view.remarkLable.frame.origin.y+view.remarkLable.frame.size.height+view.nameLable.font.lineHeight/2;
        view.infoView.frame=frame;

    }
    
    _codeSearch=[[BMKGeoCodeSearch alloc] init];
    _codeSearch.delegate=self;
    _mapView.delegate=self;
    _mapView.showsUserLocation=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)leftButton_onClick:(id)sender
{
    Message *message = [[Message alloc] init];
    message.commandID = MC_CREATE_CLOSEPOPFROMTOP_VIEWCONTROLLER;
    message.receiveObjectID = VIEWCONTROLLER_RETURN;
    [self sendMessage:message];
}

-(void)receiveMessage:(Message *)message
{
    [super receiveMessage:message];
    order=message.externData;
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

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    //_locService.delegate = self;
    //     [self startLocation];
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
       _codeSearch.delegate=nil;
}


/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
    
}

/**
 *在将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser
{
    
}

/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser
{
    
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
#ifdef DEBUG_LOG
    NSLog(@"err:%@",error);
#endif
}

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
	if (error == 0) {
		BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
		item.coordinate = result.location;
		item.title = result.address;
		[_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
	}
}

-(void)call_btn_click:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",order.tradeMobile]]];
}

-(void)location_btn_click:(id)sender
{
    BMKGeoCodeSearchOption *opt=[[BMKGeoCodeSearchOption alloc] init];
    opt.address=order.tradeAddress;
    [_codeSearch geoCode:opt];
}

-(void)receptOrder_btn_click:(int)status withDate:(NSString *)date
{
     order.observer=self;
    if (status==1) {
        [order updateSubStatusWithMemberId:user.userid isSpeek:YES acreated:date];
    }else if(status==2){
     [order updateSubStatusWithMemberId:user.userid isSpeek:YES acreated:nil];
    }else{
     [order updateSubStatusWithMemberId:user.userid isSpeek:NO acreated:nil];
    }
    [self lockView];
}

-(void)didDataModelNoticeSucess:(BaseDataModel *)baseDataModel forBusinessType:(BusinessType)businessID
{
    [super didDataModelNoticeSucess:baseDataModel forBusinessType:businessID];
    [self showTip:@"接单成功"];
    Message *message = [[Message alloc] init];
    message.commandID = MC_CREATE_CLOSEPOPFROMTOP_VIEWCONTROLLER;
    message.receiveObjectID = VIEWCONTROLLER_RETURN;
    message.externData=@(YES);
    [self sendMessage:message];
}
@end
