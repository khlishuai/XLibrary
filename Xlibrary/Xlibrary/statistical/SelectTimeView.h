//
//  SelectTimeView.h
//  Xlibrary
//
//  Created by mc on 15/4/21.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DoneChangeBlock) (NSString*,NSString*);


@interface SelectTimeView : UIView

@property (nonatomic,strong)DoneChangeBlock myBlock;

-(void)setTwoTF:(NSString *)begintxt withEndTXT:(NSString*)endtxt;

-(void)show;

@end
