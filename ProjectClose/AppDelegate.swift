//
//  AppDelegate.swift
//  ProjectClose
//
//  Created by raj on 02/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupRealm()
        printRealmFileUrl()

        let loginViewController = LoginViewController()

        window = UIWindow()
        window?.rootViewController = loginViewController
        window?.makeKeyAndVisible()

        styleTabBarTitleTextAttributes()
        styleNavigationBar()

        return true
    }

    func styleTabBarTitleTextAttributes() {
        UITabBarItem.appearance().setTitleTextAttributes(
                        [
                                NSForegroundColorAttributeName: UIColor(hexString: ProjectCloseColors.allViewControllersTabBarSelectedTitleColor)!,
                                NSFontAttributeName: UIFont(name: ProjectCloseFonts.loginViewControllerLoginButtonTitleFont, size: 14.0)!
                        ], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes(
                        [
                                NSForegroundColorAttributeName: UIColor(hexString: ProjectCloseColors.allViewControllersTabBarUnSelectedTitleColor)!,
                                NSFontAttributeName: UIFont(name: ProjectCloseFonts.allViewControllersTabBarTitleFont, size: 14.0)!
                        ], for: .normal)
    }

    func styleNavigationBar() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(color: UIColor(hexString: ProjectCloseColors.allViewControllersNavigationBarBackgroundColor)!), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage(color: UIColor(hexString: ProjectCloseColors.allViewControllersNavigationBarBackgroundColor)!)

        UINavigationBar.appearance().titleTextAttributes = [
                NSForegroundColorAttributeName: UIColor(hexString: ProjectCloseColors.allViewControllersNavigationBarTitleColor)!,
                NSFontAttributeName: UIFont(name: ProjectCloseFonts.allViewControllersNavigationBarTitleFont, size: 22.0)!
        ]
    }

    func setupRealm() {
        Realm.Configuration.defaultConfiguration = ProjectCloseUtilities.getRealmConfiguration()
    }

    func printRealmFileUrl() {
        print("Realm FileUrl : " + (Realm.Configuration.defaultConfiguration.fileURL?.absoluteString)!)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

