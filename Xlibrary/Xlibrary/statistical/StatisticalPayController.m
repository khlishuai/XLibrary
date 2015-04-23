//
//  StatisticalPayController.m
//  Xlibrary
//
//  Created by mc on 15/4/17.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "StatisticalPayController.h"
#import "statisticalModel.h"
#import "StatisticalPICell.h"
#import "CircleView.h"
#import "CircleModel.h"
#import "IncreaseLabel.h"
#import "SelectTimeView.h"
#import "StatisticalPopview.h"

#define TabelViewHeight     150.f
#define TIMELABEL_FONT      16.f
#define SelectTimeHeight    240.f

@interface StatisticalPayController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
    UITableView     *_tableview;
    CircleModel     *_cirmodel;
    UILabel         *_beginlabel;
    UILabel         *_endlabel;
    IncreaseLabel         *_payCountLabel;
    SelectTimeView  *_selectTimeView;
}
@end

@implementation StatisticalPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HexRGB(0xfcfcea);

    _dataArray = [[NSMutableArray alloc]init];
    [self InitilizeTop];
    
    [self InitilizeCircle];
    [self InitilizeTable];
    [self getTestData];
    
    
    
    
    //self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
}

#pragma mark - Test data
-(void)getTestData
{
    NSString *plistStr =[[NSBundle mainBundle]pathForResource:@"testPlist" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistStr];
    
    float temp = 0.f;
    for(NSString *ont in dict)
    {
       temp += [[dict objectForKey:ont]floatValue];
    }
    
    for(NSString *keyS in dict)
    {
        
        statisticalModel *model = [[statisticalModel alloc]init];
        model.typeStr = NSStringFormat(keyS);
        model.imageName = [NSString stringWithFormat:@"%@ hole",model.typeStr];
        model.countstr = NSStringFormat([dict objectForKey:keyS]);
        model.typeName = NSStringFormat([self getchinesename:keyS]);
        NSString *percentstr = [NSString stringWithFormat:@"%.3f",[model.countstr floatValue]/temp];
        model.percentStr = [NSString stringWithFormat:@"%.1f%%",[percentstr floatValue]*100];
        model.corlorStr = NSStringFormat([self getimagename:model.typeStr]);
        [_dataArray addObject:model];
        
    }
    
    [self sortingArr];
    
    
    [_tableview reloadData];
    
    [_cirmodel show:_dataArray];
    

}

