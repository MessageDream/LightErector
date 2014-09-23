//
//  FileHttpConnect.h
//  HttpConnect
//
//  Created by jishu on 13-4-2.
//  Copyright (c) 2013年 LightErector. All rights reserved.
//

#import "BaseHttpConnect.h"

@interface FileHttpConnect : BaseHttpConnect
{
@protected
    NSString *_uploadFilePath;
    NSString *_downloadFilePath;
}
@property(nonatomic,strong)NSString *uploadFilePath;
@property(nonatomic,strong)NSString *downloadFilePath;

@end
