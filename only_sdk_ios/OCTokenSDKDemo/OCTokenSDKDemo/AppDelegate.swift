//
//  AppDelegate.swift
//  OCTokenSDKDemo
//
//  Created by zy on 2020/10/14.
//

import UIKit
import OCTokenSDK

var address = "b63185d613c2e3c7acad57431946ceb22cd149fd"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        OCTokenManager.initWithAppScheme("OCTokenSDKDemo", andAppName: "OCTokenSDKDemo", andAppAddress: address)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ViewController()
        self.window?.makeKeyAndVisible()
        return true
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        //回调信息处理
        OCTokenManager.oAuthCallBack(byURL: url.absoluteString) { (status, info) in
            print(url.absoluteString)
            if status == OCTokenAuthorizationStatusSuccess {
                print("\(info)")
            }else{
                
            }
        }
        return true
    }
}

