//
//  ViewController.m
//  CATransition-Modal
//
//  Created by xuxiwen on 16/6/12.
//  Copyright © 2016年 xuxiwen. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "MagicMoveTransition.h"
#import "SecondViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.transitioningDelegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Delegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
        MagicMoveTransition *transition = [[MagicMoveTransition alloc] init];
        return transition;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SecondViewController *secondVc = (SecondViewController *)segue.destinationViewController;
    
    // 注意一定要把目标值 也作为当前 UIViewControllerTransitioningDelegate的代理人
    secondVc.transitioningDelegate = self;
    [super prepareForSegue:segue sender:sender];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
