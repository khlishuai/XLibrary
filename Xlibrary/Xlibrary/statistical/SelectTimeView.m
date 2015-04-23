//
//  SelectTimeView.m
//  Xlibrary
//
//  Created by mc on 15/4/21.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "SelectTimeView.h"

#define UNSelectTF 0x969696
#define SelectTF    0x303030

typedef enum
{
    TYPE_DAY_COUNTS_LONG=0,
    TYPE_DAY_COUNTS_MIDDLE,
    TYPE_DAY_COUNTS_SHORT,
    TYPE_DAY_COUNTS_RSHAORT
}TPYE_DAY_COUNTS;

typedef enum
{
    TYPE_SELECT_BEGIN=0,
    TYPE_SELECT_END,
    TYPE_SELECT_NONE
}TYPE_SELECT;

@interface SelectTimeView ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UITextField     *_beginTF;
    UITextField     *_endTF;
    UIPickerView    *_myPickView;
    UIWindow *keywindow;
    TPYE_DAY_COUNTS currentType;        //当前的pickerview的日是31，还是30，或29，或28
    
    NSInteger       syear;              //当前的年
    NSInteger       smonth;             //当前的月
    NSInteger       sday;               //当前的日
    
    TYPE_SELECT     currentSelect;     //当前选择的类型
}
@property (nonatomic, retain) UIControl *controlForDismiss;                     //没有按钮的时候，才会使用这个


@end

@implementation SelectTimeView


-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor =HexRGB(0xfcfcea);
        
        currentSelect = TYPE_SELECT_NONE;
        [self InitilizeUI];
        [self InitilizeControls];
    }
    
    return self;
}


//设置两个tf的初始值
-(void)setTwoTF:(NSString *)begintxt withEndTXT:(NSString*)endtxt
{
    _beginTF.text = begintxt;
    _endTF.text=endtxt;
    
    
    
}


-(void)InitilizeUI
{
    UILabel     *label1 = [[UILabel alloc]initWithFrame:FRAME(0, 5, kScreenWidth-40.f, 20)];
    label1.text = @"请选择日期";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = Label_font(14.f);
    label1.textColor = HexRGB(0x333333);
    [self addSubview:label1];
    
    UIView *lineView = [[UIView alloc]initWithFrame:FRAME(0, label1.bottomY+5, kScreenWidth-40.f, 0.5)];
    lineView.backgroundColor = HexRGB(LINE_COLOR);
    [self addSubview:lineView];
    
    UILabel     *label2 = [[UILabel alloc]initWithFrame:FRAME(0, lineView.bottomY+5, kScreenWidth-40.f, 20)];
    label2.text = @"起始";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = Label_font(14.f);
    label2.textColor = HexRGB(0x333333);
    [self addSubview:label2];
    
    _beginTF = [[UITextField alloc]initWithFrame:FRAME(60, label2.bottomY+5, (kScreenWidth-40-120), 30)];
    _beginTF.delegate=self;
    _beginTF.backgroundColor = HexRGB(UNSelectTF);
    _beginTF.textColor = HexRGB(0xffffff);
    _beginTF.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_beginTF];
    
    UILabel     *label3 = [[UILabel alloc]initWithFrame:FRAME(0, _beginTF.bottomY+5, kScreenWidth-40.f, 20)];
    label3.text = @"结束";
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = Label_font(14.f);
    label3.textColor = HexRGB(0x333333);
    [self addSubview:label3];
    
    _endTF = [[UITextField alloc]initWithFrame:FRAME(60, label3.bottomY+5, (kScreenWidth-40-120), 30)];
    _endTF.backgroundColor = HexRGB(UNSelectTF);
    _endTF.delegate=self;
    _endTF.textColor = HexRGB(0xffffff);
    _endTF.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_endTF];
    
    UIButton    *cancelB = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelB.frame = FRAME(_beginTF.originX, _endTF.bottomY+30, 90, 30);
    cancelB.backgroundColor = HexRGB(UNSelectTF);
    [cancelB setTitle:@"取消" forState:UIControlStateNormal];
    [cancelB setTitleColor:HexRGB(0xffffff) forState:UIControlStateNormal];
    [self addSubview:cancelB];
    
    UIButton    *doneB = [UIButton buttonWithType:UIButtonTypeCustom];
    doneB.frame = FRAME(_beginTF.rightX - 90, _endTF.bottomY+30, 90, 30);
    doneB.backgroundColor = HexRGB(UNSelectTF);
    [doneB setTitle:@"确定" forState:UIControlStateNormal];
    [doneB setTitleColor:HexRGB(0xffffff) forState:UIControlStateNormal];
    [self addSubview:doneB];
    
    
    [cancelB addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [doneB addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
}

-(void)InitilizeControls
{
    if(!_controlForDismiss)
    {
        _controlForDismiss = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _controlForDismiss.backgroundColor = HexRGBA(0x111111, .5);
        
    }
    
    keywindow = [[UIApplication sharedApplication] keyWindow];
    if (self.controlForDismiss)
    {
        [keywindow addSubview:self.controlForDismiss];
    }
    [keywindow addSubview:self];
    
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                              keywindow.bounds.size.height/2.0f);
}

