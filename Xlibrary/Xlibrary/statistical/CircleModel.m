//
//  CircleModel.m
//  Xlibrary
//
//  Created by mc on 15/4/17.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "CircleModel.h"

@interface CircleModel()
{
    NSMutableArray *showDataArr;
}
@end

@implementation CircleModel

-(id)init
{
    self= [super init];
    if(self)
    {
        
        showDataArr = [[NSMutableArray alloc]init];
    }
    return self;
}


-(void)setCurrentSelect:(_TYPE_SELECT)currentSelect
{
    _currentSelect = currentSelect;
    
    
    
    
}

-(void)test:(NSArray*)dataarr
{
    [showDataArr removeAllObjects];
    [showDataArr addObjectsFromArray:dataarr];
    [_circleV setArr:dataarr];
    [_circleV test];
    [_circleV setNeedsDisplay];
    
    
    
    
}
-(void)show:(NSArray*)dataarr
{
    [showDataArr removeAllObjects];
    [showDataArr addObjectsFromArray:dataarr];
    [_circleV setArr:dataarr];
    
    [_circleV setNeedsDisplay];
    
}


@end
