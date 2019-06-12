//
//  MWViewController3.m
//  MWCustomNavigationBarDemo
//
//  Created by 王魏 on 2019/6/10.
//  Copyright © 2019 wangwei. All rights reserved.
//

#import "MWViewController3.h"

@interface MWViewController3 ()

@end

@implementation MWViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    //隐藏基类的自带的navBar
    self.navBar.hidden = TRUE;
    
    //重新创建导航栏试图
    MWCustomNavigationBar * customNavBar = [MWCustomNavigationBar customNavigationBar];
    customNavBar.title = NSStringFromClass([self class]);
    customNavBar.leftImage = [UIImage imageNamed:@"back"];
    customNavBar.rightImage = [UIImage imageNamed:@"more"];
    customNavBar.barBackgroundColor = [UIColor clearColor];
    [self.view addSubview:customNavBar];

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
