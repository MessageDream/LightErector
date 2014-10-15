//
//  Version.h
//  LightErector
//
//  Created by Jayden Zhao on 10/15/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "BaseDataModel.h"

@interface Version : BaseDataModel
@property(nonatomic,strong)NSString *version;
@property(nonatomic,strong)NSString *versionName;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *introduction;
@property(nonatomic,assign)BOOL upgrade;
-(void)getLastVersion;
@end
