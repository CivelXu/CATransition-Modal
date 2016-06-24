//
//  SecondViewController.m
//  CATransition-Modal
//
//  Created by xuxiwen on 16/6/12.
//  Copyright © 2016年 xuxiwen. All rights reserved.
//

#import "SecondViewController.h"
#import "MagicMoveBackTransition.h"

@interface SecondViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation SecondViewController


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.transitioningDelegate = self;
    
    // 添加屏幕边缘手势
    UIScreenEdgePanGestureRecognizer *edgePagGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgeAction:)];
    edgePagGesture.edges = UIRectEdgeLeft; // 设置什么便捷滑入
    [self.view addGestureRecognizer:edgePagGesture];
    
}

// 实现手势方法

/**
 
 // 添加手势驱动
 
 iOS7 新加入一个类对象 UIPercentDrivenInteractiveTransition ;这个对象会根据我们的手势，来决定我们界面跳转的自定义过渡效果，我们在手势action方法中，对手势驱动状态进行判断，来决定是否过渡动画。
 
 */

- (void)edgeAction:(UIScreenEdgePanGestureRecognizer *)sender
{
    // 计算手指滑动的距离
    
    // 计算手势驱动占屏幕的百分比
    CGFloat distance = [sender translationInView:sender.view].x / self.view.bounds.size.width;
    distance = MIN(1.0, MAX(0.0, distance));
    // 限制百分比 0 - 1 之间
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self dismissViewControllerAnimated:YES completion:Nil];
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        // 手势在慢慢划入 // 把手势的进度告诉 UIPercentDrivenInteractiveTransition
        [self.percentDrivenTransition updateInteractiveTransition:distance];
    }
    else if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled)
    {
        if (distance > 0.5) {
            [self.percentDrivenTransition finishInteractiveTransition];
        }
        else
        {
            [self.percentDrivenTransition cancelInteractiveTransition];
        }
        self.percentDrivenTransition = nil;
    }
}

// 执行手势驱动代理方法



- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    if ([animator isKindOfClass:[MagicMoveBackTransition class]]) {
        return self.percentDrivenTransition;
    }
    else
    {
        return nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    
        MagicMoveBackTransition *transition = [[MagicMoveBackTransition alloc] init];
        return transition;
  
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
