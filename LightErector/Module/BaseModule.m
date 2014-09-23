//
//  BaseModule.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "BaseModule.h"
#import "BaseViewController.h"
#import <QuartzCore/QuartzCore.h>

#define AnimationDuration 0.5
#define LightErectorViewTag 9000
static enum commandID currentcommandID;

@interface BaseModule()
{
    BaseViewController *previousViewController;
    BaseViewController *holdViewController;
    BaseViewController *showViewController;
    UIView *rootView;
}
-(void)animationSystemBlock:(BaseViewController*)viewcontroller forDuration:(double)duration forType:(NSString*)type forSubtype:(NSString*)subtype;
-(void)customAnimationBlock:(BaseViewController*)viewcontroller forcommandID:(enum commandID)ID;
-(void)animationDidStop;
@end

@implementation BaseModule
@synthesize childModule = _childModule;
@synthesize ModuleId = _ModuleId;
@synthesize workRange = _workRange;

-(id)init
{
    self = [super init];
    _workRange.length = Module_WORK_LENGTH;
    previousViewController = nil;
    return self;
}

-(void)sendMessage:(Message*)message
{
    if(self.parentModule == nil)
        return;
    [self.parentModule receiveMessage:message];
}

-(BOOL)receiveMessage:(Message*)message
{
    BOOL checkFlag = YES;
    if(![self checkWorkRange:message.receiveObjectID])
    {
        checkFlag = NO;
        //[self sendMessage:message];
        //return NO;
    }
    if(!checkFlag)
    {
        BaseModule *Module = [self checkChildModuleWorkRange:message.receiveObjectID];
        if(Module!=nil)
            [Module receiveMessage:message];
        else
        {
            [self sendMessage:message];
            return NO;
        }
    }
    //[self ModuleSaveValue:Message];
    return YES;
}

-(BOOL)checkWorkRange:(enum ModuleAndControllerID)ID
{
    if(ID != self.ModuleId)
    {
        if(ID<self.workRange.location || ID>self.workRange.location+self.workRange.length)
        {
            return NO;
        }
    }
    return YES;
}

-(BaseModule*)checkChildModuleWorkRange:(enum ModuleAndControllerID)ID
{
    NSArray *BaseModuleArray = _childModule.allValues;
    for(int n=0;n<BaseModuleArray.count;n++)
    {
        BaseModule *Module = [BaseModuleArray objectAtIndex:n];
        if([Module checkWorkRange:ID])
            return Module;
        Module = [Module checkChildModuleWorkRange:ID];
        if(Module)
            return Module;
    }
    return nil;
}

