//
//  BottlesApp.swift
//  Bottles
//
//  Created by mac on 2023/01/04.
//
// 네이버 SDK 다운 : https://github.com/naver/naveridlogin-sdk-ios/tree/4a7e7a842555f936069a86caaa366667e9b117a6 2020년 버전으로 받아야 함(아님 오류남)

import Foundation
import SwiftUI
import FirebaseCore
//카카오 로그인 SDK
import KakaoSDKCommon
import KakaoSDKAuth
//네이버 로그인 SDK
import NaverThirdPartyLogin



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
        
        //        // Naver SDK Initializing
        //
        //        // 네이버 앱으로 로그인 허용
        //        NaverThirdPartyLoginConnection.getSharedInstance()?.isNaverAppOauthEnable = true
        //        // 브라우저 로그인 허용
        //        NaverThirdPartyLoginConnection.getSharedInstance()?.isInAppOauthEnable = true
        //
        //        // 네이버 로그인 세로모드 고정
        //        NaverThirdPartyLoginConnection.getSharedInstance().setOnlyPortraitSupportInIphone(true)
        //
        //        // NaverThirdPartyConstantsForApp.h에 선언한 상수 등록
        //        NaverThirdPartyLoginConnection.getSharedInstance().serviceUrlScheme = kServiceAppUrlScheme
        //        NaverThirdPartyLoginConnection.getSharedInstance().consumerKey = kConsumerKey
        //        NaverThirdPartyLoginConnection.getSharedInstance().consumerSecret = kConsumerSecret
        //        NaverThirdPartyLoginConnection.getSharedInstance().appName = kServiceAppName
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
            //                .onOpenURL { url in
            //                if (NaverThirdPartyLoginConnection
            //                    .getSharedInstance() != nil)
            ////                        .isNaverThirdPartyLoginAppschemeURL(url)
            //                {
            //                    // Token 발급 요청
            //                    NaverThirdPartyLoginConnection
            //                        .getSharedInstance()
            //                        .receiveAccessToken(url)
            //                }
            //    }
            
        }
    }
}
