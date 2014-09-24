//
//  RootViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "RootViewController.h"
#import "RootView.h"

#define DefaultTabBarHeight  50
#define PushAnimationDuration  0.35
@interface RootViewController ()
{
    BOOL visible;
}
- (void)loadTabs;
@end

@implementation RootViewController
{
    CustomTabBar *tabBar;
    
    RootView *tabBarView;
    
    NSUInteger tabBarHeight;
    
    BOOL tabBarStatus;
}

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (!self) return nil;
    
    tabBarHeight = DefaultTabBarHeight;
    
    return self;
}

- (id)initWithTabBarHeight:(NSUInteger)height
{
    self = [super init];
    if (!self) return nil;
    
    tabBarHeight = height;
    
    return self;
}

- (id)initWithControllerIDs:(NSArray*)ids
{
    if (self=[self init]) {
        _viewControllerIDs=ids;
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];

    tabBarView = [[RootView alloc] initWithFrame:[self createViewFrame]];
    self.view = tabBarView;
    
    CGRect tabBarRect = CGRectMake(0.0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.frame), tabBarHeight);
    tabBar = [[CustomTabBar alloc] initWithFrame:tabBarRect];
    tabBar.delegate = self;
    
    tabBarView.tabBar = tabBar;
    tabBar.hidden=YES;
    [self loadTabs];
}

-(void)viewDidLoad
{
//    Message *message = [[Message alloc] init];
//    message.receiveObjectID = VIEWCONTROLLER_MAIN;//VIEWCONTROLLER_TEST2,VIEWCONTROLLER_LOGIN
//    message.commandID = MC_CREATE_NORML_VIEWCONTROLLER;
//    [self sendMessage:message];
}

- (void)loadTabs
{
    NSMutableArray *tabs = [[NSMutableArray alloc] init];
    for (NSNumber * cid in  _viewControllerIDs)
    {
        [[tabBarView tabBar] setBackgroundImageName:@"title_bar"];
        [[tabBarView tabBar] setTabColors:[self tabCGColors]];
        [[tabBarView tabBar] setEdgeColor:[self tabEdgeColor]];
         CustomTabBarItem *tab = [[CustomTabBarItem alloc] init];
        [tab setBackgroundImageName:[self backgroundImageName]];
        [tab setSelectedBackgroundImageName:[self selectedBackgroundImageName]];
        [tab setTabIconColors:[self iconCGColors]];
        [tab setTabIconColorsSelected:[self selectedIconCGColors]];
        [tab setTabSelectedColors:[self selectedTabCGColors]];
        [tab setEdgeColor:[self tabEdgeColor]];
        [tab setGlossyIsHidden:[self iconGlossyIsHidden]];
        [tab setStrokeColor:[self tabStrokeColor]];
        [tab setTextColor:[self textColor]];
        [tab setSelectedTextColor:[self selectedTextColor]];
      
        
        [tab setTabBarHeight:tabBarHeight];
        
        switch ([cid intValue]) {
            case VIEWCONTROLLER_MAIN:
                [tab setTabImageWithName:@"title_bar_home"];
                [tab setTabTitle:@"主页"];
                break;
                
            default:
                [tab setTabImageWithName:@""];
                [tab setTabTitle:@"test"];
                break;
        }
        
        if (_minimumHeightToDisplayTitle)
            [tab setMinimumHeightToDisplayTitle:_minimumHeightToDisplayTitle];
        
        if (_tabTitleIsHidden)
            [tab setTitleIsHidden:YES];
        
        [tabs addObject:tab];
    }
    
    [tabBar setTabs:tabs];
    
    // Setting the first view controller as the active one
    [tabBar setSelectedTab:[tabBar.tabs objectAtIndex:0]];
}

- (NSArray *) selectedIconCGColors
{
    return _selectedIconColors ? @[(id)[[_selectedIconColors objectAtIndex:0] CGColor], (id)[[_selectedIconColors objectAtIndex:1] CGColor]] : nil;
}

- (NSArray *) iconCGColors
{
    return _iconColors ? @[(id)[[_iconColors objectAtIndex:0] CGColor], (id)[[_iconColors objectAtIndex:1] CGColor]] : nil;
}

- (NSArray *) tabCGColors
{
    return _tabColors ? @[(id)[[_tabColors objectAtIndex:0] CGColor], (id)[[_tabColors objectAtIndex:1] CGColor]] : nil;
}

- (NSArray *) selectedTabCGColors
{
    return _selectedTabColors ? @[(id)[[_selectedTabColors objectAtIndex:0] CGColor], (id)[[_selectedTabColors objectAtIndex:1] CGColor]] : nil;
}


- (void)showTabBarWithAnimated:(BOOL)animated
{
    if (!tabBarStatus) {
        if (animated) {
            [UIView beginAnimations:@"Animation" context:nil];
            [UIView setAnimationDuration:PushAnimationDuration];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDelegate:self];
            
            tabBar.hidden=NO;
//            CGRect frame = tabBar.frame ;
//            frame.origin.y=CGRectGetHeight(self.view.bounds) - tabBarHeight;
//            tabBar.frame  = frame;
            [UIView commitAnimations];

        }else{
            CGRect frame = tabBar.frame ;
            frame.origin.y=CGRectGetHeight(self.view.bounds) - tabBarHeight;
            tabBar.frame  = frame;
        }
        tabBarStatus=YES;
     }
}

- (void)hideTabBarWithAnimated:(BOOL)animated
{
    if (tabBarStatus) {
        if (animated) {
            [UIView beginAnimations:@"Animation" context:nil];
            [UIView setAnimationDuration:PushAnimationDuration];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDelegate:self];
            
             tabBar.hidden=YES;
//            CGRect frame = tabBar.frame ;
//            frame.origin.y=CGRectGetHeight(self.view.bounds);
//            tabBar.frame  = frame;
            [UIView commitAnimations];
        }else{
            CGRect frame = tabBar.frame ;
            frame.origin.y=CGRectGetHeight(self.view.bounds);
            tabBar.frame  = frame;
        }
        tabBarStatus=NO;
    }
}


#pragma mark - Required Protocol Method

- (void)tabBar:(CustomTabBarItem *)AKTabBarDelegate didSelectTabAtIndex:(NSInteger)index
{
    
}
@end
