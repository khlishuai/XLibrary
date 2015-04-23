//
//  StatisticalPICell.m
//  Xlibrary
//
//  Created by mc on 15/4/20.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "StatisticalPICell.h"


@implementation StatisticalPICell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        [self InitilizeControls];
    }
    return self;
}

-(void)InitilizeControls
{
    self.contentView.backgroundColor = HexRGB(0xfcfcea);
    self.sortinglabel = [[UILabel alloc]initWithFrame:FRAME(10, 0, 30, CELLHEIGHT)];
    _sortinglabel.textColor = HexRGB(0x444444);
    _sortinglabel.font = Label_font(13.f);
    _sortinglabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_sortinglabel];
    
    self.picview = [[UIImageView alloc]initWithFrame:FRAME(_sortinglabel.rightX, 5, 37, CELLHEIGHT-10)];
    _picview.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_picview];
    
    self.percentlabel = [[UILabel alloc]initWithFrame:FRAME(_picview.rightX+10, 0, 50, CELLHEIGHT)];
    _percentlabel.textColor = HexRGB(0x444444);
    _percentlabel.font = [UIFont boldSystemFontOfSize:13.f];
    _percentlabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_percentlabel];
    
    self.namelabel = [[UILabel alloc]initWithFrame:FRAME(_percentlabel.rightX, 0, 60, CELLHEIGHT)];
    _namelabel.textColor = HexRGB(0x444444);
    _namelabel.font = Label_font(13.f);
    _namelabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_namelabel];
    
    
    self.countlabel = [[UILabel alloc]initWithFrame:FRAME(kScreenWidth-80, 0, 60, CELLHEIGHT)];
    _countlabel.textColor = HexRGB(0x444444);
    _countlabel.font = Label_font(13.f);
    _countlabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_countlabel];
    
    
//    //test
//    _countlabel.backgroundColor = [UIColor redColor];
//    _percentlabel.backgroundColor = [UIColor purpleColor];
//    _namelabel.backgroundColor = [UIColor grayColor];
//    _sortinglabel.backgroundColor = [UIColor blueColor];
//    _picview.backgroundColor= [UIColor greenColor];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
