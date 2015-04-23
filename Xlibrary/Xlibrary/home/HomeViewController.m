//
//  HomeViewController.m
//  Xlibrary
//
//  Created by mc on 15/4/16.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "HomeViewController.h"
#import "DataView.h"
#import "DateModel.h"
#import "DetailView.h"
#import "FootViewForDetail.h"
#define FOOTVIEWHEIGH 60
#define NAVHEIGHT 64
#define TOOLBARHEIGHT 44

@interface HomeViewController (){
    DataView *dateView ;
    UIScrollView *blackS;
    DateModel *dateModel;
    DetailView *detailViewLast;
    DetailView *detailViewCur;
    DetailView *detailViewNext;
    FootViewForDetail *footView;
    UIDatePicker *_dataPicker;
    UIView *_datePickerBackView;
    BOOL isShowDataPicker;
    NSInteger datePickerHight;
}

@end
enum{
    RIGHTBTN_CALENDAR = 10001,
    RIGHTBTN_ADD,
    DATEPICK_DO,
    DATEPICK_UNDO
    
};
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isShowDataPicker = NO;
    dateModel = [DateModel sharedDateModel];
    [self loadNavigationItemView];
    [self loadMainView];
    [self loadFootView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadDatePicker];
    datePickerHight  = _dataPicker.height;
   
    // Do any additional setup after loading the view.
}
-(void)loadDatePicker{
    _dataPicker  = [[UIDatePicker alloc]init];
    _dataPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, TOOLBARHEIGHT, 0 , 0)];
    _datePickerBackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-NAVHEIGHT, self.view.width, _dataPicker.height+TOOLBARHEIGHT)];
    [_datePickerBackView addSubview:_dataPicker];
    [self.view addSubview:_datePickerBackView];
    //日期模式
    NSLocale *local = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    _dataPicker.locale = local;
    _dataPicker.backgroundColor = [UIColor grayColor];
    [_dataPicker setDatePickerMode:UIDatePickerModeDate];
    //定义最小日期
    NSDateFormatter *formatter_minDate = [[NSDateFormatter alloc] init];
    [formatter_minDate setDateFormat:@"yyyy-MM-dd"];
    [_dataPicker addTarget:self action:@selector(dataValueChanged:) forControlEvents:UIControlEventValueChanged];
    UIToolbar *toolBar = [[UIToolbar alloc]init];
    
    
    toolBar.frame = CGRectMake(0, 0, kScreenWidth, TOOLBARHEIGHT);
    UIButton *btnDo = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDo.frame =CGRectMake(0, 0, 50, 20);
    [btnDo setBackgroundColor:[UIColor greenColor]];
    [btnDo setTitle:@"完成" forState:UIControlStateNormal];
    btnDo.tag = DATEPICK_DO;
    [btnDo addTarget:self action:@selector(datePickToolbarAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *b1 = [[UIBarButtonItem alloc]initWithCustomView:btnDo];
    
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIButton *btnCl = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCl.frame =CGRectMake(0, 0, 50, 20);
    [btnCl setBackgroundColor:[UIColor redColor]];
    [btnCl setTitle:@"取消" forState:UIControlStateNormal];
    btnCl.tag = DATEPICK_UNDO;
    [btnCl addTarget:self action:@selector(datePickToolbarAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *b2 = [[UIBarButtonItem alloc]initWithCustomView:btnCl];
    
    toolBar.items  = @[b1,item,item,b2];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [_datePickerBackView addSubview:toolBar];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    formatter = nil;
    
    
}
-(void)datePickToolbarAction:(UIButton *)sender{
    if (!isShowDataPicker){
      [UIView animateWithDuration:.5 animations:^{
          _datePickerBackView.transform = CGAffineTransformMakeTranslation(0, datePickerHight + TOOLBARHEIGHT);
      }];
    }
}
-(void)dataValueChanged:(id)sender
{
    
}
-(void)loadFootView{
    footView= [[FootViewForDetail alloc]initWithFrame:CGRectMake(0, self.view.height-FOOTVIEWHEIGH-NAVHEIGHT, self.view.width, FOOTVIEWHEIGH)];
    [footView setValue:@"22" forKeyPath:@"footViewForDetailModel.oddNumber"];
    [footView setValue:@"22" forKeyPath:@"footViewForDetailModel.totalNumber"];
    [self.view addSubview:footView];
}
-(void)loadMainView{
    blackS= [[UIScrollView alloc]init];
    blackS.backgroundColor = COLOR_DIFFERENT_VAULE(212, 122, 122);
    blackS.frame = self.view.bounds;
    blackS.height = self.view.height - FOOTVIEWHEIGH-NAVHEIGHT;
    blackS.contentSize = CGSizeMake(self.view.width*3, self.view.width);
    blackS.contentOffset = CGPointMake(self.view.width, 0);
    blackS.showsVerticalScrollIndicator = NO;
    blackS.showsHorizontalScrollIndicator= NO;
    blackS.delegate = self;
    blackS.pagingEnabled = YES;
    detailViewCur = [[DetailView alloc]initWithFrame:CGRectMake(blackS.width, 0, blackS.width, blackS.height) ];
    [blackS addSubview:detailViewCur];
    detailViewLast = [[DetailView alloc]initWithFrame:CGRectMake(0, 0, blackS.width, blackS.height) ];
    [blackS addSubview:detailViewLast];
    detailViewNext = [[DetailView alloc]initWithFrame:CGRectMake(blackS.width*2, 0, blackS.width, blackS.height) ];
    [blackS addSubview:detailViewNext];
    [self.view addSubview:blackS];

}
-(void)loadNavigationItemView{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:nil highImageName:nil target:self action:@selector(leftBarButtonItemAction) ];
    UIButton *rightBtnAdd = [UIButton buttonWithType:UIButtonTypeContactAdd];
    rightBtnAdd.frame = CGRectMake(kScreenWidth-60,0, 40, 40);
    rightBtnAdd.showsTouchWhenHighlighted = YES;
    [rightBtnAdd addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    rightBtnAdd.tag = RIGHTBTN_ADD;
    [self.navigationController.navigationBar addSubview:rightBtnAdd];
    
    UIButton *rightBtnCalendar = [UIButton buttonWithType:UIButtonTypeContactAdd];
    rightBtnCalendar.frame = CGRectMake(kScreenWidth-100,0, 40, 40);
    [rightBtnCalendar addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    rightBtnCalendar.tag = RIGHTBTN_CALENDAR;
    rightBtnCalendar.showsTouchWhenHighlighted = YES;
    [self.navigationController.navigationBar addSubview:rightBtnCalendar];
    dateView = [[DataView alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    self.navigationItem.titleView = dateView;
    
}
#pragma mark   scrollviewdelgate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat scrollviewW =  scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollviewW / 2) /  scrollviewW;
    if (page == 0){
        [dateView showLastDary];
        scrollView.contentOffset = CGPointMake(self.view.width, 0);
    }
    else if (page == 2){
        [dateView showNextDay];
        scrollView.contentOffset = CGPointMake(self.view.width, 0);
    }
    else{
        
    }
}
-(void)leftBarButtonItemAction{
    
}
-(void)rightBtnAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == RIGHTBTN_CALENDAR){
        if (!isShowDataPicker){
                [UIView animateWithDuration:.5 animations:^{
                    _datePickerBackView.transform = CGAffineTransformMakeTranslation(0, -datePickerHight- TOOLBARHEIGHT) ;
                }];
        }
    }
    else if (btn.tag == RIGHTBTN_ADD)
    {
        
    }
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
