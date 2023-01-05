//
//  ShopInfoStore.swift
//  Bottles
//
//  Created by mac on 2023/01/05.
//

// TODO: item의 id로부터 정보를 가져오는 함수
// 정렬 기준을 바꿔주는 함수

import Foundation
import Firebase
import FirebaseFirestore
class ShopInfoStore: ObservableObject{
    @Published var shopInfos: [ShopInfo] = []
    
    let database = Firestore.firestore()
    
    //shop의 정보들을 다 불러오는 함수
    @MainActor
    func requestShopInfos() async{
        var fetchingResult:[ShopInfo] = []
        do{
            let documents = try await database.collection("Test")
                .getDocuments()
            for document in documents.documents{
                fetchingResult.append(ShopInfo(id: document.documentID, shopAddress: document["shopAddress"] as! String,  shopIntroduction: document["shopIntroduction"] as! String, shopLocationLatitude: document["latitude"] as! Double, shopLocationLontitude: document["longitude"] as! Double, shopName: document["shopName"] as! String, shopPhoneNumber: document["shopPhoneNumber"] as! String, shopSNSLink: document["shopSNSLink"] as! String))
            }
            self.shopInfos = fetchingResult
            print("fetchingResult:\(self.shopInfos)")
        }catch{
            print(error)
        }
    }
    
    
    
}