//开始时begintf自动滚到指定位置

-(void)scrollToBegin
{
    NSString *beginstr = _beginTF.text;
    NSArray *arr= [beginstr componentsSeparatedByString:@"/"];
    NSString *yearStr =[NSString stringWithFormat:@"%@",arr[0]];
    NSInteger yearcount = [yearStr integerValue]-1900;
    NSString *monthStr =[NSString stringWithFormat:@"%@",arr[1]];
    NSInteger monthCount = [monthStr integerValue]-1;
    NSString *dayStr =[NSString stringWithFormat:@"%@",arr[2]];
    NSInteger dayCount = [dayStr integerValue]-1;
    [_myPickView selectRow:yearcount inComponent:0 animated:YES];
    [_myPickView selectRow:monthCount inComponent:1 animated:YES];
    [_myPickView selectRow:dayCount inComponent:2 animated:YES];
    syear = [yearStr integerValue];
    smonth = monthCount+1;
    sday = [dayStr integerValue];

    
}

-(void)scrollToEnd
{
    NSString *beginstr = _endTF.text;
    NSArray *arr= [beginstr componentsSeparatedByString:@"/"];
    NSString *yearStr =[NSString stringWithFormat:@"%@",arr[0]];
    NSInteger yearcount = [yearStr integerValue]-1900;
    NSString *monthStr =[NSString stringWithFormat:@"%@",arr[1]];
    NSInteger monthCount = [monthStr integerValue]-1;
    NSString *dayStr =[NSString stringWithFormat:@"%@",arr[2]];
    NSInteger dayCount = [dayStr integerValue]-1;
    [_myPickView selectRow:yearcount inComponent:0 animated:YES];
    [_myPickView selectRow:monthCount inComponent:1 animated:YES];
    [_myPickView selectRow:dayCount inComponent:2 animated:YES];
    syear = [yearStr integerValue];
    smonth = monthCount+1;
    sday = [dayStr integerValue];
    
    
}


-(void)judgeSday
{
    switch ([self getCurrentDayCount]) {
        case TYPE_DAY_COUNTS_LONG:
        {
            
            break;
        }
        case TYPE_DAY_COUNTS_MIDDLE:
        {
            if(sday == 31)
            {
                sday = 30;
            }
            break;
        }
        case TYPE_DAY_COUNTS_SHORT:
        {
            if(sday>28)
            {
                sday=28;
            }
            break;
        }
        case TYPE_DAY_COUNTS_RSHAORT:
        {
            if(sday>29)
            {
                sday = 29;
            }
            break;
        }
        default:
            break;
    }
}

//修改tf的内容

-(void)changeTF
{
    [self judgeSday];
    switch (currentSelect) {
        case TYPE_SELECT_BEGIN:
        {
            NSString *begStr = [NSString stringWithFormat:@"%ld/%02ld/%02ld",syear,smonth,sday];
            _beginTF.text = begStr;
            break;
        }
        case TYPE_SELECT_END:
        {
            NSString *endStr = [NSString stringWithFormat:@"%ld/%02ld/%02ld",syear,smonth,sday];
            _endTF.text = endStr;
            break;
        }
        case TYPE_SELECT_NONE:
        {
            break;
        }
        default:
            break;
    }
    
    if([self getCurrentDayCount]!=currentType)
    {
        currentType = [self getCurrentDayCount];
        [_myPickView reloadComponent:2];
        
    }
}

//返回当前的天数类型
-(TPYE_DAY_COUNTS)getCurrentDayCount
{
    if(smonth==1||smonth==3||smonth==5||smonth==7||smonth==8||smonth==10||smonth==12)
    {
        return TYPE_DAY_COUNTS_LONG;
    }
    else if(smonth ==4||smonth==6||smonth==9||smonth==11)
    {
        return TYPE_DAY_COUNTS_MIDDLE;
    }
    else if((syear % 4  == 0 && syear % 100 != 0 ) || syear % 400 == 0)
    {
        return TYPE_DAY_COUNTS_RSHAORT;//闰年2月
    }
    else
    {
        return TYPE_DAY_COUNTS_SHORT;
    }
}

#pragma mark - Public

-(void)show
{
    [keywindow addSubview:_controlForDismiss];
    [keywindow addSubview:self];
    _myPickView.frame = FRAME(20, kScreenHeight, kScreenWidth-40, 180);
    [keywindow addSubview:_myPickView];
    currentSelect = TYPE_SELECT_NONE;
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                              keywindow.bounds.size.height/2.0f);
    _beginTF.backgroundColor = HexRGB(UNSelectTF);
    _endTF.backgroundColor = HexRGB(UNSelectTF);
    

}

