//
//  leftViewController.m
//  menuProject
//
//  Created by mc on 15/4/15.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "leftViewController.h"

#import "centerViewController.h"
#import "HomeViewController.h"
#import "StatisticalViewController.h"
#import "SettingViewController.h"

NSString * const WTATableCellIdentifier = @"WTATableCellIdentifier";

@interface leftViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *datasource;
@property (nonatomic, assign) BOOL didSelectInitialViewController;
@end

@implementation leftViewController
{
    NSUInteger ssss;
    UINavigationController *navigationController1;
    UINavigationController *navigationController2;
    UINavigationController *navigationController3;

    UINavigationController *navigationController4;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTable];
    ssss=-1;
    _datasource = [[NSMutableArray alloc]init];
    _datasource =@[@"收入", @"支出", @"统计", @"设定"];
    [_tableView reloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)setTable
{
    

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, 320, 300)];
    _tableView.delegate=self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    if (![self didSelectInitialViewController])
    {
        [self setDidSelectInitialViewController:YES];
        [self tableView:[self tableView] didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }

}

#pragma mark - UITableViewDatasource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self datasource] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"widedente";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
        [cell setBackgroundColor:[UIColor clearColor]];
    [[cell textLabel] setTextColor:[UIColor whiteColor]];
    [[cell textLabel] setText:[self datasource][[indexPath row]]];
    [cell setSelectedBackgroundView:[UIView new]];
    [[cell textLabel] setHighlightedTextColor:[UIColor purpleColor]];
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == 0)
    {
        if(ssss == indexPath.row)
        {
            [[self wta_centerviewcontroller] hideLeftViewController:YES];

        }
        else
        {
            ssss = indexPath.row;
            if(!navigationController1)
            {
                HomeViewController* contentViewController = [[HomeViewController alloc]init];
                [[contentViewController navigationItem] setTitle:[self datasource][[indexPath row]]];
                navigationController1 = [[UINavigationController alloc] initWithRootViewController:contentViewController];
            }
            [[self wta_centerviewcontroller] setContentViewController:navigationController1];
            [[self wta_centerviewcontroller] hideLeftViewController:YES];
        }
        

        

    }
    else if(indexPath.row == 1)
    {
        if(ssss == indexPath.row)
        {
            [[self wta_centerviewcontroller] hideLeftViewController:YES];
            
        }
        else
        {
            ssss = indexPath.row;
        if(!navigationController2)
        {
             HomeViewController* contentViewController2 = [[HomeViewController alloc]init];
            [[contentViewController2 navigationItem] setTitle:[self datasource][[indexPath row]]];
            navigationController2 = [[UINavigationController alloc] initWithRootViewController:contentViewController2];
           
        }
        [[self wta_centerviewcontroller] setContentViewController:navigationController2];
        [[self wta_centerviewcontroller] hideLeftViewController:YES];
        }

    }
    else if(indexPath.row == 2)
    {
        if(ssss == indexPath.row)
        {
            [[self wta_centerviewcontroller] hideLeftViewController:YES];
            
        }
        else
        {
            ssss = indexPath.row;
            if(!navigationController3)
            {
                StatisticalViewController* contentViewController3 = [[StatisticalViewController alloc]init];
                [[contentViewController3 navigationItem] setTitle:[self datasource][[indexPath row]]];
                navigationController3 = [[UINavigationController alloc] initWithRootViewController:contentViewController3];
                
            }
            [[self wta_centerviewcontroller] setContentViewController:navigationController3];
            [[self wta_centerviewcontroller] hideLeftViewController:YES];
        }
        
    }
    else if(indexPath.row == 3)
    {
        if(ssss == indexPath.row)
        {
            [[self wta_centerviewcontroller] hideLeftViewController:YES];
            
        }
        else
        {
            ssss = indexPath.row;
            if(!navigationController4)
            {
                SettingViewController* contentViewController4 = [[SettingViewController alloc]init];
                [[contentViewController4 navigationItem] setTitle:[self datasource][[indexPath row]]];
                navigationController4 = [[UINavigationController alloc] initWithRootViewController:contentViewController4];
                
            }
            [[self wta_centerviewcontroller] setContentViewController:navigationController4];
            [[self wta_centerviewcontroller] hideLeftViewController:YES];
        }
        
    }

    
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
