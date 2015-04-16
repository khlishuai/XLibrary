//
//  centerViewController.m
//  menuProject
//
//  Created by mc on 15/4/15.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "centerViewController.h"

#import <objc/runtime.h>

const char *centerviewcontrollerkey = "centerviewcontrollerkey";
static const CGFloat centerviewcontrollerOriginX = 150.f;

static inline void center_uiviewsetframeoriginx(UIView *view,CGFloat originx){
    [view setFrame:CGRectMake(originx, CGRectGetMinY(view.frame), CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))];
}

@implementation UIViewController(centerViewController)

-(centerViewController*)wta_centerviewcontroller
{
    centerViewController *pancenter = objc_getAssociatedObject(self, &centerviewcontrollerkey);
    if(!pancenter)
    {
        pancenter = [[self parentViewController]wta_centerviewcontroller];
    }
    
    
    return pancenter;
}

-(void)setWta_centerviewcontroller:(centerViewController *)wta_centerviewcontroller
{
    objc_setAssociatedObject(self, &centerviewcontrollerkey, wta_centerviewcontroller, OBJC_ASSOCIATION_ASSIGN);
}

@end

@interface centerView : UIView
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *contentContainerView;
@property (nonatomic, strong) UIView *leftContainerView;
@property (nonatomic, strong) UIButton *contentContainerButton;
@end

@implementation centerView

-(id)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if(self)
    {
        [self setScrollView:[[UIScrollView alloc] initWithFrame:[self bounds]]];
        [[self scrollView] setScrollsToTop:YES];
        [[self scrollView]setShowsHorizontalScrollIndicator:NO];
        [[self scrollView]setShowsVerticalScrollIndicator:NO];
        [[self scrollView]setBackgroundColor:[UIColor clearColor]];
        [[self scrollView]setContentSize:CGSizeMake(CGRectGetWidth(frame)+centerviewcontrollerOriginX, CGRectGetHeight(frame))];
        [self setLeftContainerView:[[UIView alloc] initWithFrame:[self bounds]]];
        [[self scrollView] addSubview:[self leftContainerView]];
        
        [self setContentContainerView:[[UIView alloc] initWithFrame:[self bounds]]];

        center_uiviewsetframeoriginx([self contentContainerView], centerviewcontrollerOriginX);
        [[self contentContainerView]setBackgroundColor:[UIColor clearColor]];
        [[self scrollView]addSubview:[self contentContainerView]];
        [self setContentContainerButton:[UIButton buttonWithType:UIButtonTypeCustom]];
        [[self contentContainerButton] setFrame:[[self contentContainerView] bounds]];
        [[self contentContainerView] addSubview:[self contentContainerButton]];
        
        [[self scrollView] setContentOffset:CGPointMake(centerviewcontrollerOriginX, 0.0f) animated:NO];
        
        [self addSubview:[self scrollView]];
        
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [[self backgroundView] setFrame:[self bounds]];
    [[self contentContainerView] bringSubviewToFront:[self contentContainerButton]];
}

#pragma mark - Accessors

- (void)setBackgroundView:(UIView *)backgroundView
{
    [[self backgroundView] removeFromSuperview];
    _backgroundView = backgroundView;
    [self insertSubview:[self backgroundView] atIndex:0];
}

@end


@interface centerViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)centerView *centerV;

@end

@implementation centerViewController



#pragma mark - centerViewController again

