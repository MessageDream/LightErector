//
//  InstallFlowViewController.h
//  LightErector
//
//  Created by Jayden on 14-10-3.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "RMStepsController.h"
#import "Order.h"

@interface InstallFlowModalController : RMStepsController
@property(nonatomic,strong)void(^whenCLosed)(InstallFlowModalController *controller);
@property(nonatomic,strong)Order *currentOrder;
@property(nonatomic,strong)id extData;
-initWithOrder:(Order *)order andClosedBlock:(void(^)(InstallFlowModalController *controller)) whenCLosed;
@end