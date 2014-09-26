//
//  TodayTaskTableViewCell.m
//  LightErector
//
//  Created by Jayden Zhao on 9/26/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "TodayTaskTableViewCell.h"
#import "CustomSwipeButton.h"

@implementation TodayTaskTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat width=[UIScreen mainScreen].applicationFrame.size.width;
        self.titleCell=[[CustomSwipeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        self.titleCell.frame=CGRectMake(0, 0, width, 44);
        self.titleCell.imageView.image=[UIImage imageNamed:@"light"];
        self.titleCell.backgroundColor=[UIColor grayColor];
        [self addSubview:self.titleCell];
        
        UIFont *font=[UIFont systemFontOfSize:14];
        CGFloat phoneWidth=90;
        CGFloat sphoneWidth=45;
        CGFloat snameWidth=60;
        CGFloat space=15;
        
        self.phoneLable=[[UILabel alloc] initWithFrame:CGRectMake(width-phoneWidth-space, self.titleCell.frame.size.height+font.lineHeight/2, phoneWidth, font.lineHeight)];
        self.phoneLable.font=font;
        self.phoneLable.textAlignment=NSTextAlignmentRight;
        self.phoneLable.text=@"18610901435";
        [self addSubview:self.phoneLable];
        UILabel *sPhoneLable=[[UILabel alloc] initWithFrame:CGRectMake(self.phoneLable.frame.origin.x-sphoneWidth, self.phoneLable.frame.origin.y, sphoneWidth, font.lineHeight)];
        sPhoneLable.font=font;
        sPhoneLable.textAlignment=NSTextAlignmentRight;
        sPhoneLable.text=@"手机：";
        [self addSubview:sPhoneLable];
        
        
        UILabel *sNamelable=[[UILabel alloc] initWithFrame:CGRectMake(space, self.phoneLable.frame.origin.y, snameWidth, font.lineHeight)];
        sNamelable.font=font;
        sNamelable.text=@"联系人：";
        [self addSubview:sNamelable];
        self.nameLable=[[UILabel alloc] initWithFrame:CGRectMake(space+snameWidth,self.phoneLable.frame.origin.y, width-2*space-phoneWidth-sphoneWidth, font.lineHeight)];
        self.nameLable.font=font;
        self.nameLable.text=@"司马无情";
        [self addSubview:self.nameLable];


        CGFloat sTimeWidth=70;
        UILabel *ssubscribeTimeLable=[[UILabel  alloc] initWithFrame:CGRectMake(space, sNamelable.frame.origin.y+sNamelable.frame.size.height+font.lineHeight/2, sTimeWidth, font.lineHeight)];
        ssubscribeTimeLable.font=font;
        ssubscribeTimeLable.text=@"预约时间：";
        [self addSubview:ssubscribeTimeLable];
        self.subscribeTimeLable=[[UILabel alloc] initWithFrame:CGRectMake(space+sTimeWidth,ssubscribeTimeLable.frame.origin.y, width-sTimeWidth, font.lineHeight)];
        self.subscribeTimeLable.font=font;
        [self addSubview:self.subscribeTimeLable];
        
        
        UILabel *sAddressLable=[[UILabel alloc] initWithFrame:CGRectMake(space, ssubscribeTimeLable.frame.origin.y+ssubscribeTimeLable.frame.size.height+font.lineHeight/2, sphoneWidth, font.lineHeight)];
        sAddressLable.font=font;
        sAddressLable.text=@"地址：";
        [self addSubview:sAddressLable];
        
        self.addressLable=[[UILabel alloc] initWithFrame:CGRectMake(space+sphoneWidth,sAddressLable.frame.origin.y, width-sphoneWidth, font.lineHeight)];
        self.addressLable.font=font;
        [self addSubview:self.addressLable];

        self.sDetailLable=[[UILabel alloc] initWithFrame:CGRectMake(space, sAddressLable.frame.origin.y+ssubscribeTimeLable.frame.size.height+font.lineHeight/2, sphoneWidth, font.lineHeight)];
        self.sDetailLable.font=font;
        self.sDetailLable.text=@"详情：";
        [self addSubview:self.sDetailLable];
        
        self.detailLable=[[UILabel alloc] initWithFrame:CGRectMake(space+sphoneWidth,self.sDetailLable.frame.origin.y, width-sphoneWidth, font.lineHeight)];
        self.detailLable.font=font;
        [self addSubview:self.detailLable];
        
        self.sRemarkLable=[[UILabel alloc] initWithFrame:CGRectMake(space, self.sDetailLable.frame.origin.y+ssubscribeTimeLable.frame.size.height+font.lineHeight/2, sphoneWidth, font.lineHeight)];
        self.sRemarkLable.font=font;
        self.sRemarkLable.text=@"备注：";
        [self addSubview:self.sRemarkLable];
        
        self.remarkLable=[[UILabel alloc] initWithFrame:CGRectMake(space+sphoneWidth,self.sRemarkLable.frame.origin.y, width-sphoneWidth, font.lineHeight)];
        self.remarkLable.font=font;
        [self addSubview:self.remarkLable];
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
