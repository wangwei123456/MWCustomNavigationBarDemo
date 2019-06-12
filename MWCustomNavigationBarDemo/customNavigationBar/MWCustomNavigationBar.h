//
//  MWCustomNavigationBar.h
//  MWCustomNavigationBarDemo
//
//  Created by 王魏 on 2019/6/10.
//  Copyright © 2019 wangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MWCustomNavigationBarDelegate <NSObject>
@optional
- (void)doLeftAction;
- (void)doRightAction;
@end

@interface MWCustomNavigationBar : UIView

/**
 你可以完全再次设置navBar或者navItem全部属性方法等
 */
@property(retain, nonatomic) UINavigationBar *navBar;
@property(retain, nonatomic) UINavigationItem *navItem;


@property(weak, nonatomic) id delegate;
/*如果你设置了代理且实现了代理方法 那么如果你再次实现以下block方法 两个都将会执行*/
@property (nonatomic, copy) void(^onClickLeftAction)(void);
@property (nonatomic, copy) void(^onClickRightAction)(void);

/*导航栏颜色 如果设置为clearColor将会透明*/
@property(retain, nonatomic) UIColor  *barBackgroundColor;
@property(retain, nonatomic) NSString *title;
@property(retain, nonatomic) UIColor  *titleColor;

@property(retain, nonatomic) UIImage *leftImage;
@property(retain, nonatomic) UIImage *rightImage;

@property(copy, nonatomic) NSString *leftText;
@property(copy, nonatomic) NSString *rightText;

@property(retain, nonatomic) UIColor *leftItemTintColor;
@property(retain, nonatomic) UIColor *rightItemTintColor;

+ (instancetype)customNavigationBar;

@end

NS_ASSUME_NONNULL_END
