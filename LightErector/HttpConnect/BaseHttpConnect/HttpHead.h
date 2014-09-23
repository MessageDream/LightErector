//
//  HttpHead.h
//  HttpConnect
//
//  Created by Jayden Zhao on 13-3-31.
//  Copyright (c) 2013年 LightErector. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpHead : NSObject
{
    NSString *headName;
    NSString *headValue;
}
@property(nonatomic,strong)NSString *headName;
@property(nonatomic,strong)NSString *headValue;
@end
