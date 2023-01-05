//
//  UserInfoStore.swift
//  Bottles
//
//  Created by mac on 2023/01/05.
//

import Foundation
import Firebase
import FirebaseFirestore

class UserInfoStore : ObservableObject{
    @Published var userInfo: UserInfo = UserInfo()
    let database = Firestore.firestore()
    var userEmail: String = "dksdmssh1212@naver.com"
    @MainActor
    func requestUserLikes() async{
        userInfo = UserInfo()
        var fetchingResult:[String] = []
        do{
            let likeList = try await database.collection("User").document(userEmail).getDocument().get("likeList") as! [String]
            print("likeList:\(likeList)")
            for like in likeList{
                let arr = like.components(separatedBy: ",")
                print("arr:\(arr)")
                userInfo.userFavoriteBottles.append(LikeItem(shopId: arr[0], itemId: arr[1], likeDate: arr[2].toDate() ?? "1999-12-12".toDate()!))
            }
            print("userInfo:\(userInfo)")
        }catch{
            print(error)
        }
        
    }
}

extension String {
    func toDate() -> Date? { //"yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
