//
//  AuthStore.swift
//  Bottles
//
//  Created by dev on 2023/01/06.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseCore

class AuthStore : ObservableObject {
    
    let db = Firestore.firestore()
    
    //앱 로그인에 따른 page 변경
    @Published var page = "Page1"
    
    //MARK: FireStore에 관리자 계정으로 등록된 이메일만 로그인하는 메서드
    func checkAccountAndLogin(email : String) async -> Bool {
        
        var userCheckResult : Bool = false
        
        do {
            //FireStore에서 로그인을 시도하는 email과 일치하는 document 탐색
            let document = try await Firestore.firestore().collection("User").whereField("email", isEqualTo: email).getDocuments()
            if document.isEmpty { // 계정이 없는경우
                userCheckResult = false
                print("로그1")
            } else { // 관리자 계정이 있는경우
                userCheckResult = true
                print("로그2")
            }
        } catch {
            userCheckResult = false
            print("로그3")
        }
        print("로그4")
        return userCheckResult
    }
    
    //새로운 계정 생성
    func resistUser(email : String, nickname : String) async -> Bool {
        var resisterCompelate : Bool = false
        
        var input: [String:Any] = [
            "email" : "\(email)",
            "nickname" : "\(nickname)"
        ]
        
        do {
            try await db.collection("User").document("\(email)").setData(input)
            resisterCompelate = true
        } catch {
            print("user 등록이 불가능합니다.")
        }
        
        return resisterCompelate
        
        
    }
    
    
    
    
    
    
    
    
    
}
