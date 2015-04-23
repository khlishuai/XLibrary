//
//  FootViewForDetail.m
//  Xlibrary
//
//  Created by wgl7569 on 15-4-21.
//  Copyright (c) 2015年 mc. All rights reserved.
//
@interface FootViewForDetailModel : NSObject
{
    NSInteger oddNumber;
    NSInteger totalNumber;
}
@end
@implementation FootViewForDetailModel


@end
#import "FootViewForDetail.h"
@implementation FootViewForDetail
{
    FootViewForDetailModel *footViewForDetailModel;
    UILabel *preLablel;
}

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = COLOR_DIFFERENT_VAULE(234, 231, 200);
        footViewForDetailModel = [[FootViewForDetailModel alloc]init];
        [footViewForDetailModel setValue:@"0" forKey:@"oddNumber"];
        [footViewForDetailModel setValue:@"0" forKey:@"totalNumber"];
        [self loadSubView];
        
    }
    return self;
}
-(UILabel *)creatLableWithText:(NSString *)text withSize:(CGFloat)size withWeight:(CGFloat)weight
{
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:size weight:weight];
    return label;
}
-(void)loadSubView{
   
    UILabel *totalLabel = [self creatLableWithText:@"预算总额" withSize:12 withWeight:.1];
    [self addSubview:totalLabel];
    totalLabel.frame = CGRectMake(self.width -50-20, self.height -25, 50, 20);
    UILabel *oddLabel = [self creatLableWithText:@"剩余预算" withSize:12 withWeight:.1];
    oddLabel.frame = CGRectMake(totalLabel.originX -50-20, totalLabel.originY, 50, 20);
    [self addSubview:oddLabel];
    
    _oddNumberLabel = [self creatLableWithText:@"" withSize:20 withWeight:.6];
    _oddNumberLabel.frame = CGRectMake(oddLabel.originX - 30, oddLabel.originY-20, 80, 20);
    _oddNumberLabel.textAlignment  = NSTextAlignmentRight;
    _oddNumberLabel.text = [NSString stringWithFormat:@"￥%@/",[footViewForDetailModel valueForKey:@"oddNumber"]];
    [self addSubview:_oddNumberLabel];
    
    
    _totalNumberLabel = [self creatLableWithText:@"" withSize:15 withWeight:.6];
    _totalNumberLabel.frame = CGRectMake(totalLabel.originX - 30, totalLabel.originY-20, 80, 20);
    _totalNumberLabel.textAlignment  = NSTextAlignmentRight;
    _totalNumberLabel.text = [NSString stringWithFormat:@"%@",[footViewForDetailModel valueForKey:@"totalNumber"]];
    [self addSubview:_totalNumberLabel];
    [footViewForDetailModel addObserver:self forKeyPath:@"oddNumber" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [footViewForDetailModel addObserver:self forKeyPath:@"totalNumber" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    preLablel  = [self creatLableWithText:@"%0" withSize:12 withWeight:.1];
    preLablel.frame = CGRectMake(20, 48, 40, 12);
    preLablel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:preLablel];
    
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"oddNumber"]){
        _oddNumberLabel.text = [NSString stringWithFormat:@"￥%@/",[footViewForDetailModel valueForKey:@"oddNumber"]];
        
    }
    else if ([keyPath isEqualToString:@"totalNumber"]){
        _totalNumberLabel.text = [NSString stringWithFormat:@"%@",[footViewForDetailModel valueForKey:@"totalNumber"]];
    }
    if([[footViewForDetailModel valueForKey:@"totalNumber"]integerValue] != 0){
        preLablel.text = [NSString stringWithFormat:@"%ld%@",[[footViewForDetailModel valueForKey:@"oddNumber"]integerValue]/[[footViewForDetailModel valueForKey:@"totalNumber"]integerValue]*100,@"%"];
    }
  }
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(20, 5, 40, 40));
    [[UIColor blackColor]setFill];
    CGContextFillPath(context);
}
-(void)dealloc{
    [footViewForDetailModel removeObserver:self forKeyPath:@"oddNumber"];
    [footViewForDetailModel removeObserver:self forKeyPath:@"totalNumber"];
}

@end
