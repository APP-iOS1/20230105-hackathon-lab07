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

struct LoginView: View {
    var body: some View {
        Button {
            if (UserApi.isKakaoTalkLoginAvailable()) {
               UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                       print(oauthToken)
                       print(error)
                   }
               } else {
                   UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                       print(oauthToken)
                   print(error)
                   }
               }
        } label: {
            Text("카카오로그인")
        }

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
