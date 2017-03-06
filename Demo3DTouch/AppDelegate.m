//
//  AppDelegate.m
//  Demo3DTouch
//
//  Created by yons on 17/2/3.
//  Copyright © 2017年 yons. All rights reserved.
//

#import "AppDelegate.h"
#import "PeekViewController.h"
#import "DemoViewController.h"

static NSString * const peekType = @"peekType";
static NSString * const demoType = @"demoType";
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)setup3DTouch {
    
    //创建自定义图片的图标
    UIApplicationShortcutIcon *iconType1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"all"];
    // 使用系统自带的图标创建icons
    UIApplicationShortcutIcon *iconType2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePlay];
    
    
    UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc] initWithType:peekType localizedTitle:@"进入Peek" localizedSubtitle:@"自定义图标" icon:iconType1 userInfo:nil];
    
    UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc] initWithType:demoType localizedTitle:@"进入demo页面" localizedSubtitle:@"系统play样式图标" icon:iconType2 userInfo:nil];
    
    NSArray *items = @[item1, item2];
    [UIApplication sharedApplication].shortcutItems = items;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [self setup3DTouch];
    
    return YES;
}
#pragma mark -  通过快捷选项进入app的时候会调用该方法
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    //1.获得shortcutItem的type type就是初始化shortcutItem的时候传入的唯一标识符
    NSString *type = shortcutItem.type;
    //2.可以通过type来判断点击的是哪一个快捷按钮 并进行每个按钮相应的点击事件
    if ([type isEqualToString:peekType]) {
        PeekViewController *peekVc = [[PeekViewController alloc] init];
        [(UINavigationController *)self.window.rootViewController pushViewController:peekVc animated:YES];
    }
    else if ([type isEqualToString:demoType]){
        DemoViewController *demoVc = [[DemoViewController alloc] init];
        [(UINavigationController *)self.window.rootViewController pushViewController:demoVc animated:YES];
        
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
