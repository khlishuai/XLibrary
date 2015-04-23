//
//  DateModel.h
//  Xlibrary
//
//  Created by wgl7569 on 15-4-17.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateModel : UIView
singleton_h(DateModel);
-(NSString *)getCurDay;
-(NSString *)getlastDay;
-(NSString *)getNextDay;
-(void)setCurDay:(id)date;
@end
