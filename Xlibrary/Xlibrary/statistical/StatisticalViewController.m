//
//  StatisticalViewController.m
//  Xlibrary
//
//  Created by mc on 15/4/16.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "StatisticalViewController.h"
#import "StatisticalFloorView.h"
@interface StatisticalViewController ()<StatisticalFloorViewDelegate,StatisticalFloorViewDataSource>
{
    StatisticalFloorView *statisticalFloor;
}
@end

@implementation StatisticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self InitilizeFloor];
    // Do any additional setup after loading the view.
}


-(void)InitilizeFloor
{
    //statisticalFloor = [[StatisticalFloorView alloc]initWithFrame:]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
