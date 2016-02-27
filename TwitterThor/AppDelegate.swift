//
//  AppDelegate.swift
//  TwitterThor
//
//  Created by Paul Thormahlen on 2/15/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard = UIStoryboard(name: "Main", bundle: nil)


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
         //Override point for customization after application launch.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout", name: userDidLogoutnNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userLogin", name: userDidLogInNotification, object: nil)
        print("didFinishLaunchingWithOptions!")
        userLogin()
        return true
    }
    
    func userDidLogout(){
        let vc = storyboard.instantiateInitialViewController()! as UIViewController
        window?.rootViewController = vc

    }
    
    func userLogin(){
        if User.currentUser != nil{
            // go to the logged in screen
            print("current user detected")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let hambugerViewController = storyboard.instantiateViewControllerWithIdentifier("HambergerViewController") as! HambergerViewController
            window?.rootViewController = hambugerViewController
            //let hambugerViewController = window!.rootViewController as! HambergerViewController
            let menuViewController = storyboard.instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
            
            menuViewController.hamburgerViewController = hambugerViewController
            hambugerViewController.menuViewController = menuViewController
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        if(TwitterClient.isURLOAuthCallbackURL(url)){
            TwitterClient.openURL(url)
        }
        return true
        
    }


}

