//
//  StepBaseViewController.h
//  LightErector
//
//  Created by Jayden on 14-10-5.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "BaseViewController.h"
#import "Order.h"

@protocol StepBaseViewControllerDelegate <NSObject>
-(void)nextStep;
-(void)previousStep;
-(void)closeStep;
@end

@interface StepBaseViewController : BaseViewController
@property(nonatomic,strong)Order *order;
@property(nonatomic,weak)id<StepBaseViewControllerDelegate> observer;
@end
