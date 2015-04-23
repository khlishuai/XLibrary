//
//  StatisticalPICell.h
//  Xlibrary
//
//  Created by mc on 15/4/20.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CELLHEIGHT  49.f

@interface StatisticalPICell : UITableViewCell

@property (nonatomic,strong)UILabel *sortinglabel;  //排序
@property (nonatomic,strong)UILabel *percentlabel;  //百分比
@property (nonatomic,strong)UILabel *namelabel;
@property (nonatomic,strong)UILabel *countlabel;
@property (nonatomic,strong)UIImageView *picview;


@end
