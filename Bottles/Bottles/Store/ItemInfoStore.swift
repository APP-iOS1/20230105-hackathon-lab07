//
//  ItemInfoStore.swift
//  Bottles
//
//  Created by mac on 2023/01/05.
//

import Foundation
import Firebase
import FirebaseFirestore
class ItemInfoStore: ObservableObject{
    @Published var itemInfos: [ItemInfo]?
    
    let database = Firestore.firestore()
    
    @MainActor
    func requestItemInfos(shopId: String) async{
        var fetchingResult:[ItemInfo] = []
        do{
            let documents = try await
            database.collection("Test")
                .document(shopId).collection("shopItems").getDocuments()
            for document in documents.documents{
                fetchingResult.append(ItemInfo(id: document.documentID, itemImage: document["imageLink"] as! String, itemName: document["name"] as! String, itemPrice: document["price"] as! Int, itemML: document["ml"] as! Int, itemNation: document["nation"] as! String, itemProducer: document["producer"] as! String, itemLocal1: document["local1"] as! String, itemLocal2: document["local2"] as! String, itemLocal3: document["local3"] as! String, itemVarities: document["varieties1"] as! String, itemUse: document["use"] as! String, itemType: document["type"] as! String, itemYear: document["year"] as? Int ?? , itemAbv: document["abv"] as? String ?? "", itemDegree: document["degree"] as? String ?? ""))
            }
            self.itemInfos = fetchingResult
            
        }catch{
            print(error.localizedDescription)
            
        }
    }
    
}
