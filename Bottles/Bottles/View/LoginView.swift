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
import NaverThirdPartyLogin
import Alamofire
import FirebaseCore
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn
import GoogleSignInSwift

var manager = LoginManager()
class NaverLoginViewModel : NSObject, UIApplicationDelegate, NaverThirdPartyLoginConnectionDelegate {
    var loginView: LoginView
    init(loginView: LoginView) {
        self.loginView = loginView
    }
    var userName : String?
    var email : String?
    func getUserInfo() {
        guard let tokenType = NaverThirdPartyLoginConnection.getSharedInstance().tokenType else { return }
        guard let accessToken = NaverThirdPartyLoginConnection.getSharedInstance().accessToken else { return }
        let url = "https://openapi.naver.com/v1/nid/me"
        
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: ["Authorization": "\(tokenType) \(accessToken)"]
        ).responseJSON { response in
            guard let result = response.value as? [String: Any] else { return }
            guard let object = result["response"] as? [String: Any] else { return }
            
            guard let name = object["name"] as? String else { return }
            guard let email = object["email"] as? String else { return }
            
            self.userName = name
            self.email = email
            print("username: \(self.userName)")
            print("email: \(self.email)")
            self.loginView.handleFetchDataSuccessOnNaverLogin()
        }
    }
    
    // 토큰 발급 성공시
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        getUserInfo()
    }
    // 토큰 갱신시
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() { }
    // 로그아웃(토큰 삭제)시
    func oauth20ConnectionDidFinishDeleteToken() { }
    // Error 발생
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) { }
}

struct LoginView: View {
    
    @EnvironmentObject var authStore : AuthStore
    
    @State private var userName : String = ""
    @State private var userEmail : String = ""
    @State private var userCheck : Bool = false
    @State private var presentRegisterSheet : Bool = false
    @State private var naverLoginModel : NaverLoginViewModel?
    
    //네이버 로그인 성공 시
    func handleFetchDataSuccessOnNaverLogin() {
        print("네이버로부터 받아온 userName: \(naverLoginModel!.userName!)")
        
        print("네이버로부터 받아온 email: \(naverLoginModel!.email!)")
        
        userName = naverLoginModel!.userName!
        userEmail = naverLoginModel!.email!
        
        Task{
            //Firebase User 컬렉션에 도큐먼트(email)이 있는지 확인
            userCheck = await authStore.checkAccountAndLogin(email: userEmail)
            print("체크 결과 \(userCheck)")
            
            if userCheck == true {
                // TODO: 이미 회원가입 된 유저 -> 홈 화면으로 넘겨줘야합
                authStore.page = "Page2"
            } else {
                // 회원가입 시도
                presentRegisterSheet = true
                print("결과2 : \(presentRegisterSheet)")
            }
        }
    }
    
