//
//  CircleModel.h
//  Xlibrary
//
//  Created by mc on 15/4/17.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CircleView.h"

typedef enum
{
    _TYPE_SELECT_PAY=0,
    _TYPE_SELECT_INCOME,
    _TYPE_SELECT_REMAINING
}_TYPE_SELECT;


@interface CircleModel : NSObject



@property (nonatomic,strong)CircleView *circleV;

@property (nonatomic,strong)NSString *payCount;

@property (nonatomic,strong)NSArray     *percentArr;

@property (nonatomic)_TYPE_SELECT       currentSelect;



@end
