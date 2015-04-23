//
//  StatisticalPopview.m
//  Xlibrary
//
//  Created by mc on 15/4/22.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "StatisticalPopview.h"
#import "statisticalModel.h"


#define SelfSpaceWidth   60

@interface StatisticalPopview ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray  *_dataArray;
    UITableView     *_myTableView;
    UIControl       *_myControls;
    UIButton        *_deleteButton;
}
@end

@implementation StatisticalPopview
{
    UIWindow *keywindow;
}

static StatisticalPopview *_popView;

+(StatisticalPopview*)shareInstance
{
    if(!_popView)
    {
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            _popView = [[StatisticalPopview alloc]initWithFrame:FRAME(0, 0, kScreenWidth-SelfSpaceWidth, kScreenWidth-SelfSpaceWidth)];
        });
        
    }
    return _popView;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self InitilizeControls];
    }
    return self;
}

-(void)InitilizeControls
{
    _dataArray = [[NSMutableArray alloc]init];
    
    _myControls = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _myControls.backgroundColor = HexRGBA(0x111111, .5);
//    [_myControls addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    keywindow = [[UIApplication sharedApplication]keyWindow];
    _myTableView = [[UITableView alloc]initWithFrame:FRAME(0, 0, kScreenWidth-SelfSpaceWidth, kScreenWidth-SelfSpaceWidth) style:UITableViewStylePlain];
    _myTableView.delegate=self;
    _myTableView.dataSource=self;
    _myTableView.bounces=NO;
    _myTableView.showsHorizontalScrollIndicator=NO;
    _myTableView.showsVerticalScrollIndicator=NO;
    [self addSubview:_myTableView];
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                                            keywindow.bounds.size.height/2.0f);

    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteButton.frame =  FRAME(kScreenWidth-SelfSpaceWidth/2-17, self.center.y-(kScreenWidth-SelfSpaceWidth)/2-17, 34, 34);
    [_deleteButton setImage:IMAGE_NAMED(@"deleteIconNormal") forState:UIControlStateNormal];
    [_deleteButton setImage:IMAGE_NAMED(@"deleteIconTap") forState:UIControlStateNormal];
    _deleteButton.backgroundColor = HexRGB(0xfcfcea);
    [_deleteButton addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    _deleteButton.layer.cornerRadius=17.f;
}


-(void)controlClick
{
    [[StatisticalPopview shareInstance]hideView];
}
-(void)showWithArray:(NSArray*)dataArr
{
    

    [keywindow addSubview:_myControls];
    [keywindow addSubview:[StatisticalPopview shareInstance]];
    [keywindow addSubview:_deleteButton];
    [_dataArray addObjectsFromArray:dataArr];

    [_myTableView reloadData];

}

-(void)hideView
{
    [_deleteButton removeFromSuperview];
    [[StatisticalPopview shareInstance]removeFromSuperview];
    [_myControls removeFromSuperview];
    
}


#pragma mark - UITableViewDelegate

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headview = [[UIView alloc]initWithFrame:FRAME(0, 0, kScreenWidth-SelfSpaceWidth, 70)];
    headview.backgroundColor = HexRGB(0xfcfcea);
    if(_dataArray.count>0)
    {
        statisticalModel *model = _dataArray[0];
        UIImageView *picimage = [[UIImageView alloc]initWithFrame:FRAME((kScreenWidth-SelfSpaceWidth-30)/2, 1, 30, 30)];
        picimage.image = IMAGE_NAMED(model.typeStr);
        [headview addSubview:picimage];
        
        UILabel *lable1 =[[ UILabel alloc]initWithFrame:FRAME(0, picimage.bottomY, kScreenWidth-SelfSpaceWidth, 35)];
        lable1.textAlignment=NSTextAlignmentCenter;
        lable1.textColor=HexRGB(0x333333);
        lable1.font=Label_font(13.f);
        lable1.text = model.typeName;
        [headview addSubview:lable1];
        
    }
    
    return headview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70.f;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName  = @"popViewIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellName];
        cell.contentView.backgroundColor = HexRGB(0xfcfcea);
    }
    statisticalModel *model = [_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@       现金",model.typeStr];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",model.percentStr];
    
    
    return cell;
}







@end
