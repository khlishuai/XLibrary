//
//  StatisticalViewController.h
//  Xlibrary
//
//  Created by mc on 15/4/16.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatisticalPayController.h"
#import "StatisticalRemainViewController.h"
#import "StatisticalFloorView.h"
#define floorColor @"35a6a4"
@interface StatisticalViewController : UIViewController

@property (nonatomic,strong)StatisticalPayController *payController;
@property (nonatomic,strong)StatisticalPayController *incomeController;
@property (nonatomic,strong)StatisticalRemainViewController *remainController;


@end
