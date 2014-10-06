//
//  AppDelegate.h
//  LightErector
//
//  Created by Jayden Zhao on 9/23/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@class RootModule;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
     BMKMapManager* _mapManager;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RootModule *rootModule;
@end
