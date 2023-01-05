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

 var manager = LoginManager()

struct LoginView: View {
    
    var body: some View {
        Button {
            if (UserApi.isKakaoTalkLoginAvailable()) {
                UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                }
            } else {
                UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    UserApi.shared.me { User, Error in
                        if let name = User?.kakaoAccount?.profile?.nickname {
                            print(name)
                        }
                    }
                }
            }
        } label: {
            Text("카카오로그인")
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
