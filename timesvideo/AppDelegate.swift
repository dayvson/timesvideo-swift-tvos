//
//  AppDelegate.swift
//  tv-op-docs
//
//  Created by Dasilva, Maxwell on 10/4/15.
//  Copyright © 2015 maxwell dasilva. All rights reserved.
//

import UIKit
import TVMLKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, TVApplicationControllerDelegate {
    
    var window: UIWindow?
    var appController: TVApplicationController?
    var topShelf:TVTopShelfProvider?
    static let TVBaseURL = "http://192.168.0.107:3000/"
    static let NYTStaticBaseURL = "http://static.nyt.com/"
    static let TVBootURL = "\(AppDelegate.TVBaseURL)js/application.js"
    var deepLink:NSURL?

    func application(app: UIApplication, openURL url: NSURL, options: [String: AnyObject]) -> Bool {
        print("Application launched with URL: \(url)")

        let appContext = self.appController?.context
        appContext?.launchOptions["DEEPLINK"] = url.path
        self.application(app, didFinishLaunchingWithOptions: appContext?.launchOptions)
        return true
    }
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        print("###################")
        print(launchOptions)
        print("###################")
        let appControllerContext = TVApplicationControllerContext()
        
        if let javaScriptURL = NSURL(string: AppDelegate.TVBootURL) {
            appControllerContext.javaScriptApplicationURL = javaScriptURL
        }
        
        
        appControllerContext.launchOptions["BASEURL"] = AppDelegate.TVBaseURL
        appControllerContext.launchOptions["NYTStaticBaseURL"] = AppDelegate.NYTStaticBaseURL
        
        if let options = launchOptions {
            for (kind, value) in options {
                if let kindStr = kind as? String {
                    appControllerContext.launchOptions[kindStr] = value
                }
            }
        }
        
        self.appController = TVApplicationController(context: appControllerContext, window: self.window, delegate: self)
        
        return true
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
    
    
}

