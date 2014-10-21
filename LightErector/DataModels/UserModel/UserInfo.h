//
//  UserInfo.h
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "BaseDataModel.h"

@interface UserInfo : BaseDataModel
@property (nonatomic,strong)NSString  *address;
@property (nonatomic,strong)NSString  *qq;
@property (nonatomic,strong)NSString  *email;
@property (nonatomic,strong)NSString  *telephone;
@property (nonatomic,strong)NSString  *mobilephone;
-(id)initWithDic:(NSDictionary *)dic;
-(NSDictionary *)convertToDic;
@end
