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

import FBSDKLoginKit
//import NaverThirdPartyLogin
import GoogleSignIn
import FirebaseCore
import Firebase
import FirebaseAuth
import GoogleSignInSwift

var manager = LoginManager()

struct LoginView: View {
    
    @State private var userName : String = ""
    
//    func handleSignInButton() {
//        guard let presentingVC = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController
//        else {return}
//
//        GIDSignIn.sharedInstance.signIn(
//           with: config, presenting: <#T##UIViewController#>) { user, error in
//                if let error = error {
//                    print(error.localizedDescription)
//                    return
//                  }
//
//
//
//                  guard let authentication = user?.authentication, let idToken = authentication.idToken
//                  else {
//                    return
//                  }
//
//                  let credential = GoogleAuthProvider.credential(withIDToken: idToken,
//                                                                 accessToken: authentication.accessToken)
//                self.showCustomAlertLoading = true
//                Auth.auth().signIn(with: credential) { authResult, error in
//                    guard let user = authResult?.user, error == nil else {
//                        self.signUpResultText = error?.localizedDescription ?? "Error Occured"
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                            self.showCustomAlertLoading = false
//                        })
//                        return}
//                    self.signUpResultText = "\(user.email!)\nSigning Succesfully"
//                    self.isSignUpSucces = true
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//                        self.showCustomAlertLoading = false
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                            self.navigateHome = true
//                        })
//                    })
//                    print("\(user.email!) signed****")
//
//                }
//            }
//    }
    

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
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }

            // Create Google Sign In configuration object.
            let config = GIDConfiguration(clientID: clientID)

            // Start the sign in flow!
            GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()) { user, error in

              if let error = error {
                // ...
                return
              }
            print("유저 \(user)")
                
                var username = user?.profile?.name
                var userid = user?.userID
                print("구글결과 \(username)")
                print("구글결과 \(userid)")
                
              guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
              else {
                return
              }

              let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                             accessToken: authentication.accessToken)

              // ...
            }
        } label: {
            Text("구글")
        }
        Button {
            manager.logIn(permissions: ["public_profile", "email"], from: nil) { (result, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                if !result!.isCancelled {


                    let request = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"])
                    request.start { (_, res, _) in
                        guard let profileData = res as? [String: Any] else { return }
                        let token = profileData["id"]
                        let email = profileData["email"] as! String
                        let name = profileData["name"] as! String
                        print("result: \(token), \(email), \(name)")
                    }
                }
            }
        } label: {
            Text("페이스북 로그인")
        }
        
        Button(action: {
            LoginManager.init().logOut()
            let isTokenExist = AccessToken.current?.tokenString != nil
            let isTokenValid = !(AccessToken.current?.isExpired ?? true)
            print(isTokenExist)
            print(isTokenValid)
            
        }) {
            Text("페이스북 로그아웃")
        }
    }
    
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension View {
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }
}
