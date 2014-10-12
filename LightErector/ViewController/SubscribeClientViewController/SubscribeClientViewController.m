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

@interface SubscribeClientViewController ()<CustomTitleBar_ButtonDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    Order *order;
    SubscribeClientView *view;
    BMKLocationService* _locService;
    BMKMapView *_mapView;
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
    CGRect frame=[self createViewFrame];
    frame.size.height=frame.size.height-DefaultTabBarHeight;
    view=[[SubscribeClientView alloc] initWithFrame:frame];
    view.customTitleBar.buttonEventObserver=self;
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
        
        if (order.tradeContent!=nil) {
            CGSize expectedLabelSizeDetail = [order.tradeContent sizeWithFont:view.nameLable.font
                                                            constrainedToSize:maximumLabelSize
                                                                lineBreakMode:NSLineBreakByWordWrapping];
            
            frame=view.detailLable.frame;
            frame.origin.y=view.sDetailLable.frame.origin.y;
            frame.size=expectedLabelSizeDetail;
            view.detailLable.frame=frame;
            view.detailLable.numberOfLines=0;
            view.detailLable.text=order.tradeContent;
            
            frame=view.sRemarkLable.frame;
            frame.origin.y=view.detailLable.frame.origin.y+expectedLabelSizeDetail.height+view.nameLable.font.lineHeight/2;
            view.sRemarkLable.frame=frame;
            
            
        }
        
        if (order.tradeContent2!=nil) {
            
            CGSize expectedLabelSizeRemark = [order.tradeContent2 sizeWithFont:view.nameLable.font
                                                             constrainedToSize:maximumLabelSize
                                                                 lineBreakMode:NSLineBreakByWordWrapping];
            
            frame=view.remarkLable.frame;
            frame.origin.y=view.sRemarkLable.frame.origin.y;
            frame.size=expectedLabelSizeRemark;
            view.remarkLable.frame=frame;
            view.remarkLable.numberOfLines=0;
            view.remarkLable.text=order.tradeContent2;
        }
        
        frame=view.infoView.frame;
        frame.size.height=view.remarkLable.frame.origin.y+view.remarkLable.frame.size.height+view.nameLable.font.lineHeight/2;
        view.infoView.frame=frame;

    }
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
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
    _locService.delegate = nil;
}
//普通态
-(void)startLocation
{
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}
//罗盘态
-(void)startFollowHeading
{
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    _mapView.showsUserLocation = YES;
    
}
//跟随态
-(void)startFollowing
{
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    
}
//停止定位
-(void)stopLocation
{
    [_locService stopUserLocationService];
    _mapView.showsUserLocation = NO;
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
    
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
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
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
#ifdef DEBUG_LOG
    NSLog(@"%f:%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
#endif
    [_mapView updateLocationData:userLocation];
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


@end
