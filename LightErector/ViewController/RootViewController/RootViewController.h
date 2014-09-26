//
//  RootViewController.h
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "BaseViewController.h"


@interface RootViewController : BaseViewController
{
}

@property (nonatomic, assign) BOOL tabTitleIsHidden;

- (void)showTabBarWithAnimated:(BOOL)animated;
- (void)hideTabBarWithAnimated:(BOOL)animated;
@end
