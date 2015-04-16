//
//  centerViewController.h
//  menuProject
//
//  Created by mc on 15/4/15.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface centerViewController : UIViewController
- (void)hideLeftViewController:(BOOL)animated;
 - (void)revealLeftViewController:(BOOL)animated;
 - (void)hideLeftViewController:(BOOL)animated completion:(void (^)())completion;
 - (void)revealLeftViewController:(BOOL)animated completion:(void (^)())completion;


//-(void)hideLeftViewController:(BOOL)animated;
//-(void)showLeftViewController:(BOOL)animated;
//-(void)hideLeftViewController:(BOOL)animated completion:(void(^)())completion;
//-(void)showLeftViewController:(BOOL)animated completion:(void(^)())completion;
//

@property (nonatomic,strong)UIViewController    *leftViewController;
@property (nonatomic,strong)UIViewController    *contentViewController;
@property (nonatomic,readonly)UIScrollView      *scrollView;
@property (nonatomic,strong)UIView              *backgroundView;
@property (nonatomic,assign,getter=isSpringAnimationOn) BOOL springAnimationOn;


@end

@interface UIViewController (centerViewController)

@property (nonatomic,readonly)centerViewController *wta_centerviewcontroller;

@end
