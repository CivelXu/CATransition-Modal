//
//  MagicMoveBackTransition.m
//  CATransition
//
//  Created by xuxiwen on 16/6/11.
//  Copyright © 2016年 xuxiwen. All rights reserved.
//

#import "MagicMoveBackTransition.h"
#import "ViewController.h"
#import "SecondViewController.h"
#import "TableViewCell.h"

@implementation MagicMoveBackTransition

#pragma mark - 返回动画时间

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6f;
}

#pragma mark - 两个VC过渡动画


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    // 目的VC
    ViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 起始VC
    SecondViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    // 转场视图容器
    UIView *containerView = [transitionContext containerView];
    
    
    UIView *screenShot = [fromVC.secondPic snapshotViewAfterScreenUpdates:NO];
    screenShot.backgroundColor = [UIColor clearColor];
    screenShot.frame = [containerView convertRect:fromVC.secondPic.frame fromView:fromVC.secondPic.superview];
    fromVC.secondPic.hidden = YES;
    
    
    // 初始化第二个Vc
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    TableViewCell *cell = (TableViewCell *)[toVC.tableView cellForRowAtIndexPath:toVC.indexPath];
    cell.pic.hidden = YES;
    
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [containerView addSubview:screenShot];
    
    
    // 发生动画
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromVC.view.alpha = 0;
        screenShot.frame = toVC.finiRect;
        
        
    } completion:^(BOOL finished) {
        
        [screenShot removeFromSuperview];
        fromVC.secondPic.hidden = NO;
        cell.pic.hidden = NO;
        fromVC.view.alpha = 1;

        
        // 结束
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        
    }];
    
    
    
    
    
}
@end