-(void)sortingArr
{
    for(int i=0;i<_dataArray.count-2;i++)
    {
        for(int j=0;j<_dataArray.count-1-i;j++)
        {
            statisticalModel *model1 = _dataArray[j];
            statisticalModel *model2 = _dataArray[j+1];
            if([model1.countstr floatValue]<[model2.countstr floatValue])
            {
                [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    
}



-(NSString*)getimagename:(NSString*)key
{
    NSString *plistStr =[[NSBundle mainBundle]pathForResource:@"StatisicalPlist" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistStr];
    NSString *imageName = [dict objectForKey:key];
    return imageName;
}

-(NSString*)getchinesename:(NSString*)key
{
    NSString *plistStr =[[NSBundle mainBundle]pathForResource:@"StatisicalChinesePlist" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistStr];
    NSString *chineseName = [dict objectForKey:key];
    return chineseName;
}
#pragma mark - set control


-(void)InitilizeTop
{
    UIButton    *timeScopeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    timeScopeBtn.frame=FRAME(0, 0, kScreenWidth, 40);
    [timeScopeBtn addTarget:self action:@selector(timescopeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:timeScopeBtn];
    
    _beginlabel = [[UILabel alloc]initWithFrame:FRAME(0, 0, (kScreenWidth-20)/2, 40.f)];
    _beginlabel.textAlignment = NSTextAlignmentRight;
    _beginlabel.font = [UIFont boldSystemFontOfSize:TIMELABEL_FONT];
    _beginlabel.textColor = [UIColor blackColor];
    [timeScopeBtn addSubview:_beginlabel];
    
    UILabel     *middleLabel = [[UILabel alloc]initWithFrame:FRAME(_beginlabel.rightX, 0, 20, 40)];
    middleLabel.textAlignment = NSTextAlignmentCenter;
    middleLabel.font = [UIFont boldSystemFontOfSize:TIMELABEL_FONT];
    middleLabel.textColor = [UIColor blackColor];
    middleLabel.text = @"~";
    [timeScopeBtn addSubview:middleLabel];
    
    _endlabel = [[UILabel alloc]initWithFrame:FRAME(middleLabel.rightX, 0, (kScreenWidth-20)/2, 40)];
    _endlabel.textAlignment = NSTextAlignmentLeft;
    _endlabel.textColor = [UIColor blackColor];
    _endlabel.font = [UIFont boldSystemFontOfSize:TIMELABEL_FONT];
    [timeScopeBtn addSubview:_endlabel];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:FRAME(10, timeScopeBtn.bottomY+5, kScreenWidth-20, 0.5)];
    lineView.backgroundColor = HexRGB(LINE_COLOR);
    [self.view addSubview:lineView];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:FRAME((kScreenWidth-100)/2, lineView.bottomY + 10, 100.f, 20)];
    label1.font = Label_font(18.f);
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = HexRGB(0x333333);
    label1.text = @"现金";
    [self.view addSubview:label1];
    
    
    NSDate *nowDate = [NSDate date];
    NSString *beginStr = @"";
    beginStr = [NSString stringWithFormat:@"%d/%02d/%02d",[[beginStr year:nowDate]intValue],[[beginStr month:nowDate] intValue],1];
    _beginlabel.text = beginStr;
    NSString *endStr = @"";
    endStr = [NSString stringWithFormat:@"%d/%02d/%02d",[[endStr year:nowDate] intValue],[[endStr month:nowDate]intValue],[[beginStr nowMonthDays:nowDate] intValue]];
    _endlabel.text = endStr;
    
    
}

-(void)InitilizeTable
{
    UIView *lineView = [[UIView alloc]initWithFrame:FRAME(10, kScreenHeight-TabelViewHeight-NavaStatusHeight-4, kScreenWidth-20, 0.5)];
    lineView.backgroundColor = HexRGB(LINE_COLOR);
    [self.view addSubview:lineView];
    
    
    _tableview = [[UITableView alloc]initWithFrame:FRAME(0, kScreenHeight-TabelViewHeight-NavaStatusHeight, kScreenWidth, TabelViewHeight) style:UITableViewStylePlain];
    _tableview.backgroundColor = [UIColor lightGrayColor];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = HexRGB(0xfcfcea);

    [self.view addSubview:_tableview];
}

-(void)InitilizeCircle
{

    
    _cirmodel = [[CircleModel alloc]init];
    CircleView *view = [[CircleView alloc]initWithFrame:FRAME(0, 100.f, kScreenWidth, 260.f)];
    view.backgroundColor =HexRGB(0xfcfcea);
    [self.view addSubview:view];
    _cirmodel.circleV = view;
    
    
    
    //创建支出label
    UILabel *label2 = [[UILabel alloc]initWithFrame:FRAME((kScreenWidth-60)/2, 90, 60.f, 16)];
    label2.text = @"支出";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont boldSystemFontOfSize:14.f];
    label2.textColor = HexRGB(0x333333);
    [view addSubview:label2];
    
    _payCountLabel = [[IncreaseLabel alloc]initWithFrame:FRAME((kScreenWidth-110)/2, label2.bottomY+5, 110.f, 45)];
    _payCountLabel.textAlignment = NSTextAlignmentCenter;
    _payCountLabel.numberOfLines=2;
    _payCountLabel.font = [UIFont boldSystemFontOfSize:18.f];
    _payCountLabel.textColor = HexRGB(0x515151);
    [view addSubview:_payCountLabel];
    
    //test
    _payCountLabel.increaseText = @"100";
    
    
}
#pragma mark - actions
-(void)timescopeClick
{
    if(!_selectTimeView)
    {
        _selectTimeView = [[SelectTimeView alloc]initWithFrame:FRAME(20, 200, kScreenWidth-40, SelectTimeHeight)];
        [_selectTimeView setTwoTF:_beginlabel.text withEndTXT:_endlabel.text];
        __weak StatisticalPayController *_home = self;
        _selectTimeView.myBlock =^(NSString*beginSt,NSString *endSt) {
            [_home changeBegin:beginSt withEnd:endSt];
        };
        
    }
    else
    {
        [_selectTimeView show];
        [_selectTimeView setTwoTF:_beginlabel.text withEndTXT:_endlabel.text];
    }
    
    
}

-(void)changeBegin:(NSString*)benginS withEnd:(NSString*)endS
{
    _beginlabel.text = benginS;
    _endlabel.text = endS;
    
    
    //刷新界面
    [_cirmodel test:_dataArray];

}

#pragma mark - UITableViewDelegate or datasource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELLHEIGHT;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[StatisticalPopview shareInstance]showWithArray:_dataArray];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName  = @"STATICSICALCELL";
    StatisticalPICell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if(!cell)
    {
        cell = [[StatisticalPICell alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    statisticalModel *model = [_dataArray objectAtIndex:indexPath.row];
    cell.sortinglabel.text = [NSString stringWithFormat:@"%ld.",indexPath.row+1];
    cell.picview.image = IMAGE_NAMED(model.imageName);
    cell.percentlabel.text = model.percentStr;
    cell.namelabel.text = model.typeName;
    cell.countlabel.text = [NSString stringWithFormat:@"¥%@",model.countstr];
    cell.picview.backgroundColor = [UIColor hexStringToColor:model.corlorStr];
    return cell;
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
