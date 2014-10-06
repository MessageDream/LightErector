//
//  UserInfo.h
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "BaseDataModel.h"

@interface UserInfo : BaseDataModel
@property (nonatomic,readonly)NSString  *address;
@property (nonatomic,readonly)NSString  *qq;
@property (nonatomic,readonly)NSString  *email;
@property (nonatomic,readonly)NSString  *telephone;
@property (nonatomic,readonly)NSString  *mobilephone;
-(id)initWithDic:(NSDictionary *)dic;
-(NSDictionary *)convertToJson;
@end
