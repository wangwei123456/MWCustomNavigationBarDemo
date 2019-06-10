//
//  MWNavigationBar.m
//  MWCustomNavigationBarDemo
//
//  Created by 王魏 on 2019/6/10.
//  Copyright © 2019 wangwei. All rights reserved.
//

#import "MWNavigationBar.h"

@implementation MWNavigationBar

// for Support iOS 11
- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (UIView *view in self.subviews) {
        
        if([NSStringFromClass([view class]) containsString:@"UIBarBackground"]) {
            view.frame = self.bounds;
        } else if ([NSStringFromClass([view class]) containsString:@"UINavigationBarContentView"]) {
            //UINavigationBarContentView的高度
            CGFloat navigationBarContentViewHeight = view.bounds.size.height;
            //需要偏移的高度
            CGFloat topoffset = self.bounds.size.height - navigationBarContentViewHeight;
            CGRect frame = view.frame;
            frame.origin.y = topoffset;
            view.frame = frame;
            
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
