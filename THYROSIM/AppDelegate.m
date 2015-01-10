//
//  AppDelegate.m
//  THYROSIM
//
//  Created by William Gu on 10/11/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "AppDelegate.h"
#import "QuickStartViewController.h"
#import "PageOneViewController.h"
#import "PageTwoViewController.h"
#import "RunSimulationViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    QuickStartViewController *quickStart =[[QuickStartViewController alloc] init];
    PageOneViewController *pageOne = [[PageOneViewController alloc] init];
    PageTwoViewController *pageTwo = [[PageTwoViewController alloc] init];
    RunSimulationViewController *runSimulation = [[RunSimulationViewController alloc] init];
    
    
    quickStart.title = @"Quick Start";
    pageOne.title = @"Step 1";
    pageTwo.title = @"Step 2";
    runSimulation.title = @"Simulation";
    
    //TODO: Add tab bar images
//    quickStart.tabBarItem.image = [UIImage imageNamed:@"..."];
    
    
    _tabBarController = [[UITabBarController alloc] init];
    _tabBarController.viewControllers = [NSArray arrayWithObjects:quickStart, pageOne, pageTwo, runSimulation, nil];
    
    self.window.rootViewController = _tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    application.applicationSupportsShakeToEdit = YES; //???: Shake to refresh map?
    //    [CLLocationManager authorizationStatus];
    //    [CLLocationManager locationServicesEnabled];
    //    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    //    [locationManager requestAlwaysAuthorization];
    
    _dataObject =  [[DataWrapper alloc] init];
    
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
