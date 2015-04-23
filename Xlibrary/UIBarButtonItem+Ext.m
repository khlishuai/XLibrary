//
//  UIBarButtonItem+Ext.m
//  Xlibrary
//
//  Created by wgl7569 on 15-4-17.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "UIBarButtonItem+Ext.h"


@implementation UIBarButtonItem (Extension)
+(UIBarButtonItem *)itemWithImageName:(NSString *)ImageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    //自定义UIView
    UIButton *btn=[[UIButton alloc]init];
    
    //设置按钮的背景图片（默认/高亮）
    [btn setBackgroundImage:IMAGE_NAMED(ImageName) forState:UIControlStateNormal];
    [btn setBackgroundImage:IMAGE_NAMED(highImageName) forState:UIControlStateHighlighted];
    
    //设置按钮的尺寸和图片一样大，使用了UIImage的分类
    btn.size=btn.currentBackgroundImage.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}
@end
