//
//  CircleView.m
//  Xlibrary
//
//  Created by mc on 15/4/17.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "CircleView.h"
#import "statisticalModel.h"
#import <QuartzCore/QuartzCore.h>

#define LightColor  0xf0f8ff
#define DarkColor   0xd4d4d4
@implementation CircleView
{
    NSMutableArray *coulorArr;
    float   timertime;
    NSTimer     *timer1;
    NSInteger   _teag;
    float startAngle;
    NSMutableArray  *layerArr;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setArr:(NSArray*)darat{
    if(!coulorArr)
    {
        coulorArr = [[NSMutableArray alloc]init];
        layerArr = [[NSMutableArray alloc]init];
        
    }
    
    
    [coulorArr removeAllObjects];
    [coulorArr addObjectsFromArray:darat];
}

#define DEGREES_TO_RADIANS(degrees)((M_PI * degrees)/180)

-(void)test
{
    
   // [self.layer removeAllAnimations];
    //删除layer 一下两种都可以
    //[self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    NSEnumerator *enumerator = [self.layer.sublayers reverseObjectEnumerator];
    for(CALayer *layer in enumerator) {
        if([layer isKindOfClass:[CAShapeLayer class]])
        {
            [layer removeFromSuperlayer];

        }
    }
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //CGContextClearRect(UIGraphicsGetCurrentContext(), self.frame);
    _teag = 0;
    statisticalModel *model = coulorArr[1];
    timertime =[model.percentStr floatValue]/100* 1;
    
    //圆环底
    UIBezierPath *circleround = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kScreenWidth/2, 130) radius:100 startAngle:DEGREES_TO_RADIANS(0.0f) endAngle:DEGREES_TO_RADIANS(360.f) clockwise:YES];
    [HexRGB(LightColor) setStroke];
    circleround.lineWidth = 60;
    [circleround stroke];
    
    
    [self updateCircle];
    
    //圆环内圈
    CGContextRef context =UIGraphicsGetCurrentContext();
    UIColor*aColor = HexRGB(0xfcfcea);
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    CGContextSetLineWidth(context, 8.0);//线的宽度
    CGContextSetStrokeColorWithColor(context, [HexRGB(DarkColor) CGColor]);
    CGContextAddArc(context, kScreenWidth/2, 130, 66.f, 0, 2*PI, 0); //添加一个圆
    //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
}

-(void)updateCircle
{

    statisticalModel *model = coulorArr[_teag];
    float temp =[model.percentStr floatValue]/100 * 360;
    NSLog(@"%f",temp);
    UIBezierPath *circle1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, 30) radius:100.f startAngle:startAngle * M_PI/180 endAngle:(startAngle+temp) * M_PI / 180 clockwise:YES];
    CAShapeLayer* arcLayer=[CAShapeLayer layer];
    arcLayer.path=circle1.CGPath;//46,169,230
    arcLayer.fillColor =[HexRGB(0xfcfcea)CGColor];
    arcLayer.strokeColor=[UIColor hexStringToColor:model.corlorStr].CGColor;
    arcLayer.lineWidth=60;
    arcLayer.frame=self.frame;
    [self.layer addSublayer:arcLayer];
    timertime =[model.percentStr floatValue]/100* 1;

    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration=timertime;
    bas.delegate=self;
    bas.fromValue=[NSNumber numberWithInteger:0];
    bas.toValue=[NSNumber numberWithInteger:1];
    [arcLayer addAnimation:bas forKey:@"key"];
    startAngle += temp;
     _teag++;
    [layerArr addObject:arcLayer];
    if(_teag>=coulorArr.count)
    {
        return;
    }
    [self performSelector:@selector(updateCircle) withObject:nil afterDelay:timertime];
   

}

-(void)drawLineAnimation:(CALayer*)layer
{
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration=1.f;
    bas.delegate=self;
    bas.fromValue=[NSNumber numberWithInteger:0];
    bas.toValue=[NSNumber numberWithInteger:1];
    [layer addAnimation:bas forKey:@"key"];
}

@end