-(void)addViewControllToRootViewController:(BaseViewController*)viewcontroller forMessage:(Message*)message
{
    if(currentcommandID == MC_CREATE_OPENFROMRIGHT_VIEWCONTROLLER||currentcommandID == MC_CREATE_POPFROMBOTTOM_VIEWCONTROLLER)
        holdViewController = [self.rootViewController.childViewControllers objectAtIndex:1];
    
    if(self.rootViewController.childViewControllers.count>0)
    {
        previousViewController = [self.rootViewController.childViewControllers objectAtIndex:0];
        if(message.commandID != MC_CREATE_CLOSEFROMRIGHT_VIEWCONTROLLER&&message.commandID!=MC_CREATE_CLOSEPOPFROMTOP_VIEWCONTROLLER)
            [previousViewController destroyDataBeforeDealloc];
        else if(message.commandID == MC_CREATE_CLOSEFROMRIGHT_VIEWCONTROLLER||message.commandID == MC_CREATE_CLOSEPOPFROMTOP_VIEWCONTROLLER)
        {
            viewcontroller = previousViewController;
            previousViewController = holdViewController;
        }
    }
    
    currentcommandID = message.commandID;
    viewcontroller.parentModule = self;
    if (!viewcontroller.doCache) {
        [viewcontroller receiveMessage:message];
    }
    showViewController = viewcontroller;
    if(message.commandID!=MC_CREATE_NORML_VIEWCONTROLLER)
        showViewController.view.userInteractionEnabled = NO;
    
    [self.rootViewController addChildViewController:viewcontroller];
    if (!rootView) {
        rootView=[self.rootViewController.view viewWithTag:LightErectorViewTag];
    }
    rootView.layer.masksToBounds=YES;
    // UIView *rootView=self.rootViewController.view;
    if(message.commandID == MC_CREATE_NORML_VIEWCONTROLLER)
    {
        [rootView addSubview:viewcontroller.view];
        [self animationDidStop];
        
    }
    else if(message.commandID == MC_CREATE_FLIPFROMLEFT_VIEWCONTROLLER)
    {
        [rootView addSubview:viewcontroller.view];
        [self customAnimationBlock:viewcontroller forcommandID:MC_CREATE_FLIPFROMLEFT_VIEWCONTROLLER];
    }
    else if(message.commandID == MC_CREATE_PUSHFROMRIGHT_VIEWCONTROLLER)
    {
        [rootView addSubview:viewcontroller.view];
        [self animationSystemBlock:viewcontroller forDuration:AnimationDuration forType:kCATransitionPush forSubtype:kCATransitionFromRight];
    }
    else if(message.commandID == MC_CREATE_PUSHFROMLEFT_VIEWCONTROLLER)
    {
        [rootView addSubview:viewcontroller.view];
        [self animationSystemBlock:viewcontroller forDuration:AnimationDuration forType:kCATransitionPush forSubtype:kCATransitionFromLeft];
    }
    else if(message.commandID == MC_CREATE_OPENFROMRIGHT_VIEWCONTROLLER)
    {
        [rootView insertSubview:viewcontroller.view belowSubview:previousViewController.view];
        [self customAnimationBlock:previousViewController forcommandID:message.commandID];
    }
    else if(message.commandID == MC_CREATE_CLOSEFROMRIGHT_VIEWCONTROLLER)
    {
        [rootView addSubview:viewcontroller.view];
        [self customAnimationBlock:viewcontroller forcommandID:message.commandID];
    }
    else if(message.commandID == MC_CREATE_POPFROMBOTTOM_VIEWCONTROLLER)
    {
        [rootView addSubview:viewcontroller.view];
        [self customAnimationBlock:viewcontroller forcommandID:message.commandID];
    }
    else if(message.commandID == MC_CREATE_CLOSEPOPFROMTOP_VIEWCONTROLLER)
    {
        [rootView insertSubview:viewcontroller.view belowSubview:previousViewController.view];
        [self customAnimationBlock:previousViewController forcommandID:message.commandID];
    }
    else if(message.commandID == MC_CREATE_SCROLLERFROMLEFT_VIEWCONTROLLER)
    {
        [rootView addSubview:viewcontroller.view];
        [self customAnimationBlock:viewcontroller forcommandID:message.commandID];
    }
    else if(message.commandID == MC_CREATE_SCROLLERFROMRIGHT_VIEWCONTROLLER)
    {
        [rootView addSubview:viewcontroller.view];
        [self customAnimationBlock:viewcontroller forcommandID:message.commandID];
    }
    else if(message.commandID == MC_CREATE_GRADUALLYINTO_VIEWCONTROLLER)
    {
         [rootView addSubview:viewcontroller.view];
        [self customAnimationBlock:viewcontroller forcommandID:message.commandID];
    }
    else if(message.commandID == MC_CREATE_GRADUALLYOUT_VIEWCONTROLLER)
    {
        [rootView insertSubview:viewcontroller.view belowSubview:previousViewController.view];
        [self customAnimationBlock:viewcontroller forcommandID:message.commandID];
    }
    else
        return;
    //[viewcontroller receiveMessage:message];
    previousViewController.view.userInteractionEnabled = NO;
}

-(void)addModuleOfSaveData:(NSString*)key forValue:(id)value
{
    if(saveData==nil)
        saveData = [[NSMutableDictionary alloc] init];
    
    [saveData setObject:value forKey:key];
}

-(id)getModuleOfSaveDataAtKey:(NSString*)key
{
    return [saveData objectForKey:key];
}

-(void)ModuleClearValue
{
    [saveData removeAllObjects];
}

-(void)animationSystemBlock:(BaseViewController*)viewcontroller forDuration:(double)duration forType:(NSString*)type forSubtype:(NSString*)subtype
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseIn]];
    [animation setDelegate:self];
    [animation setType:type];
    [animation setSubtype: subtype];
    [viewcontroller.view.layer addAnimation:animation forKey:@"animation"];
}

