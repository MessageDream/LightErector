//
//  HttpConnectRespones.h
//  HttpConnect
//
//  Created by Jayden Zhao on 13-3-31.
//  Copyright (c) 2013年 LightErector. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpConnectRespones : NSObject
{
    NSDictionary *_responesHead;
    NSData *_responesData;
}
@property(nonatomic,strong)NSDictionary *responesHead;
@property(nonatomic,strong)NSData *responesData;
@end
