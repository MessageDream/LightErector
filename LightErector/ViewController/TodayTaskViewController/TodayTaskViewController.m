//
//  TodayTaskViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 9/26/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "TodayTaskViewController.h"
#import "TodayTaskView.h"
#import "TodayTaskTableViewCell.h"
#import "CustomSwipeButton.h"

@interface TodayTaskViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation TodayTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)settingViewControllerId
{
    _viewControllerId=VIEWCONTROLLER_TODAYTASK;
}

-(void)loadView
{
    CGRect frame=[self createViewFrame];
    frame.size.height=frame.size.height-DefaultTabBarHeight;
    TodayTaskView *taskView=[[TodayTaskView alloc]initWithFrame:frame];
    taskView.tableView.dataSource=self;
    taskView.tableView.delegate=self;
    
    self.view=taskView;
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell *cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIden = @"taskCell";
    TodayTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (!cell) {
        cell = [[TodayTaskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.titleCell.rightSwipeSettings.transition = CustomSwipeTransitionBorder;
    cell.titleCell.rightExpansion.buttonIndex = 1;
    cell.titleCell.rightExpansion.fillOnTrigger = YES;
    cell.titleCell.rightButtons = [self createRightButtons:1];
    cell.titleCell.textLabel.text=@"TEST";
    
    cell.nameLable.text=@"司马无情";
    cell.phoneLable.text=@"18610901435";
    cell.subscribeTimeLable.text=@"2014-12-20 18:00:00";
    
    CGSize maximumLabelSize = CGSizeMake(cell.subscribeTimeLable.frame.size.width,MAXFLOAT);
    
    NSString *str=@"如果您没有提交密码重置的请求或不是 酷鱼桌面美化社区 的注册用户，请立即忽略 并删除这封邮件。只有在您确认需要重置密码的情况下，才需要继续阅读下面的 内容";
    CGRect frame;
    if (str!=nil) {
        CGSize expectedLabelSizeAddr = [str sizeWithFont:cell.nameLable.font
                                       constrainedToSize:maximumLabelSize
                                           lineBreakMode:NSLineBreakByWordWrapping];
        
        frame=cell.addressLable.frame;
        frame.size=expectedLabelSizeAddr;
        cell.addressLable.frame=frame;
        cell.addressLable.numberOfLines=0;
        cell.addressLable.text=str;
        
        frame=cell.sDetailLable.frame;
        frame.origin.y=cell.addressLable.frame.origin.y+expectedLabelSizeAddr.height+cell.nameLable.font.lineHeight/2;
        cell.sDetailLable.frame=frame;
    }
    
    if (str!=nil) {
        CGSize expectedLabelSizeDetail = [str sizeWithFont:cell.nameLable.font
                                         constrainedToSize:maximumLabelSize
                                             lineBreakMode:NSLineBreakByWordWrapping];
        
        frame=cell.detailLable.frame;
        frame.origin.y=cell.sDetailLable.frame.origin.y;
        frame.size=expectedLabelSizeDetail;
        cell.detailLable.frame=frame;
        cell.detailLable.numberOfLines=0;
        cell.detailLable.text=str;
        
        frame=cell.sRemarkLable.frame;
        frame.origin.y=cell.detailLable.frame.origin.y+expectedLabelSizeDetail.height+cell.nameLable.font.lineHeight/2;
        cell.sRemarkLable.frame=frame;
        
        
    }
    
    if (str!=nil) {
        
        CGSize expectedLabelSizeRemark = [str sizeWithFont:cell.nameLable.font
                                         constrainedToSize:maximumLabelSize
                                             lineBreakMode:NSLineBreakByWordWrapping];
        
        frame=cell.remarkLable.frame;
        frame.origin.y=cell.sRemarkLable.frame.origin.y;
        frame.size=expectedLabelSizeRemark;
        cell.remarkLable.frame=frame;
        cell.remarkLable.numberOfLines=0;
        cell.remarkLable.text=str;
    }
    
    frame=cell.frame;
    frame.size.height=cell.remarkLable.frame.origin.y+cell.remarkLable.frame.size.height+cell.nameLable.font.lineHeight/2;
    cell.frame=frame;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.row);
}

-(NSArray *) createRightButtons: (int) number
{
    NSMutableArray * result = [NSMutableArray array];
    NSString* titles[1] = {@"去安装"};
    UIColor * colors[1] = {[UIColor colorWithRed:57.0f/255.0f green:166.0f/255.0f blue:215.0f/255.0f alpha:1]};
    for (int i = 0; i < number; ++i)
    {
        CustomSwipeButton * button = [CustomSwipeButton buttonWithTitle:titles[i] backgroundColor:colors[i] callback:^BOOL(CustomSwipeTableCell * sender){
            NSLog(@"Convenience callback received (right).");
            return YES;
        }];
        [result addObject:button];
    }
    return result;
}
@end
