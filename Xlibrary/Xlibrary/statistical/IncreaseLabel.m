//
//  IncreaseLabel.m
//  Xlibrary
//
//  Created by mc on 15/4/21.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "IncreaseLabel.h"

@implementation IncreaseLabel
{
    NSTimer     *myTimer;
    NSInteger   _tag;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _tag = 0;
    }
    return self;
}

-(void)setIncreaseText:(NSString *)increaseText
{
    [myTimer invalidate];
    _tag = 0;
    _increaseText=increaseText;
    myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateText) userInfo:nil repeats:YES];
}

-(void)updateText
{
    _tag++;
    if(_tag == 10){
        [myTimer invalidate];
        self.text = _increaseText;
        return;
    }
    
    
    NSLog(@"mmmmmmmmmmmmmmm");
    float temp = [_increaseText floatValue]/10*_tag;
    self.text = [NSString stringWithFormat:@"%d",(int)temp];
    
    
    
    
    
}







@end