-(void)customAnimationBlock:(BaseViewController*)viewcontroller forcommandID:(enum commandID)ID
{
    if(ID == MC_CREATE_OPENFROMRIGHT_VIEWCONTROLLER)
    {
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:AnimationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
        
        CGRect frame = viewcontroller.view.frame;
        frame.origin.x = [UIScreen mainScreen].bounds.size.width-100;
        viewcontroller.view.frame = frame;
        [UIView commitAnimations];
    }
    else if(ID == MC_CREATE_CLOSEFROMRIGHT_VIEWCONTROLLER)
    {
        CGRect frame = viewcontroller.view.frame;
        frame.origin.x = [UIScreen mainScreen].bounds.size.width-100;
        viewcontroller.view.frame = frame;
        
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:AnimationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
        
        frame.origin.x = 0;
        viewcontroller.view.frame = frame;
        [UIView commitAnimations];
    }
    else if(ID == MC_CREATE_POPFROMBOTTOM_VIEWCONTROLLER)
    {
        CGRect oldframe = viewcontroller.view.frame;
        oldframe.origin.y=oldframe.size.height;
        viewcontroller.view.frame=oldframe;
        
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:AnimationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
        
        CGRect frame = viewcontroller.view.frame ;
        frame.origin.y=0;
        viewcontroller.view.frame = frame;
        [UIView commitAnimations];
    }
    else if(ID == MC_CREATE_CLOSEPOPFROMTOP_VIEWCONTROLLER)
    {
       
        
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:AnimationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
        
        CGRect oldframe = viewcontroller.view.frame;
        oldframe.origin.y=oldframe.size.height;
        viewcontroller.view.frame=oldframe;
        [UIView commitAnimations];
    }
    else if(ID == MC_CREATE_FLIPFROMLEFT_VIEWCONTROLLER)
    {
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:AnimationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
        [UIView transitionFromView:previousViewController.view toView:viewcontroller.view duration:AnimationDuration options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
        [UIView commitAnimations];
    }
    else if(ID == MC_CREATE_SCROLLERFROMRIGHT_VIEWCONTROLLER)
    {
        CGRect newFrame = viewcontroller.view.frame;
        newFrame.origin.x = newFrame.size.width;
        viewcontroller.view.frame = newFrame;

        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:AnimationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
        
        newFrame.origin.x = 0;
        viewcontroller.view.frame = newFrame;
        
        CGRect previousFrame = previousViewController.view.frame;
        previousFrame.origin.x=previousFrame.origin.x-previousFrame.size.width;
        previousViewController.view.frame = previousFrame;
        [UIView commitAnimations];
    }
    else if(ID == MC_CREATE_SCROLLERFROMLEFT_VIEWCONTROLLER)
    {
        CGRect newFrame = viewcontroller.view.frame;
        newFrame.origin.x = newFrame.origin.x - newFrame.size.width;
        viewcontroller.view.frame = newFrame;
        
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:AnimationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
        
        newFrame.origin.x = 0;
        viewcontroller.view.frame = newFrame;
        
        CGRect previousFrame = previousViewController.view.frame;
        previousFrame.origin.x=previousFrame.size.width;
        previousViewController.view.frame = previousFrame;
        [UIView commitAnimations];
    }
    else if(ID == MC_CREATE_GRADUALLYINTO_VIEWCONTROLLER)
    {
        viewcontroller.view.alpha = 0.0;
        
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:AnimationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
        viewcontroller.view.alpha = 1.0;
        [UIView commitAnimations];
    }
    else if(ID == MC_CREATE_GRADUALLYOUT_VIEWCONTROLLER)
    {
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:AnimationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
        previousViewController.view.alpha = 0.0;
        [UIView commitAnimations];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self animationDidStop];
}

-(void)animationDidStop
{
     rootView.layer.masksToBounds=NO;
    if(previousViewController!=nil)
    {
        if(currentcommandID != MC_CREATE_OPENFROMRIGHT_VIEWCONTROLLER&&currentcommandID!=MC_CREATE_POPFROMBOTTOM_VIEWCONTROLLER)
        {
            [previousViewController.view removeFromSuperview];
            [previousViewController removeFromParentViewController];
        }
        if(holdViewController!=nil)
        {
            [holdViewController.view removeFromSuperview];
            [holdViewController removeFromParentViewController];
            holdViewController = nil;
        }
        previousViewController = nil;
    }
    showViewController.view.userInteractionEnabled = YES;
    showViewController = nil;
}

-(BOOL)createChildModule
{
    return NO;
}
@end
