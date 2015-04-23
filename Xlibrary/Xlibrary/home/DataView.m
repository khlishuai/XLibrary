//
//  DataView.m
//  Xlibrary
//
//  Created by wgl7569 on 15-4-17.
//  Copyright (c) 2015年 mc. All rights reserved.
//
#import "DataView.h"
#import "DateModel.h"
@implementation DataView
{
    UIScrollView *mainScrollView;
    UILabel *curLabel;
    UILabel *lastLabel;
    UILabel *nextLabel;
    DateModel *dateModel;
}
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        dateModel = [DateModel sharedDateModel];
        [self loadView];
    }
    return self;
}
-(UILabel *)createLabel{
    UILabel *label = [[UILabel alloc]init];
    return label;
}
-(void)loadView{
    mainScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.showsVerticalScrollIndicator = NO;
    mainScrollView.pagingEnabled = YES;
    mainScrollView.contentSize = CGSizeMake(self.width, self.height*3);
    mainScrollView.contentOffset = CGPointMake(0, self.height);
    mainScrollView.userInteractionEnabled = NO;
    lastLabel = [self createLabel];
    lastLabel.frame = self.bounds;
    [mainScrollView addSubview:lastLabel];
    
    curLabel = [self createLabel];
    curLabel.frame = CGRectMake(0,self.height, self.width, self.height);
    [mainScrollView addSubview:curLabel];
    
    nextLabel = [self createLabel];
    nextLabel.frame = CGRectMake(0,self.height*2, self.width, self.height);
    [mainScrollView addSubview:nextLabel];
    [self labelSetValue];
    [self addSubview:mainScrollView];
}
-(void)labelSetValue{
    lastLabel.text = [dateModel getlastDay];
    curLabel.text = [dateModel getCurDay];
    nextLabel.text = [dateModel getNextDay];

}
-(void)showLastDary{
    [UIView animateWithDuration:1 animations:^{
        mainScrollView.contentOffset = CGPointMake(0, 0);
    } completion:^(BOOL finished) {
        [dateModel setCurDay:lastLabel.text];
        [self labelSetValue];
        mainScrollView.contentOffset = CGPointMake(0, self.height);
    }];
}
-(void)showNextDay{
    [UIView animateWithDuration:1 animations:^{
        mainScrollView.contentOffset = CGPointMake(0, self.height*2);
    } completion:^(BOOL finished) {
        [dateModel setCurDay:nextLabel.text];
        [self labelSetValue];
        mainScrollView.contentOffset = CGPointMake(0, self.height);
    }];

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
