//
//  DetailView.m
//  Xlibrary
//
//  Created by wgl7569 on 15-4-20.
//  Copyright (c) 2015年 mc. All rights reserved.
//
#import "DetailView.h"
#define leftW 30
#define topH 30
@interface HomeDetailCell : UITableViewCell
@property (nonatomic , strong)UIImageView *leftImage;
@property (nonatomic , strong)UILabel *leftLabel;
@property (nonatomic , strong)UILabel *rightLablel;
@end
@implementation HomeDetailCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setBackgroundColor:[UIColor clearColor]];
        UIView *backV = [[UIView alloc]init];
        backV.frame = CGRectMake(leftW, 0, self.width,self.height-5);
        backV.backgroundColor = [UIColor orangeColor];
        [self addSubview:backV];
        
        _leftImage = [[UIImageView alloc]init];
        _leftImage.frame = CGRectMake(5, 5, backV.height-10, self.height-10);
        [backV addSubview:_leftImage];
        
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.frame = CGRectMake(_leftImage.rightX+10, _leftImage.originY, 200, _leftImage.height);
        _leftLabel.text = @"123";
        [backV addSubview:_leftLabel];
        
        _rightLablel = [[UILabel alloc]init];
        _rightLablel.frame = CGRectMake(backV.width- 30-10, _leftImage.originY, 30, _leftImage.height);
        _rightLablel.text = @"123";
        [backV addSubview:_rightLablel];

        
    }
    return self;
}

@end
@implementation DetailView{
    UILabel *labelL;
    UILabel *labelR ;
    UITableView *detailTV;
}
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self loadSubView];
    }
    return self;
}
-(void)loadSubView{
     labelL= [[UILabel alloc]init];
    labelL.textColor = [UIColor whiteColor];
    labelL.font = [UIFont systemFontOfSize:30 weight:2];
    labelL.frame = CGRectMake(leftW, topH, 100, 60);
    labelL.text = @"CNY";
    
    labelR = [[UILabel alloc]init];
    labelR.textColor = [UIColor whiteColor];
    labelR.font = [UIFont systemFontOfSize:30 weight:2];
    labelR.frame = CGRectMake(self.width-labelL.width-leftW, topH, 100, 60);
    labelR.textAlignment = NSTextAlignmentRight;
    labelR.text = @"70";

    [self addSubview:labelL];
    [self addSubview:labelR];
    
    
    
    
    detailTV = [[UITableView alloc]initWithFrame:CGRectMake(0,labelL.bottomY,self.width,self.height-labelL.bottomY) style:UITableViewStylePlain];
    [detailTV setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [detailTV setBackgroundColor:[UIColor clearColor]];
    detailTV.delegate = self;
    detailTV.dataSource = self;
    
    [self addSubview:detailTV];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ident = @"cell";
    HomeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell){
        cell = [[HomeDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
