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
#import "TodayTaskTableViewTitleCell.h"

@implementation UITableViewCellModel
-(id)initWithCellType:(NSString *)cellType isAttached:(BOOL) isAttached andContentModel:(id)model
{
    if (self=[super init]) {
        _cellType=cellType;
        _isAttached=isAttached;
        _contentModel=model;
    }
    return self;
}
@end

@interface TodayTaskViewController () <UITableViewDelegate,UITableViewDataSource,PullRefreshTableViewDelegate>
{
}
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

-(id)init
{
    if (self=[super init]) {
        
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
    taskView.tableView.observer=self;
    
    self.view=taskView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    UITableViewCellModel *model=[[UITableViewCellModel alloc] initWithCellType:MAINCELL isAttached:NO andContentModel:nil];
    NSArray * array = @[model,model,model,model,model,model];
    
    self.dataArray = [[NSMutableArray alloc]init];
    self.dataArray = [NSMutableArray arrayWithArray:array];
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
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellModel *model=self.dataArray[indexPath.row];
    if ([model.cellType isEqualToString:MAINCELL])
    {
        
        static NSString *CellIdentifier = MAINCELL;
        
        TodayTaskTableViewTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        if (cell == nil) {
            cell = [[TodayTaskTableViewTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.optionButton.hidden=YES;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [cell createOptionButtonWithTitle:@"去安装" andIcon:nil andBackgroundColor:[UIColor redColor]];
        cell.textLabel.text=[NSString stringWithFormat:@"TEST%d",indexPath.row];
        if (model.isAttached) {
            cell.optionButton.hidden=NO;
            cell.accessoryType=UITableViewCellAccessoryNone;
        }else{
             cell.optionButton.hidden=YES;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
        
        
    }else if([model.cellType isEqualToString:ATTACHEDCELL]){
        
        static NSString *CellIdentifier = ATTACHEDCELL;
        
        TodayTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        if (cell == nil) {
            cell = [[TodayTaskTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
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
    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSIndexPath *path = nil;
    
    UITableViewCellModel *model= self.dataArray[indexPath.row];
    if ([model.cellType isEqualToString:MAINCELL]) {
        path = [NSIndexPath indexPathForItem:(indexPath.row+1) inSection:indexPath.section];
    }else{
        path = indexPath;
    }
    
    NSIndexPath *pathlast = [NSIndexPath indexPathForItem:(path.row-1) inSection:indexPath.section];
    
    if (model.isAttached) {
        // 关闭附加cell
        UITableViewCellModel *model=[[UITableViewCellModel alloc] initWithCellType:MAINCELL isAttached:NO andContentModel:nil];
        self.dataArray[(path.row-1)] = model;
        [self.dataArray removeObjectAtIndex:path.row];
        
        
        [tableView beginUpdates];
        [tableView reloadRowsAtIndexPaths:@[pathlast] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView deleteRowsAtIndexPaths:@[path]  withRowAnimation:UITableViewRowAnimationMiddle];
        [tableView endUpdates];
        
    }else{
        // 打开附加cell
        UITableViewCellModel *addModel=[[UITableViewCellModel alloc] initWithCellType:ATTACHEDCELL isAttached:YES andContentModel:nil];
        [self.dataArray insertObject:addModel atIndex:path.row];
        
        UITableViewCellModel *model=[[UITableViewCellModel alloc] initWithCellType:MAINCELL isAttached:YES andContentModel:nil];
        self.dataArray[(path.row-1)] = model;
        
        
        [tableView beginUpdates];
        
        [tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationBottom];
        [tableView reloadRowsAtIndexPaths:@[pathlast] withRowAnimation:UITableViewRowAnimationRight];
        [tableView endUpdates];
    }
    
}

-(void)pullRefreshTableViewRefresh:(PullRefreshTableView*)pullRefreshTableView
{

}

- (CGFloat)pullRefreshTableView:(PullRefreshTableView *)pullRefreshTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[self tableView:pullRefreshTableView.tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)pullRefreshTableView:(PullRefreshTableView *)pullRefreshTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.row);
    [pullRefreshTableView.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSIndexPath *path = nil;
    
    UITableViewCellModel *model= self.dataArray[indexPath.row];
    if ([model.cellType isEqualToString:MAINCELL]) {
        path = [NSIndexPath indexPathForItem:(indexPath.row+1) inSection:indexPath.section];
    }else{
        path = indexPath;
    }
    
    NSIndexPath *pathlast = [NSIndexPath indexPathForItem:(path.row-1) inSection:indexPath.section];
    
    if (model.isAttached) {
        // 关闭附加cell
        UITableViewCellModel *model=[[UITableViewCellModel alloc] initWithCellType:MAINCELL isAttached:NO andContentModel:nil];
        self.dataArray[(path.row-1)] = model;
        [self.dataArray removeObjectAtIndex:path.row];
        
        
        [pullRefreshTableView.tableView beginUpdates];
        [pullRefreshTableView.tableView reloadRowsAtIndexPaths:@[pathlast] withRowAnimation:UITableViewRowAnimationLeft];
        [pullRefreshTableView.tableView deleteRowsAtIndexPaths:@[path]  withRowAnimation:UITableViewRowAnimationMiddle];
        [pullRefreshTableView.tableView endUpdates];
        
    }else{
        // 打开附加cell
        UITableViewCellModel *addModel=[[UITableViewCellModel alloc] initWithCellType:ATTACHEDCELL isAttached:YES andContentModel:nil];
        [self.dataArray insertObject:addModel atIndex:path.row];
        
        UITableViewCellModel *model=[[UITableViewCellModel alloc] initWithCellType:MAINCELL isAttached:YES andContentModel:nil];
        self.dataArray[(path.row-1)] = model;
        
        
        [pullRefreshTableView.tableView beginUpdates];
        
        [pullRefreshTableView.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationBottom];
        [pullRefreshTableView.tableView reloadRowsAtIndexPaths:@[pathlast] withRowAnimation:UITableViewRowAnimationRight];
        [pullRefreshTableView.tableView endUpdates];
    }
    

}

-(void)dealloc
{
    
}
@end
