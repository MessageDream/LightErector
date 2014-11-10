//
//  ReachTerminalViewController.m
//  LightErector
//
//  Created by Jayden on 14-10-4.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "ReachTerminalViewController.h"
#import "ReachTerminalView.h"
#import "Order.h"

@interface ReachTerminalViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,ReachTerminalViewDelegate>
{
    BMKLocationService* _locService;
    BMKMapView *_mapView;
    BOOL isFirstShow;
}
@end

@implementation ReachTerminalViewController

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
    rect.size.height=rect.size.height-64+20;
    ReachTerminalView *view=[[ReachTerminalView alloc] initWithFrame:rect];
    view.observer=self;
    _mapView=view.mapView;
    self.view=view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     _locService = [[BMKLocationService alloc]init];
//    _locService.delegate = self;
//    [_locService startUserLocationService];
//    _mapView.delegate=self;
//    _mapView.showsUserLocation=YES;
    //[self startFollowing];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    _locService.delegate = self;
     [_locService startUserLocationService];
     [self startLocation];
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}
//普通态
-(void)startLocation
{
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.zoomLevel=15;
    _mapView.showsUserLocation = YES;//显示定位图层
}
//罗盘态
-(void)startFollowHeading
{
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    _mapView.zoomLevel=15;
    _mapView.showsUserLocation = YES;
    
}
//跟随态
-(void)startFollowing
{
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.zoomLevel=15;
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
//    [_mapView updateLocationData:userLocation];
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
    if (!isFirstShow) {
         _mapView.centerCoordinate=userLocation.location.coordinate;
        isFirstShow=YES;
    }
   
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

-(void)reach_terminal_click:(id)sender
{
    if (self.order) {
        self.order.observer=self;
        [self.order updateOrderStatusWithMemberId:user.userid flowStatus:InitialStatus];
    }
}

-(void)didDataModelNoticeSucess:(BaseDataModel *)baseDataModel forBusinessType:(BusinessType)businessID
{
    [super didDataModelNoticeSucess:baseDataModel forBusinessType:businessID];
    switch (businessID) {
        case BUSINESS_UPDATEORDERSTATUS:
            if (self.observer&&[self.observer respondsToSelector:@selector(nextStep)]) {
                [self.observer nextStep];
            }
            break;
            
        default:
            break;
    }
}

-(void)dealloc
{
    _locService=nil;
    _mapView=nil;
}

@end
