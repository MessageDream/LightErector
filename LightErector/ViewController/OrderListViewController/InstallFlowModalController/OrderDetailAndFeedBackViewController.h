//
//  OrderDetailAndFeedBackViewController.h
//  LightErector
//
//  Created by Jayden on 14-10-5.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "BaseViewController.h"
@class Order;
@interface OrderDetailAndFeedBackViewController : BaseViewController
@property(nonatomic,strong)Order *order;
@property(nonatomic,assign)BOOL isDetail;
@end
