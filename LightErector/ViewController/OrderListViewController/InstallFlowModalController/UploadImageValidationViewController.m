//
//  UploadCodeValidationViewController.m
//  LightErector
//
//  Created by Jayden on 14-10-6.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "UploadImageValidationViewController.h"
#import "UploadImageValidationView.h"
#import "FormMltipart.h"
#import "ImageUtils.h"
#import "BaseCustomMessageBox.h"

@interface UploadImageValidationViewController ()<MessagePhotoViewDelegate,UploadImageValidationViewDelegate>
{
    BOOL isImageUploaded;
}
@end

@implementation UploadImageValidationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView
{
    CGRect rect=[self createViewFrame];
    rect.size.height=rect.size.height-64+20;
    UploadImageValidationView *view=[[UploadImageValidationView alloc] initWithFrame:rect];
    view.observer=self;
    view.photoViewOne.delegate=self;
      view.photoViewTwo.delegate=self;
    self.view=view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)uploadImage_click:(NSDictionary *)imagesDic
{
 
    NSMutableArray *pics=[[NSMutableArray alloc] init];
    NSArray *li=[imagesDic objectForKey:@"1"];
     NSArray *ca=[imagesDic objectForKey:@"2"];
    if(li.count==0&&ca.count==0){
        [self showTip:@"请先选择图片。"];
        return;
    }
    [self lockView];
    self.order.observer=self;
    for (id item in li) {

        FormMltipart *muform=[[FormMltipart alloc] init];
        muform.formName=@"lightpic[]";
        muform.formMimeType=@"image/jpeg";
        muform.formFileName=[NSString stringWithFormat:@"lightfile%d.jpg",[li indexOfObject:item]];
        muform.type=FormMltipartTypeData;
    muform.data=item;
        
        [pics addObject: muform];
    }
    
    for (id item in ca) {
        FormMltipart *muform=[[FormMltipart alloc] init];
        muform.formName=@"cardpic[]";
        muform.formMimeType=@"image/jpeg";
        muform.formFileName=[NSString stringWithFormat:@"carfile%d.jpg",[ca indexOfObject:item]];
        muform.type=FormMltipartTypeData;
        muform.data=item;
        [pics addObject: muform];
    }
    
    [self.order uploadImage:@{kFormMltipart: pics} withMemberId:user.userid];
}

-(void)finish_click:(id)sender
{
    if (isImageUploaded) {
        self.order.observer=self;
        InstallFlowStatus status=UnSettleStatus;
        [self.order updateOrderStatusWithMemberId:user.userid flowStatus:status];
        return;
    }
    
    Message *message = [[Message alloc] init];
    message.commandID = MC_CREATE_SCROLLERFROMRIGHT_VIEWCONTROLLER;
    message.receiveObjectID = VIEWCONTROLLER_ORDERCATEGORYLIST;
    [self.observer closeStep:message];
}


-(void)didDataModelNoticeSucess:(BaseDataModel *)baseDataModel forBusinessType:(BusinessType)businessID
{
    [super didDataModelNoticeSucess:baseDataModel forBusinessType:businessID];
    switch (businessID) {
        case BUSINESS_UPLOADIMAGE:{
            isImageUploaded=YES;
            [self showTip:@"图片上传成功"];
        }
            break;
        case BUSINESS_UPDATEORDERSTATUS:{
            Message *message = [[Message alloc] init];
            message.commandID = MC_CREATE_SCROLLERFROMRIGHT_VIEWCONTROLLER;
            message.receiveObjectID = VIEWCONTROLLER_UNSETTLED;
            [self.observer closeStep:message];
        }
            break;
        default:
            break;
    }

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)addPicker:(UIImagePickerController *)picker{
    
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)addUIImagePicker:(UIImagePickerController *)picker
{
    [self presentViewController:picker animated:YES completion:nil];
}
@end
