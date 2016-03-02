//
//  AppDelegate.swift
//  Tonight
//
//  Created by Marsal on 29/02/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import UIKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        // start gelocator service
        Geolocator.sharedInstance().start()
        // just to desenv...
//        FirebaseApp.sharedInstance().populateFirebase()
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func applicationDidBecomeActive(application: UIApplication)
    {
        FBSDKAppEvents.activateApp();
    }
    
    func applicationWillTerminate(application: UIApplication)
    {
        FBSDKLoginManager().logOut()
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool
    {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
}