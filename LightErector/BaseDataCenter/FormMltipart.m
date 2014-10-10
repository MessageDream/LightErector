//
//  FormMltipart.m
//  LightErector
//
//  Created by Jayden Zhao on 10/10/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "FormMltipart.h"

@implementation FormMltipart
-(void)dealloc{
    self.formMimeType = nil;
    self.formName = nil;
    self.formFileName = nil;
    self.data = nil;
}
@end
