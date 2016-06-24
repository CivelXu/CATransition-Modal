//
//  ViewController.h
//  CATransition-Modal
//
//  Created by xuxiwen on 16/6/12.
//  Copyright © 2016年 xuxiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (assign, nonatomic) CGRect finiRect;
@end

