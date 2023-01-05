//
//  LoginView.swift
//  Bottles
//
//  Created by dev on 2023/01/05.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
//import NaverThirdPartyLogin
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    
    @State private var userName : String = ""
    
    var body: some View {
        // 카카오톡 로그인 버튼
        Button {
            // 카카오톡이 설치되어 있는지 확인하는 함수
            if (UserApi.isKakaoTalkLoginAvailable()) {
                // 카카오톡으로 로그인하는 함수
               UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                       print("찐 계정접근 \(oauthToken)")
//                       print(error)
                   // TODO: 카카오톡으로 로그인 시 user 정보가 잘 들어오는지 확인 필요
                   UserApi.shared.me { User, Error in
                        if let name = User?.kakaoAccount?.profile?.nickname {
                           userName = name
                            print("결과 : \(userName)")
                        }
                   }
                   
                   }
               } else {
                   // 카카오 계정으로 로그인하는 함수
                   UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                       
//                       print("찐 계정접근 \(oauthToken)")
//                       print(error)
                       
                       // 계정으로 로그인 이후, 로그인 된 계정 nickname을 앱으로 받아옴
                       UserApi.shared.me { User, Error in
                            if let name = User?.kakaoAccount?.profile?.nickname {
                               userName = name
                                print("결과 : \(userName)")
                            }
                       }
                   }
                   
               }
        } label: {
            Text("카카오")
        }
        
        Button {
//            if NaverThirdPartyLoginConnection
//                    .getSharedInstance()
//                    .isPossibleToOpenNaverApp() // Naver App이 깔려있는지 확인하는 함수
//                {
////                NaverThirdPartyLoginConnection.getSharedInstance().delegate = viewModel.self
//                    NaverThirdPartyLoginConnection
//                        .getSharedInstance()
//                        .requestThirdPartyLogin()
//                } else { // 네이버 앱 안깔려져 있을때
//                    // Appstore에서 네이버앱 열기
//                    NaverThirdPartyLoginConnection.getSharedInstance().openAppStoreForNaverApp()
//                }
        } label: {
            Text("네이버")
        }
        
        
        
        Button {
            GoogleSignInButton{
                GIDSignIn.sharedInstance.signIn(with: GIDC)
            }
        } label: {
            Text("구글")
        }


    }
}


//class LoginViewModel : NSObject {
//
//}
//
//extension LoginViewModel : UIApplicationDelegate, NaverThirdPartyLoginConnectionDelegate {
//    // 토큰 발급 성공시
//    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
//        print("완료")
//    }
//    // 토큰 갱신시
//    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() { print("완료") }
//    // 로그아웃(토큰 삭제)시
//    func oauth20ConnectionDidFinishDeleteToken() { print("완료") }
//    // Error 발생
//    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) { print("완료") }
//}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
