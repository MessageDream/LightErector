//
//  BaseBusinessHttpConnect.h
//  G_NetLink
//
//  Created by Jayden Zhao on 14-3-20.
//  Copyright (c) 2014年 LightErector. All rights reserved.
//

#import "FileHttpConnect.h"


@interface BaseBusinessHttpConnect : FileHttpConnect

@property(nonatomic) int baseBussinessHttpConnectId;

- (void)createBaseBussinessHttpBody:(NSDictionary *)theParam;
-(void)setUrlParam:(NSDictionary *)theParam;
- (void)sendWithParam:(NSDictionary *)param;
@end
