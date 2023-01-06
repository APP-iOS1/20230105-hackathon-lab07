//
//  UserInfo.swift
//  Bottles
//
//  Created by mac on 2023/01/04.
//

import Foundation

// MARK: User의 정보를 담는 구조체입니다.
/// - Parameter id: hashable 프로토콜을 만족시켜주기 위한 변수입니다
/// - Parameter userBirthDate: 유저의 생일 정보입니다
/// - Parameter userEmail: 유저의 이메일입니다
/// - Parameter userFavoriteBottles: 유저가 선호하는 바틀 리스트입니다. LikeItem 구조체에 들어있는 정보로 Item DB의 실제 Item 항목을 참조할 수 있게 됩니다
/// - Parameter userNickName: 유저의 닉네임입니다
struct UserInfo: Codable, Hashable{
    var id: String = UUID().uuidString // Hashable Protocol 만족시켜주기 위함
    
    var userBirthDate: Date
    var userEmail: String
    var userFavoriteBottles: [LikeItem]
    var userNickName: String
}

// MARK: User가 갖고 있는 좋아하는 Item들의 정보를 담는 구조체입니다.
/// - Parameter id: hashable 프로토콜을 만족시켜주기 위한 변수입니다
/// - Parameter itemId: item의 고유 ID를 참조하기 위한 변수입니다.
/// - Parameter shopId: shop의 고유 ID를 참조하기 위한 변수입니다.
struct LikeItem : Codable, Hashable{
    var id: String = UUID().uuidString // Hashable Protocol 만족시키기 위함
    var shopId: String
    var itemId: String
}


