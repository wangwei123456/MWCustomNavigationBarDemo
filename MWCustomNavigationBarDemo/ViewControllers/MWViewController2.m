//
//  MWViewController2.m
//  MWCustomNavigationBarDemo
//
//  Created by 王魏 on 2019/6/10.
//  Copyright © 2019 wangwei. All rights reserved.
//

#import "MWViewController2.h"

@interface MWViewController2 ()

@end

@implementation MWViewController2

- (void)doRightAction{
    NSLog(@"done");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.barBackgroundColor = [UIColor blueColor];
    self.navBar.title = NSStringFromClass([self class]);
    self.navBar.leftImage = [UIImage imageNamed:@"back"];
    self.navBar.rightText = @"完成";
//    self.navBar.rightItemTintColor = [UIColor redColor];
    self.navBar.delegate = self;
    
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