#pragma mark - Button Actions
-(void)cancel
{
    [self removeFromSuperview];
    [_controlForDismiss removeFromSuperview];
    [_myPickView removeFromSuperview];
    //[keywindow removeFromSuperview];
}
-(void)done
{
    [self removeFromSuperview];
    [_controlForDismiss removeFromSuperview];
    [_myPickView removeFromSuperview];
    if(self.myBlock)
    {
        self.myBlock(_beginTF.text,_endTF.text);
    }

}

#pragma mark - UITextfieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(!_myPickView)
    {
        
        _myPickView = [[UIPickerView alloc]init];
        _myPickView.delegate=self;
        _myPickView.dataSource=self;
        _myPickView.backgroundColor = HexRGB(0xfcfcea);
        [keywindow addSubview:_myPickView];
        _myPickView.frame = FRAME(20, kScreenHeight, kScreenWidth-40, 180);
        
        
        
    }
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:.5f];
    CGRect rect = self.frame;
    rect.origin.y = keywindow.center.y-200;
    self.frame=rect;
    _myPickView.frame = FRAME(20, kScreenHeight-180, kScreenWidth-40, 180);
    
    [UIView commitAnimations];

    
    if([textField isEqual:_beginTF])
    {
        _beginTF.backgroundColor = HexRGB(SelectTF);
        _endTF.backgroundColor = HexRGB(UNSelectTF);
        currentSelect = TYPE_SELECT_BEGIN;
        
        NSString *beginstr = _beginTF.text;
        NSArray *arr= [beginstr componentsSeparatedByString:@"/"];
        NSString *yearStr =[NSString stringWithFormat:@"%@",arr[0]];
        NSString *monthStr =[NSString stringWithFormat:@"%@",arr[1]];
        NSInteger monthCount = [monthStr integerValue]-1;
        NSString *dayStr =[NSString stringWithFormat:@"%@",arr[2]];
        syear = [yearStr integerValue];
        smonth = monthCount+1;
        sday = [dayStr integerValue];
        
        currentType = [self getCurrentDayCount];

        [self scrollToBegin];
    }
    else if ([textField isEqual:_endTF])
    {
        _beginTF.backgroundColor = HexRGB(UNSelectTF);
        _endTF.backgroundColor = HexRGB(SelectTF);
        currentSelect = TYPE_SELECT_END;
        
        NSString *beginstr = _endTF.text;
        NSArray *arr= [beginstr componentsSeparatedByString:@"/"];
        NSString *yearStr =[NSString stringWithFormat:@"%@",arr[0]];
        NSString *monthStr =[NSString stringWithFormat:@"%@",arr[1]];
        NSInteger monthCount = [monthStr integerValue]-1;
        NSString *dayStr =[NSString stringWithFormat:@"%@",arr[2]];
        syear = [yearStr integerValue];
        smonth = monthCount+1;
        sday = [dayStr integerValue];
        
        currentType = [self getCurrentDayCount];
        
        [self scrollToEnd];

    }
    else
    {
        
    }
    
    return NO;
}




#pragma mark - UIPickViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component ==0)
    {
        return 200;
    }
    else if (component == 1)
    {
        return 12;
    }
    else
    {
        NSInteger days;
        switch (currentType) {
            case TYPE_DAY_COUNTS_LONG:
            {
                days = 31;
                break;
            }
            case TYPE_DAY_COUNTS_MIDDLE:
            {
                days=30;
                break;
            }
            case TYPE_DAY_COUNTS_SHORT:
            {
                days=28;
                break;
            }
            case TYPE_DAY_COUNTS_RSHAORT:
            {
                days=29;
                break;
            }
            default:
            {
                days=31;
                break;

            }
        }
        return days;

    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (currentSelect) {
        case TYPE_SELECT_BEGIN:
        {
            switch (component) {
                case 0:
                {
                    //改变tf中得数据
                    //
                    syear = [[self pickerView:_myPickView titleForRow:row forComponent:0] integerValue];
                    
                    break;
                }
                case 1:
                {
                    smonth = [[self pickerView:_myPickView titleForRow:row forComponent:1] integerValue];
                    break;
                }
                case 2:
                {
                    sday = [[self pickerView:_myPickView titleForRow:row forComponent:2] integerValue];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case TYPE_SELECT_END:
        {
            switch (component) {
                case 0:
                {
                    //改变tf中得数据
                    //
                    syear = [[self pickerView:_myPickView titleForRow:row forComponent:0] integerValue];
                    
                    break;
                }
                case 1:
                {
                    smonth = [[self pickerView:_myPickView titleForRow:row forComponent:1] integerValue];
                    break;
                }
                case 2:
                {
                    sday = [[self pickerView:_myPickView titleForRow:row forComponent:2] integerValue];
                    break;
                }
                default:
                    break;
            }
            break;

        }
        case TYPE_SELECT_NONE:
        {
            break;
        }
        default:
            break;
    }
    
    [self changeTF];
    
    
    
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0)
    {
        return [NSString stringWithFormat:@"%ld",1900+row];
    }
    else if(component == 1)
    {
        return [NSString stringWithFormat:@"%ld",row+1];
    }
    else
    {
        return [NSString stringWithFormat:@"%ld",row+1];
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 60.f;
}

@end
