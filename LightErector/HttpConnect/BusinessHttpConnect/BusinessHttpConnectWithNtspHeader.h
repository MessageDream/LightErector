//
//  BusinessHttpConnectWithNtspHeader.h
//  LightErector
//
//  Created by Jayden Zhao on 13-4-8.
//  Copyright (c) 2013年 LightErector. All rights reserved.
//

#import "BaseBusinessHttpConnect.h"
@class NtspHeader;
@interface BusinessHttpConnectWithNtspHeader : BaseBusinessHttpConnect
@property(strong,nonatomic) NtspHeader * ntspHeader;

@end
