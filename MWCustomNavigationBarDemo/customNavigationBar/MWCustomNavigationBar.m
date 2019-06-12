//
//  MWCustomNavigationBar.m
//  MWCustomNavigationBarDemo
//
//  Created by 王魏 on 2019/6/10.
//  Copyright © 2019 wangwei. All rights reserved.
//

#import "MWCustomNavigationBar.h"
#import "MWNavigationBar.h"

#define SCREEN_WID [UIScreen mainScreen].bounds.size.width

#define CUSTOM_GRAY_COLOR [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1]

#define SYSTEM_BLUE_COLOR [UIColor colorWithRed:0.0f green:0.48f blue:1.0f alpha:1.0f]

@implementation UIViewController (MWRoute)

- (void)mw_toLastViewController
{
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            if (self.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if(self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

+ (UIViewController*)mw_currentViewController {
    UIViewController* rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [self mw_currentViewControllerFrom:rootViewController];
}

+ (UIViewController*)mw_currentViewControllerFrom:(UIViewController*)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)viewController;
        return [self mw_currentViewControllerFrom:navigationController.viewControllers.lastObject];
    }
    else if([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController *)viewController;
        return [self mw_currentViewControllerFrom:tabBarController.selectedViewController];
    }
    else if (viewController.presentedViewController != nil) {
        return [self mw_currentViewControllerFrom:viewController.presentedViewController];
    }
    else {
        return viewController;
    }
}

@end

@implementation MWCustomNavigationBar


- (void)leftAction:(UITapGestureRecognizer*)tapGr{
    
    if (self.onClickLeftAction) {
        self.onClickLeftAction();
    } else {
        if(_delegate && [_delegate respondsToSelector:@selector(doLeftAction)]) {
            [_delegate doLeftAction];
        } else {
            UIViewController *currentVC = [UIViewController mw_currentViewController];
            [currentVC mw_toLastViewController];
        }
    }
    
}

- (void)rightAction:(UITapGestureRecognizer*)tapGr{
    if (self.onClickRightAction) {
        self.onClickRightAction();
    }
    
    if(_delegate && [_delegate respondsToSelector:@selector(doRightAction)]) {
        [_delegate doRightAction];
    }
}

+ (BOOL)isIPhoneXSeries{
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            return YES;
        }
    }
    return NO;
}
+ (int)navigationBarHeight {
    
    //returns CGRectZero if the status bar is hidden
    //    [[UIApplication sharedApplication] statusBarFrame];
    
    //不能使用statusBarFrame的高度 因为如果被status bar被隐藏了 就获取不到高度了，国产App大部分的启动页广告都会遮挡住status bar
    CGFloat navigationHeight = 44 + 20;
    if ([self isIPhoneXSeries]) {
        navigationHeight = 44 + 44;
    }
    return navigationHeight;
}
+ (instancetype)customNavigationBar{
    
    MWCustomNavigationBar *navigationBar = [[self alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [self navigationBarHeight])];
    return navigationBar;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}
- (void)setupView{
    
    _navBar = [[MWNavigationBar alloc] initWithFrame:CGRectMake(0,0,SCREEN_WID,[MWCustomNavigationBar navigationBarHeight])];
    //设置导航栏默认tintcolor
    _navBar.barTintColor = CUSTOM_GRAY_COLOR;
    //设置导航栏默认标题颜色
    [_navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [_navBar setTintColor:[UIColor whiteColor]];
    _navItem = [[UINavigationItem alloc]init];
    [_navBar pushNavigationItem:_navItem animated:NO];
    [self addSubview:_navBar];
    
}

#pragma mark Setter
- (void)setBarBackgroundColor:(UIColor *)barBackgroundColor{
    _barBackgroundColor = barBackgroundColor;
    
    if (_barBackgroundColor == [UIColor clearColor]) {
        [_navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [_navBar setShadowImage:[UIImage new]];
    }else{
        _navBar.barTintColor = _barBackgroundColor;
    }
}
- (void)setTitle:(NSString *)title{
    _title = title;
    _navItem.title = _title;
}
- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    [_navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
}

- (void)setLeftImage:(UIImage *)leftImage{
    _leftImage = leftImage;
    UIBarButtonItem * navLeftImageBtn = [[UIBarButtonItem alloc]initWithImage:nil landscapeImagePhone:nil style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
    navLeftImageBtn.width = 44;
    navLeftImageBtn.image = _leftImage;
    _navItem.leftBarButtonItem = navLeftImageBtn;
}

- (void)setLeftImageColor:(UIColor *)leftImageColor{
    _leftImageColor = leftImageColor;
    [_navItem.leftBarButtonItem setTintColor:_leftImageColor];

}

- (void)setRightImage:(UIImage *)rightImage{
    _rightImage = rightImage;
    UIBarButtonItem * navRightBtn = [[UIBarButtonItem alloc]initWithImage:nil landscapeImagePhone:nil style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
    navRightBtn.width = 44;
    navRightBtn.image = rightImage;
    _navItem.rightBarButtonItem = navRightBtn;
}

- (void)setRightImageColor:(UIColor *)rightImageColor{
    _rightImageColor = rightImageColor;
    [_navItem.rightBarButtonItem setTintColor:_rightImageColor];
}

- (void)setLeftText:(NSString *)leftText{
    _leftText = leftText;
    UIBarButtonItem *navLeftTextBtn = [[UIBarButtonItem alloc] initWithTitle:_leftText style:UIBarButtonItemStyleDone target:self action:@selector(leftAction:)];
    _navItem.leftBarButtonItem = navLeftTextBtn;
}

- (void)setLeftTextColor:(UIColor *)leftTextColor{
    _leftTextColor = leftTextColor;
    [_navItem.leftBarButtonItem setTintColor:_leftTextColor];
}

- (void)setRightText:(NSString *)rightText{
    _rightText = rightText;
    UIBarButtonItem *navRightBtn = [[UIBarButtonItem alloc] initWithTitle:_rightText style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
    _navItem.rightBarButtonItem = navRightBtn;
}

- (void)setRightTextColor:(UIColor *)rightTextColor{
    _rightTextColor = rightTextColor;
    [_navItem.rightBarButtonItem setTintColor:_rightTextColor];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
