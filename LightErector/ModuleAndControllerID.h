//
//  ModuleAndControllerID.h
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#ifndef ModuleAndControllerID_h
#define ModuleAndControllerID_h

#define Module_WORK_LENGTH 100
//按模块划分，每个模块分配100个ID(ID不可为Module类型),作为本Module的工作范围，以Module为当前根节点
enum ModuleAndControllerID
{
    VIEWCONTROLLER_NONE = -3,
    Module_NONE = -2,
    VIEWCONTROLLER_RETURN = -1,
    Module_ROOT = 0,
    
    Module_SYSTEM = 1000,
    VIEWCONTROLLER_LOGIN,
    VIEWCONTROLLER_TODAYTASK,

    Module_TEST = 3000,
    VIEWCONTROLLER_TEST1,
    VIEWCONTROLLER_TEST2,
    VIEWCONTROLLER_TEST3,
    VIEWCONTROLLER_TEST4,
    VIEWCONTROLLER_TEST5,
    VIEWCONTROLLER_TEST6,
};

#endif
