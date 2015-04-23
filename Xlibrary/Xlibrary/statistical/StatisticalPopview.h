//
//  StatisticalPopview.h
//  Xlibrary
//
//  Created by mc on 15/4/22.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatisticalPopview : UIView

+(StatisticalPopview*)shareInstance;


-(void)showWithArray:(NSArray*)dataArr;

@end