    var body: some View {
        
        
        VStack {
            Spacer()
            Image("bottlesLogo")
                .resizable()
                .frame(width: 280, height: 63)
            Spacer()
            Text("소셜 회원가입 및 로그인")
                .padding(.bottom, 20)
            
            
            
            HStack{
                
                //네이버 로그인 버튼
                Button {
                    if naverLoginModel == nil {
                        naverLoginModel = NaverLoginViewModel(loginView: self)
                    }
                    // 네이버 앱으로 로그인 허용
                    NaverThirdPartyLoginConnection.getSharedInstance()?.isNaverAppOauthEnable = true
                    // 브라우저 로그인 허용
                    NaverThirdPartyLoginConnection.getSharedInstance()?.isInAppOauthEnable = true
                    
                    // 네이버 로그인 세로모드 고정
                    NaverThirdPartyLoginConnection.getSharedInstance().setOnlyPortraitSupportInIphone(true)
                    
                    // NaverThirdPartyConstantsForApp.h에 선언한 상수 등록
                    NaverThirdPartyLoginConnection.getSharedInstance().serviceUrlScheme = kServiceAppUrlScheme
                    NaverThirdPartyLoginConnection.getSharedInstance().consumerKey = kConsumerKey
                    NaverThirdPartyLoginConnection.getSharedInstance().consumerSecret = kConsumerSecret
                    NaverThirdPartyLoginConnection.getSharedInstance().appName = kServiceAppName
                    NaverThirdPartyLoginConnection.getSharedInstance().resetToken()
                    NaverThirdPartyLoginConnection.getSharedInstance().requestDeleteToken()
                    NaverThirdPartyLoginConnection.getSharedInstance().delegate = naverLoginModel.self
                    NaverThirdPartyLoginConnection
                        .getSharedInstance()
                        .requestThirdPartyLogin()
                } label: {
                    Image("naverLogo")
                        .resizable()
                        .frame(width: 50, height: 50)
                }.onOpenURL { url in
                    // 브라우저에서 나온 직후, 네이버 로그인하기 위해 브라우저를 연 것이라면 토큰 발급 요청
                    // Token 발급 요청
                    NaverThirdPartyLoginConnection
                        .getSharedInstance()
                        .receiveAccessToken(url)
                }
                .padding(.trailing, 5)
                
                //카카오 버튼
                Button {
                    // 카카오톡이 설치되어 있는지 확인하는 함수
                    if (UserApi.isKakaoTalkLoginAvailable()) {
                        // 카카오톡으로 로그인하는 함수
                        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                            // TODO: 카카오톡으로 로그인 시 user 정보가 잘 들어오는지 확인 필요
                            UserApi.shared.me { User, Error in
                                if let name = User?.kakaoAccount?.profile?.nickname {
                                    userName = name
                                    print("결과1 : \(userName)")
                                }
                                if let email = User?.kakaoAccount?.email {
                                    userEmail = email
                                    print("카카오 이메일 : \(userEmail)")
                                }
                                
                                Task{
                                    //Firebase User 컬렉션에 도큐먼트(email)이 있는지 확인
                                    userCheck = await authStore.checkAccountAndLogin(email: userEmail)
                                    print("체크 결과 \(userCheck)")
                                    
                                    if userCheck == true {
                                        // TODO: 이미 회원가입 된 유저 -> 홈 화면으로 넘겨줘야합
                                        authStore.page = "Page2"
                                    } else {
                                        // 회원가입 시도
                                        presentRegisterSheet = true
                                        print("결과2 : \(presentRegisterSheet)")
                                    }
                                }
                                
                                
                            }
                            
                        }
                    } else {
                        // 카카오 계정으로 로그인하는 함수
                        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                            print("찐 계정접근 \(oauthToken)")
                            // 계정으로 로그인 이후, 로그인 된 계정 nickname을 앱으로 받아옴
                            UserApi.shared.me { User, Error in
                                if let name = User?.kakaoAccount?.profile?.nickname {
                                    userName = name
                                    print("결과1 : \(userName)")
                                }
                                if let email = User?.kakaoAccount?.email {
                                    userEmail = email
                                    print("카카오 이메일 : \(userEmail)")
                                }
                                
                                Task{
                                    //Firebase User 컬렉션에 도큐먼트(email)이 있는지 확인
                                    userCheck = await authStore.checkAccountAndLogin(email: userEmail)
                                    print("체크 결과 \(userCheck)")
                                    
                                    if userCheck == true {
                                        // TODO: 이미 회원가입 된 유저 -> 홈 화면으로 넘겨줘야합
                                        authStore.page = "Page2"
                                        
                                    } else {
                                        // 회원가입 시도
                                        presentRegisterSheet = true
                                        print("결과2 : \(presentRegisterSheet)")
                                    }
                                }
                            }
                        }
                        
                    }
                } label: {
                    Image("kakaoLogo")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                .padding(.trailing, 5)
                
                //페이스북 버튼
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
                                userName = profileData["name"] as! String // 이름
                                //                                userId = profileData["id"] as! String // id
                                userEmail = profileData["email"] as! String
                                
                                print("페북결과 \(userName)")
                                print("페북결과 \(userEmail)")
                                
                                Task{
                                    //Firebase User 컬렉션에 도큐먼트(email)이 있는지 확인
                                    userCheck = await authStore.checkAccountAndLogin(email: userEmail)
                                    
                                    print("체크 결과 \(userCheck)")
                                    
                                    if userCheck == true {
                                        // TODO: 이미 회원가입 된 유저 -> 홈 화면으로 넘겨줘야합
                                        authStore.page = "Page2"
                                    } else {
                                        // 회원가입 시도
                                        presentRegisterSheet = true
                                        print("결과2 : \(presentRegisterSheet)")
                                    }
                                }
                                
                                
                            }
                        }
                    }
                } label: {
                    Image("facebookLogo")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                .padding(.trailing, 5)
                
//                Button(action: {
//                    LoginManager.init().logOut()
//                    let isTokenExist = AccessToken.current?.tokenString != nil
//                    let isTokenValid = !(AccessToken.current?.isExpired ?? true)
//                    print(isTokenExist)
//                    print(isTokenValid)
//
//                }) {
//                    Text("페이스북 로그아웃")
//                }
                
                
                //구글 버튼
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
                        
                        var name = user?.profile?.name
                        var userid = user?.userID
                        print("구글결과 \(name)")
                        print("구글결과 \(userid)")
                        
                        var email = user?.profile?.email
                        print("구글결과 \(email)")
                        print("구글 결과 \(user?.profile)")
                        
                        guard
                            let authentication = user?.authentication,
                            let idToken = authentication.idToken
                        else {
                            return
                        }
                        
                        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                       accessToken: authentication.accessToken)
                        
                        if let userName = name, let userEmail = email {
                            self.userName = userName
                            self.userEmail = userEmail
                            Task{
                                //Firebase User 컬렉션에 도큐먼트(email)이 있는지 확인
                                userCheck = await authStore.checkAccountAndLogin(email: userEmail)
                                print("체크 결과 \(userCheck)")
                            }
                            if userCheck == true {
                                // TODO: 이미 회원가입 된 유저 -> 홈 화면으로 넘겨줘야합
                                authStore.page = "Page2"
                            } else {
                                // 회원가입 시도
                                presentRegisterSheet = true
                                print("결과2 : \(presentRegisterSheet)")
                            }
                        }
                        
                    }
                } label: {
                    Image("googleLogo")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .overlay { // <-
                            Circle().stroke(.gray, lineWidth: 2)
                        }
                }
                .padding(.trailing, 5)
                
                Button {
                    //
                } label: {
                    Image("appleLogo")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                
                
            }
            Spacer()
        }
        .fullScreenCover(isPresented: $presentRegisterSheet) {
            RegisterView(userEmail : $userEmail, userName: $userName)
        }
    }
    
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthStore())
    }
}

//구글 로그인을 위한 rootViewController 정의
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
