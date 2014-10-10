//
//  FormMltipart.h
//  LightErector
//
//  Created by Jayden Zhao on 10/10/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFormMltipart @"FormMltipart"
typedef NS_ENUM(NSUInteger,FormMltipartType){
    FormMltipartTypeFilePath=0,
    FormMltipartTypeData=1,
    FormMltipartTypeNormal=2,
};

@interface FormMltipart : NSObject
@property(nonatomic,copy)NSString *formName;
@property(nonatomic,copy)NSString *formMimeType;
@property(nonatomic,copy)NSString *formFileName;
@property(nonatomic) FormMltipartType type;
@property(nonatomic,strong)id data;
@end
