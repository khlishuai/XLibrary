//
//  StatisticalFloorView.h
//  Xlibrary
//
//  Created by mc on 15/4/17.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StatisticalFloorView;

@protocol StatisticalFloorViewDataSource <NSObject>
- (NSInteger)numberOfControllersInStatisticalView:(StatisticalFloorView *)sender;
- (UIViewController *)Statistical:(StatisticalFloorView *)sender controllerAt:(NSInteger)index;
@end

@protocol StatisticalFloorViewDelegate <NSObject>
@optional
- (void)StatisticalFloorView:(StatisticalFloorView *)slide switchingFrom:(NSInteger)oldIndex to:(NSInteger)toIndex percent:(float)percent;
- (void)StatisticalFloorView:(StatisticalFloorView *)slide didSwitchTo:(NSInteger)index;
- (void)StatisticalFloorView:(StatisticalFloorView *)slide switchCanceled:(NSInteger)oldIndex;
@end


@interface StatisticalFloorView : UIView
@property (nonatomic,assign)NSInteger   selectedIndex;
@property (nonatomic,weak)UIViewController   *baseViewController;
@property (nonatomic,weak)id <StatisticalFloorViewDataSource>dataSource;
@property (nonatomic,weak)id <StatisticalFloorViewDelegate>delegate;


-(void)switchTo:(NSInteger)index;



/**
 *  @class DLSlideView;
 
 @protocol DLSlideViewDataSource <NSObject>
 - (NSInteger)numberOfControllersInDLSlideView:(DLSlideView *)sender;
 - (UIViewController *)DLSlideView:(DLSlideView *)sender controllerAt:(NSInteger)index;
 @end
 
 @protocol DLSlideViewDelegate <NSObject>
 @optional
 - (void)DLSlideView:(DLSlideView *)slide switchingFrom:(NSInteger)oldIndex to:(NSInteger)toIndex percent:(float)percent;
 - (void)DLSlideView:(DLSlideView *)slide didSwitchTo:(NSInteger)index;
 - (void)DLSlideView:(DLSlideView *)slide switchCanceled:(NSInteger)oldIndex;
 @end
 
 @interface DLSlideView : UIView
 //@property(nonatomic, strong) NSArray *viewControllers;
 @property(nonatomic, assign) NSInteger selectedIndex;
 @property(nonatomic, weak) UIViewController *baseViewController;
 @property(nonatomic, weak) id<DLSlideViewDelegate>delegate;
 @property(nonatomic, weak) id<DLSlideViewDataSource>dataSource;
 - (void)switchTo:(NSInteger)index;

 */

@end
