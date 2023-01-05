//
//  BottlesApp.swift
//  Bottles
//
//  Created by mac on 2023/01/04.
//
    				
import SwiftUI
import FirebaseCore
//카카오 로그인 SDK
import KakaoSDKCommon
import KakaoSDKAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
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
            ContentView()
        }
    }
}
