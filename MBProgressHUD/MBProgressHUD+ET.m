//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+ET.h"

@implementation MBProgressHUD (ET)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view delayTime:(NSTimeInterval) delayTime
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    [hud setLabelFont:[UIFont systemFontOfSize:14]];
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:delayTime];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view delayTime:ET_MESSAGE_SHOW_LONG_TIME];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    NSTimeInterval delayTime = ET_MESSAGE_SHOW_MIDDLE_TIME;
    if (success) {
        NSUInteger len = success.length;
        if (len > ET_MESSAGE_SHOW_LONG_LENGTH) {
            delayTime = ET_MESSAGE_SHOW_LONG_TIME;
        }
        
        if (len < ET_MESSAGE_SHOW_SHORT_LENGTH) {
            delayTime = ET_MESSAGE_SHOW_SHORT_TIME;
        }
    }
    [self show:success icon:nil view:view delayTime:delayTime];
}

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view graceTime:(NSTimeInterval) time{
    if (view == nil) view = [[UIApplication sharedApplication] delegate].window;
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    
    hud.graceTime = time;
    
    //    hud.bezelView.backgroundColor = ETIndicatorBacgroundColor;
    return hud;
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    return [self showMessage:message toView:view graceTime:ET_MESSAGE_SHOW_SHORT_TIME];
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showNotice:(NSString *)notice {
    [self showSuccess:notice toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

@end