-(void)loadView
{
    centerView *view = [[centerView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [self setCenterV:view];
    [self setView:[self centerV]];}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[[self centerV]scrollView]setDelegate:self];
    [[[self centerV]contentContainerButton]setUserInteractionEnabled:YES];
    [[[self centerV]contentContainerButton]addTarget:self action:@selector(contentContainerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Do any additional setup after loading the view.
}


- (void)setBackgroundView:(UIView *)backgroundView
{
    [[self centerV] setBackgroundView:backgroundView];
}

- (UIView *)backgroundView
{
    return [[self centerV] backgroundView];
}

- (UIScrollView *)scrollView
{
    return [[self centerV] scrollView];
    
    
}

- (void)setContentViewController:(UIViewController *)contentViewController
{
    if (![self isViewLoaded])
    {
        [self view];
    }
    UIViewController *currentContentViewController = [self contentViewController];
    _contentViewController = contentViewController;
    
    UIView *contentContainerView = [[self centerV] contentContainerView];
    CGAffineTransform currentTransform = [contentContainerView transform];
    [contentContainerView setTransform:CGAffineTransformIdentity];

    [self replaceController:currentContentViewController
              newController:[self contentViewController]
                  container:[[self centerV] contentContainerView]];
    
    [contentContainerView setTransform:currentTransform];
    [[self centerV] setNeedsLayout];
}


- (void)setLeftViewController:(UIViewController *)leftViewController
{
    if (![self isViewLoaded])
    {
        [self view];
    }
    UIViewController *currentLeftViewController = [self leftViewController];
    _leftViewController = leftViewController;
    [self replaceController:currentLeftViewController
              newController:[self leftViewController]
                  container:[[self centerV] leftContainerView]];
}

#pragma mark - Instance Methods

- (void)contentContainerButtonPressed:(id)sender
{
    [self hideLeftViewController:YES];
}

- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController container:(UIView *)container
{
    if (newController)
    {
        [self addChildViewController:newController];
        [[newController view] setFrame:[container bounds]];
        [newController setWta_centerviewcontroller:self];
        
        if (oldController)
        {
            [self transitionFromViewController:oldController toViewController:newController duration:0.0 options:0 animations:nil completion:^(BOOL finished) {
                
                [newController didMoveToParentViewController:self];
                
                [oldController willMoveToParentViewController:nil];
                [oldController removeFromParentViewController];
                [oldController setWta_centerviewcontroller:nil];
                
            }];
        }
        else
        {
            [container addSubview:[newController view]];
            [newController didMoveToParentViewController:self];
        }
    }
    else
    {
        [[oldController view] removeFromSuperview];
        [oldController willMoveToParentViewController:nil];
        [oldController removeFromParentViewController];
        [oldController setWta_centerviewcontroller:nil];
    }
}

- (void)updateContentContainerButton
{
    CGPoint contentOffset = [[[self centerV] scrollView] contentOffset];
    CGFloat contentOffsetX = contentOffset.x;
    if (contentOffsetX < centerviewcontrollerOriginX)
    {
        [[[self centerV] contentContainerButton] setUserInteractionEnabled:YES];
    }
    else
    {
        [[[self centerV] contentContainerButton] setUserInteractionEnabled:NO];
    }
}

- (void)hideLeftViewController:(BOOL)animated
{
    [self hideLeftViewController:animated completion:nil];
}

- (void)revealLeftViewController:(BOOL)animated
{
    [self revealLeftViewController:animated completion:nil];
}

- (void)hideLeftViewController:(BOOL)animated completion:(void (^)())completion
{
    CGFloat damping = [self isSpringAnimationOn] ? 0.7f : 1.0f;
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:damping initialSpringVelocity:20.0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        
        [[self scrollView] setContentOffset:CGPointMake(centerviewcontrollerOriginX, 0.0f) animated:NO];
        
    } completion:^(BOOL finished) {
        
        [[[self centerV] contentContainerButton] setUserInteractionEnabled:NO];
        if (completion)
        {
            completion();
        }
        
    }];
}

- (void)revealLeftViewController:(BOOL)animated completion:(void (^)())completion
{
    CGFloat damping = [self isSpringAnimationOn] ? 0.7f : 1.0f;
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:damping initialSpringVelocity:20.0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        
        [[self scrollView] setContentOffset:CGPointMake(0.0f, 0.0f) animated:NO];
        
    } completion:^(BOOL finished) {
        
        [[[self centerV] contentContainerButton] setUserInteractionEnabled:YES];
        if (completion)
        {
            completion();
        }
        
    }];
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint contentOffset = [scrollView contentOffset];
    CGFloat contentOffsetX = contentOffset.x;
    static BOOL leftContentViewControllerVisible = NO;
    
    CGFloat contentContainerScale = powf((contentOffsetX + centerviewcontrollerOriginX) / (centerviewcontrollerOriginX * 2.0f), .5f);
    if (isnan(contentContainerScale))
    {
        contentContainerScale = 0.0f;
    }
    
    CGAffineTransform contentContainerViewTransform = CGAffineTransformMakeScale(contentContainerScale, contentContainerScale);
    CGAffineTransform leftContainerViewTransform = CGAffineTransformMakeTranslation(contentOffsetX / 1.5f, 0.0f);
    
    [[[self centerV] contentContainerView] setTransform:contentContainerViewTransform];
    [[[self centerV] leftContainerView] setTransform:leftContainerViewTransform];
    [[[self centerV] leftContainerView] setAlpha:1 - contentOffsetX / centerviewcontrollerOriginX];
    
    if (contentOffsetX >= centerviewcontrollerOriginX)
    {
        [scrollView setContentOffset:CGPointMake(centerviewcontrollerOriginX, 0.0f) animated:NO];
        if (leftContentViewControllerVisible)
        {
            [[self leftViewController] beginAppearanceTransition:NO animated:YES];
            [scrollView setContentOffset:CGPointMake(centerviewcontrollerOriginX, 0.0f) animated:NO];
            [[self leftViewController] endAppearanceTransition];
            leftContentViewControllerVisible = NO;
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }
    else if (contentOffsetX < centerviewcontrollerOriginX && !leftContentViewControllerVisible)
    {
        [[self leftViewController] beginAppearanceTransition:YES animated:YES];
        leftContentViewControllerVisible = YES;
        [[self leftViewController] endAppearanceTransition];
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateContentContainerButton];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self updateContentContainerButton];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGSize contentSize = [scrollView contentSize];
    CGFloat targetContentOffsetX = targetContentOffset->x;
    if (targetContentOffsetX <= (contentSize.width / 2.0f) - centerviewcontrollerOriginX)
    {
        targetContentOffset->x = 0.0f;
    }
    else
    {
        targetContentOffset->x = centerviewcontrollerOriginX;
    }
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    UIViewController *viewController;
    if ([[self scrollView] contentOffset].x < centerviewcontrollerOriginX)
    {
        viewController = [self leftViewController];
    }
    else
    {
        viewController = [self contentViewController];
    }
    return viewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden
{
    UIViewController *viewController;
    if ([[self scrollView] contentOffset].x < centerviewcontrollerOriginX)
    {
        viewController = [self leftViewController];
    }
    else
    {
        viewController = [self contentViewController];
    }
    return viewController;
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
