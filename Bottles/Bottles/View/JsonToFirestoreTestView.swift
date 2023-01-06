//
//  JsonToFirestoreTestView.swift
//  Bottles
//
//  Created by mac on 2023/01/05.
//

import SwiftUI
import FirebaseFirestore
import Firebase
struct JsonToFirestoreTestView: View {
    @State var temp:[[String:Any]] = [[:]]
    @State var ids:[String]=[]
    @State var jsonResult:[[String:Any]] = [[:]]
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task{
                self.jsonResult = jsonToArray()
                self.ids = await help1()
                //await help2(ids: self.ids, jsonResult: self.jsonResult)
                //await help3(ids: self.ids)
                //await help4()
            }
    }
}

func jsonToArray() -> [[String:Any]]{
    
    
    do {
        
        if let path = Bundle.main.path(forResource: "csvjson", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [[String: Any]]
                //let json = try JSONSerialization.jsonObject(with:csvjson.data(using:.utf8)!, options: []) as! [[String: Any]]
                //database.collection("Test").document().setData(json[i])
                
                return jsonResult
                
                
            }catch {
                // handle error
            }
        }
    } catch  {
        print(error)
        
    }
    return [[:]]
}
//Shop의 id 다 뽑아오는 코드
func help1() async -> [String]{
    let database = Firestore.firestore()
    var ret:[String] = []
    do{
        let snapshot = try await database.collection("Test").getDocuments()
        for document in snapshot.documents{
            ret.append(document.documentID)
        }
    }catch{
        print(error.localizedDescription)
    }
    return ret
}
//shopItem추가하는 코드
func help2(ids: [String], jsonResult:[[String: Any]]) async{
    var idx = 0
    print(ids.count)
    print(jsonResult.count)
    let database = Firestore.firestore()
    do{
        for id in ids.reversed(){
            let nowId = id
            
            for _ in 0..<2{
                if idx < jsonResult.count{
                    try await database.collection("Test").document(nowId).collection("shopItems").document().setData(jsonResult[Int(arc4random()) % jsonResult.count])
                    idx+=1
                    
                }
            }
            
        }
    }
    catch{
        print(error.localizedDescription)
    }
}
//OpenTimes를 만들고 디비에 넣는 함수
func help3(ids: [String]) async{
    let database = Firestore.firestore()
    var openTimes : [OpenTime] = [OpenTime(closedTime: "24:00", openTime: "12:00"),
                                  OpenTime(closedTime: "", openTime: "", isOpened: false),
                                  OpenTime(closedTime: "22:00", openTime: "14:00"),
                                  OpenTime(closedTime: "01:00", openTime: "15:00"),
                                  OpenTime(closedTime: "17:00", openTime: "08:00"),
                                  OpenTime(closedTime: "", openTime: "", isOpened: false),
                                  OpenTime(closedTime: "13:00", openTime: "19:00")]
    do{
        for id in ids{
            let nowId = id
            
            let shuffledOpenTimes = openTimes.shuffled()
            let doc =  database.collection("Test").document(nowId).collection("openTimes").document()
            try await doc.setData(["openingTimes" : [],
                                   "closedTimes" : [],
                                   "isOpenedDatas" : []])
            
            for day in shuffledOpenTimes{
                try await doc.updateData([
                    "openingTimes" : FieldValue.arrayUnion([day.openTime]),
                    "closedTimes" : FieldValue.arrayUnion([day.closedTime]),
                    "isOpenedDatas" : FieldValue.arrayUnion([day.isOpened])
                ])
                /*
                 doc.setData(["openTime" : day.openTime,
                 "closedTime" : day.closedTime,
                 "isOpened" : day.isOpened], merge: true)*/
            }
            
            
        }
    }catch{
        print(error.localizedDescription)
    }
}

//User 데이터베이스에다가
//email이라는 documentID를 가진 애에 대해
//likeShapID, likeBottleID의 콤마로 구분된 값들을 넣어주어야 한다.
//나중에 User가 좋아하는 데이터 불러올 때는 String parsing 해서 갖고 있기.
func help4() async{
    let emailList = ["dksdmssh1212@naver.com", "hyem0127@gmail.com",
                     "shinn.mizzz@gmail.com", "youngddo913@icloud.com", "wkdwhdghks97@gmail.com", "123esd123@naver.com", "hgbs117@gmail.com",
    "l1004ga@gmail.com"]
    let likeList:[String] = ["0U3L4WfYMspBaRlyeOkf,P1lcoZUymU2KgpO1Lo2S",
                    "0U3L4WfYMspBaRlyeOkf,DLNsyZLUqZCHx3mVPo5o",
                    "0U3L4WfYMspBaRlyeOkf,Fizu9UNRxzhyWR61LOd3",
                    "0U3L4WfYMspBaRlyeOkf,P1lcoZUymU2KgpO1Lo2S",
                    "0U3L4WfYMspBaRlyeOkf,UIWHVW9jiyOpg7l5Qa0T",
                    "0U3L4WfYMspBaRlyeOkf,Vq1SZtOkd4kn5ZlvQlGe",
                    "0U3L4WfYMspBaRlyeOkf,dZ7ywer81S4mYEGy2E0v",
    "4Q8NvdwUR3WrjUFB4R9T,BNiYcIR0S5DtqDvkuWA6",
    "4Q8NvdwUR3WrjUFB4R9T,YlGznastBlGLsnKp39dq",
    "4Q8NvdwUR3WrjUFB4R9T,cvtmPojREIbqMxGJGqkj",
    "68jVYbascurnPPaTMmRe,Zqadqnvt70Jb24MqyDBe",
                             "68jVYbascurnPPaTMmRe,hoX6gCql8ckcUiMejfnR","68jVYbascurnPPaTMmRe,OvMg5CH4Z4MLOnF7A9Ii"]
    
    let database = Firestore.firestore()
    do{
        
        for email in emailList{
            let tempLikeList:[String] = Array(likeList.shuffled().prefix(Int(arc4random()) % likeList.count))
            try await
            database.collection("User").document(email).setData(["likeList" : tempLikeList])
        }
        
        
        
    }
    catch{
        print(error)
    }
}
struct JsonToFirestoreTestView_Previews: PreviewProvider {
    static var previews: some View {
        JsonToFirestoreTestView()
    }
}
