//
//  MagicMoveTransition.m
//  CATransition
//
//  Created by xuxiwen on 16/6/11.
//  Copyright © 2016年 xuxiwen. All rights reserved.
//

#import "MagicMoveTransition.h"
#import "TableViewCell.h"
#import "ViewController.h"
#import "SecondViewController.h"

@implementation MagicMoveTransition


#pragma mark - 返回动画时间

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6f;
}

#pragma mark - 两个VC过渡动画


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // transitionContext 该参数 可以让我们去访问一些实现对象所必须的对象
    
    
    /**
     
     扩展 UIViewControllerContextTransitioning
     
     */
    
// 1.  - （UIView *）containerView;
    // 转场动画的容器 -> 添加两个控制器 视图内容 （注意添加的前后顺序）
    
    
// 2.  - (UIViewController *)viewControllerForKey:(NSString *)key;
    // 通过该方法拿到过渡的两个VC
    
// 3.  - (CGRect)initialFrameForViewController:(UIViewController *)vc;
//     - (CGRect)finalFrameForViewController:(UIViewController *)vc;
    // 通过这个方法 能够获得前后两个 ViewController 的frame
    
    
    
    /**
     
    现在进行动画的实现
     
     */
    
    
    // 起始VC
    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    // 目的VC
    SecondViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 转场视图容器
    UIView *containerView = [transitionContext containerView];
    
    
    // 我们需要获取CollectionViewCell 上面的视图 进行做动画
    
    
    /**
     扩展
     iOS  UIView 中坐标的转换
     */
    
// - (GPoint)convertPoint:(CGPoint)point toView:(UIView *)view;
    // 将像素Point 由Point所在控制器转换到目标控制器视图View中， 返回在目标视图中的像素值。
 
// - (GPoint)convertPoint:(CGPoint)point fromView:(UIView *)view;
    // 由上面一条相反，获取目标View的像素Point返回到当前控制器View中
    
// - (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
    // 将坐标frame的rect值，由当前所在的目标视图View中， 返回在当前视图中的rect
    
// - (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;
    // 将坐标frame的rect值，由当前所在的目标视图View中， 返回在当前视图中的rect
    
    NSIndexPath *indexPath = [[fromVC.tableView indexPathsForSelectedRows] firstObject];
    fromVC.indexPath = indexPath; // 记录indexPath 返回时使用
    TableViewCell *cell = (TableViewCell *)[fromVC.tableView cellForRowAtIndexPath:indexPath];

    // 对Cell上面的图片 做截图 来实现过渡动画视图
    UIView *screenShot = [cell.pic snapshotViewAfterScreenUpdates:NO];
    screenShot.backgroundColor = [UIColor clearColor];
    screenShot.frame = fromVC.finiRect = [containerView convertRect:cell.pic.frame fromView:cell.pic.superview];
    // fromVC.finiRect 返回时获取cell上的坐标
    
    
    cell.pic.hidden = YES;
    
    
    // 设置第二个控制器的位置和透明度
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0.5;
    toVC.secondPic.hidden = YES;
    
    // 把动画前后的两个ViewController加到容器控制器中
    [containerView addSubview:toVC.view];
    [containerView addSubview:screenShot];

        // 注意添加顺序
    
    // 现在开始做动画
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        // 调用自动布局
        [containerView layoutIfNeeded];

        fromVC.view.alpha = 1.0;
        // 布局坐标
        screenShot.frame = [containerView convertRect:toVC.secondPic.frame toView:toVC.secondPic.superview];
        
    } completion:^(BOOL finished) {
        toVC.secondPic.hidden = NO;
        cell.pic.hidden = NO;
        
        // 动画截图移除View
        [screenShot removeFromSuperview];
        toVC.view.alpha = 1;

        // 动画结束
        
        // 一定不要忘记告诉系统动画结束
        // 执行
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
}];

    
}






@end
