//
//  MWViewController1.m
//  MWCustomNavigationBarDemo
//
//  Created by 王魏 on 2019/6/10.
//  Copyright © 2019 wangwei. All rights reserved.
//

#import "MWViewController1.h"

@interface MWViewController1 ()

@end

@implementation MWViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navBar.title = NSStringFromClass([self class]);
    self.navBar.titleColor = [UIColor redColor];
    self.navBar.leftImage = [UIImage imageNamed:@"back"];
    self.navBar.rightImage = [UIImage imageNamed:@"add"];
    self.navBar.rightImageColor = [UIColor blueColor];
    self.navBar.onClickRightAction = ^{
        NSLog(@"你点击了右边的按钮");
    };
    
//    self.navBar.onClickLeftAction = ^{
//        NSLog(@"你点击了左边的按钮");
//        [self.navigationController popViewControllerAnimated:YES];
//    };
    
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
