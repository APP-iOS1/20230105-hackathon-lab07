//
//  BottlesApp.swift
//  Bottles
//
//  Created by mac on 2023/01/04.
//
// 네이버 SDK 다운 : https://github.com/naver/naveridlogin-sdk-ios/tree/4a7e7a842555f936069a86caaa366667e9b117a6 2020년 버전으로 받아야 함(아님 오류남)

import Foundation
import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
//카카오 로그인 SDK
import KakaoSDKCommon
import KakaoSDKAuth
//네이버 로그인 SDK
import NaverThirdPartyLogin
import GoogleSignIn



class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        return GIDSignIn.sharedInstance.handle(url)
//    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
    
}


@main
struct BottlesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    @AppStorage("signIn") var isSignIn = false
    
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

