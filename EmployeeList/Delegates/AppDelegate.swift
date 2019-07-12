//
//  AppDelegate.swift
//  EmployeeList
//
//  Created by Qi Zhan on 7/9/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

import UIKit


// TODO:
// 1. Do outdated photos need to be removed from the disk if the user's uphoto has been updated
// 2. Does the photo data need to be cached in memory? Does it need to be evicted by implmenting LRU?
// 3. Do profiles need to be grouped?
// 4. Is the tableview capable of infinitely scrolling?
// 5. Session cache VS disk cache?
// 6. Preload data in table view
// 7. Multithreading, lock for memory cache?
// 8. certainly leverages the largest amount of Apple supported caching. I think with what you're trying to do, you should be able to leverage the NSURLSessionConfiguration and a particular cache policy to accomplish what you're looking to do.


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = EmployeeListTableViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    

}

