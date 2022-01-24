//
//  AppDelegate.m
//  NASA
//
//  Created by Lalitha Guru Jyothi Nandiraju on 15/01/22.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

//@property (strong, nonatomic) UINavigationController *navController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//        // Override point for customization after application launch.
//    ViewController *frstVwCntlr = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
//        self.navController = [[UINavigationController alloc] initWithRootViewController:frstVwCntlr];
//        [self.window setRootViewController:self.navController];
//        self.window.backgroundColor = [UIColor whiteColor];
//        [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
