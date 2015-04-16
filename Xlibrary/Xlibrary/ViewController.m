//
//  ViewController.m
//  Xlibrary
//
//  Created by mc on 15/4/16.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton    *testbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    testbutton.frame = CGRectMake(100, 100, 100, 100);
    testbutton.backgroundColor = [UIColor blueColor];
    [self.view addSubview:testbutton];
    // Do any additional setup after loading the view, typically from a nib.
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
