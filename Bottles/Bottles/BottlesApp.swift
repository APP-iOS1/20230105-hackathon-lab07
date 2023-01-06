//
//  BottlesApp.swift
//  Bottles
//
//  Created by mac on 2023/01/04.
//
    				
import Foundation
import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
//카카오 로그인 SDK
import KakaoSDKCommon
import KakaoSDKAuth
//페이스북 로그인 SDK
import FBSDKCoreKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            ApplicationDelegate.shared.application(
                application,
                didFinishLaunchingWithOptions: launchOptions
            )
            FirebaseApp.configure()

            return true
        }

        func application( app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            ApplicationDelegate.shared.application(
                app,
                open: url,
                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                annotation: options[UIApplication.OpenURLOptionsKey.annotation]
            )
        }
    
    //구글 로그인을 위한 초기화
}

@main
struct BottlesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
            // Kakao SDK 초기화
            KakaoSDK.initSDK(appKey: "ac25d3be6ae489fcd49a88acc57f8cf4")
        }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
