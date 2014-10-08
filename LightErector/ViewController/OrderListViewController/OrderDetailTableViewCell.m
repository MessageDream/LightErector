//
//  TodayTaskTableViewCell.h
//  LightErector
//
//  Created by Jayden Zhao on 9/26/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "OrderDetailTableViewCell.h"

@implementation OrderDetailTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
        self.accessoryType=UITableViewCellAccessoryNone;
        
        self.infoView=[[OrderInfoView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        self.nameLable=self.infoView.nameLable;
        self.phoneLable=self.infoView.phoneLable;
        self.subscribeTimeLable=self.infoView.subscribeTimeLable;
        self.addressLable=self.infoView.addressLable;
       self.detailLable=self.infoView.detailLable;
       self.remarkLable=self.infoView.remarkLable;
        
       self.sDetailLable=self.infoView.sDetailLable;
       self.sRemarkLable=self.infoView.sRemarkLable;
        [self addSubview:self.infoView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
@end
