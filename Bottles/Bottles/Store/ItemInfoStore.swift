//
//  ItemInfoStore.swift
//  Bottles
//
//  Created by mac on 2023/01/05.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
class ItemInfoStore: ObservableObject{
    @Published var itemInfos: [ItemInfo]?
    @Published var likeItemInfos: [ItemInfo]?
    let database = Firestore.firestore()
    
    @MainActor
    func requestItemInfos(shopId: String) async{
        var fetchingResult:[ItemInfo] = []
        do{
            let documents = try await
            database.collection("Test")
                .document(shopId).collection("shopItems").getDocuments()
            for document in documents.documents{
                fetchingResult.append(ItemInfo(id: document.documentID, itemImage: document["imageLink"] as! String, itemName: document["name"] as! String, itemPrice: document["price"] as! Int, itemML: document["ml"] as! Int, itemNation: document["nation"] as! String, itemProducer: document["producer"] as! String, itemLocal1: document["local1"] as! String, itemLocal2: document["local2"] as! String, itemLocal3: document["local3"] as! String, itemVarities: document["varieties1"] as! String, itemUse: document["use"] as! String, itemType: document["type"] as! String, itemYear: document["year"] as? Int ?? 0, itemAbv: document["abv"] as? String ?? "", itemDegree: document["degree"] as? String ?? ""))
            }
            self.itemInfos = fetchingResult
            
        }catch{
            print(error.localizedDescription)
            
        }
    }
    
    @MainActor
    func requestLikeItemInfos(likeInfos:[LikeItem]) async{
        var fetchingResult:[ItemInfo] = []
        do{
            for likeItem in likeInfos{
                let nowItem = try await database.collection("Test").document(likeItem.shopId).collection("shopItems").document(likeItem.itemId).getDocument()
                fetchingResult.append(ItemInfo(id: nowItem.documentID, itemImage: nowItem["imageLink"] as! String, itemName: nowItem["name"] as! String, itemPrice: nowItem["price"] as! Int, itemML: nowItem["ml"] as! Int, itemNation: nowItem["nation"] as! String, itemProducer: nowItem["producer"] as! String, itemLocal1: nowItem["local1"] as! String, itemLocal2: nowItem["local2"] as! String, itemLocal3: nowItem["local3"] as! String, itemVarities: nowItem["varieties1"] as! String, itemUse: nowItem["use"] as! String, itemType: nowItem["type"] as! String, itemYear: nowItem["year"] as? Int ?? 0, itemAbv: nowItem["abv"] as? String ?? "", itemDegree: nowItem["degree"] as? String ?? ""))
                
            }
            likeItemInfos = fetchingResult
        }catch{
            print(error)
        }
    }
    
    @MainActor
    func requsetItemInfoUsingTwoParam(shopId:String, itemId: String) async -> ItemInfo{
        do{
            let docRef = try await database.collection("Test").document(shopId).collection("shopItems").document(itemId).getDocument()
            return ItemInfo(id: docRef.documentID, itemImage: docRef.get("name") as! String, itemName: docRef.get("name") as! String, itemPrice: docRef.get("price") as! Int, itemML: docRef.get("ml") as! Int, itemNation: docRef.get("nation") as! String, itemProducer: docRef.get("producer") as! String, itemLocal1: docRef.get("local1") as! String, itemLocal2: docRef.get("local2") as! String, itemLocal3: docRef.get("local3") as! String, itemVarities: docRef.get("varieties1") as! String, itemUse: docRef.get("use") as! String, itemType: docRef.get("type") as! String, itemYear: docRef.get("year") as? Int ?? 0, itemAbv: docRef.get("abv") as? String ?? "", itemDegree: docRef.get("degree") as? String ?? "")
            
        }catch{
            print(error .localizedDescription)
            return ItemInfo(id: "", itemImage: "", itemName: "", itemPrice: 0, itemML: 0, itemNation: "", itemProducer: "", itemLocal1: "", itemLocal2: "", itemLocal3: "", itemVarities: "", itemUse: "", itemType: "", itemYear: 0, itemAbv: "", itemDegree: "")
        }
    }
    
    
}
