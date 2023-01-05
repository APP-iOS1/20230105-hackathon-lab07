//
//  ShopInfo.swift
//  Bottles
//
//  Created by mac on 2023/01/04.
//

import Foundation

// MARK: shop의 정보를 담는 구조체입니다.
/// - Parameter shopAddress: 샵의 도로명 주소를 나타냅니다.
/// - Parameter shopItems: 샵의 아이템입니다.
/// - Parameter shopIntroduction: 사장님이 작성하는 가게의 소개 입니다.
/// - Parameter shopLocation: 샵의 위도와 경도입니다
/// - Parameter shopName: 샵의 이름입니다
/// - Parameter shopNoticeBoard: 샵의 공지사항입니다
/// - Parameter shopPhoneNumber: 샵의 연락처입니다
/// - Parameter shopSNSLink: 샵의 SNS링크입니다.
struct ShopInfo: Codable, Hashable{
    var id: String = UUID().uuidString
    
    var shopAddress: String
    var shopItems: [ItemInfo]
    var shopIntroduction: String
    var shopLocation: Location
    var shopName: String
    var shopNoticeBoard: [ShopPost]
    var shopOpenTimes: [OpenTime]
    var shopPhoneNumber: String
    var shopSNSLink: String
}

// MARK: shop의 위도와 경도를 구조체입니다.
/// - Parameter latitude: 샵의 위도입니다.
/// - Parameter longtitude: 샵의 경도입니다.
struct Location: Codable, Hashable{
    var id: String = UUID().uuidString
    
    var latitude: Double
    var longtitude: Double
}

// MARK: shop의 위도와 경도를 구조체입니다.
/// - Parameter closedTime, openTime: 샵의 개점, 폐점 시간입니다.
/// - Parameter isOpened: 샵이 오늘 여는지에 대한 여부입니다. 기본 값은 true(운영중)입니다
struct OpenTime: Codable, Hashable{
    var id: String = UUID().uuidString
    
    var closedTime: Date
    var openTime: Date
    
    var isOpened: Bool = true
}

// MARK: shop 게시판의 게시글 하나를 표현하는 구조체입니다
/// - Parameter postContents: 게시글의 내용입니다.
/// - Parameter postDate: 게시글의 게시 날짜입니다.
struct ShopPost: Codable, Hashable{
    var id: String = UUID().uuidString
    
    var postContents: String
    var postDate: Date
}

// MARK: shopItem을 나타내는 구조체입니다
/// - Parameter itemDescription: 사장님이 작성한 아이템에 대한 소개 입니다.
/// - Parameter itemImage: 아이템의 이미지입니다. 일단 AsyncImage로 받아주기 위해 String 변수를 이용했습니다.
/// - Parameter itemName: 아이템의 이름입니다
/// - Parameter itemPrice: 아이템의 가격입니다
/// - Parameter itemTags: 아이템의 태그들입니다. 훗날 아이템의 태그를 이용하여 아이템을 검색할 수 있습니다.
/// - Parameter itemSimilar(Deprecated): 이 아이템과 비슷한 아이템들의 고유 id들을 저장한 배열입니다.
struct ItemInfo: Codable, Hashable{
    var id: String = UUID().uuidString
    
    var itemDescription: String
    var itemImage: String
    var itemName: String
    var itemPrice: Int
    var itemTags: [String]
    //var itemSimilar: [String]
}

