//
//  CircleView.h
//  Xlibrary
//
//  Created by mc on 15/4/17.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView


-(id)initWithPercentArray:(NSArray*)percentArr withColorArray:(NSArray*)colorArray withEndCallback:(void(^)(void))endBlock;


@end
