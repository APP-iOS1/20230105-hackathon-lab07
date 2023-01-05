//
//  InputStoreDataView.swift
//  Bottles
//
//  Created by mac on 2023/01/04.
//

import SwiftUI
import FirebaseFirestore
struct InputStoreDataView: View {
    let database = Firestore.firestore().collection("ShopInfo")
    /*
    @State var shopAddress: String
    
    @State var ItemDescription: String
    @State var ItemImage: String
    @State var ItemName: String
    @State var itemPrice: Int
    @State var itemTags: [String]
    
    @State var shopIntroduction: String
    
    @State var shopLatitude: String
    @State var shopLongtitude: String
    
    
    @State var shopName: String
    @State var shopNoticeBoard: [String]
    @State var shopPhoneNumber: String
    @State var shopSNSLink: String
    */
    
    
    var body: some View {
        VStack {
            /*
            VStack{
                
                HStack{
                    TextField("shopAddress 입력란 예)서울 노원구 상계로 9가길 39", text:$shopAddress)
                }
                HStack{
                    TextField("name입력란 예)글로시에 유, Glossier you", text: $name)
                    
                }
                HStack{
                    TextField("type입력란 예)오 드 퍼퓸,O de perfume", text:$type)
                    
                }
                Group{
                    HStack{
                        TextField("perfumer_kr입력란 예)알베르토 모리야스, 크리스티안 뒤슬리에, 해리 프리몬트", text:$perfumer_kr)
                        
                    }
                    HStack{
                        TextField("perfumer_en입력란 예)Alberto Morillas,Christian Dussoulier,Harry Fremont", text:$perfumer_en)
                        
                    }
                }
                HStack{
                    TextField("대표색 입력란  예)red,#FE4A7E", text: $color)
                    
                }
                
                TextField("imageUrl을 입력해주세요", text: $imageUrl)
                
                VStack{
                    HStack{
                        TextField("재료들을 입력해주세요.(한국어) ", text: $ingredientKr)
                        
                        Button("추가"){
                            ingredientsKr.append(ingredientKr)
                            ingredientKr = ""
                        }
                        
                    }
                    ForEach(self.ingredientsKr, id:\.self){ ing in
                        HStack{
                            Text("\(ing)")
                            Spacer()
                        }
                    }
                }
                
                
                VStack{
                    HStack{
                        TextField("재료들을 입력해주세요.(영어) ", text: $ingredientEn)
                        
                        Button("추가"){
                            ingredientsEn.append(ingredientEn)
                            ingredientEn = ""
                        }
                        
                    }
                    ForEach(self.ingredientsEn, id:\.self){ ing in
                        HStack{
                            Text("\(ing)")
                            Spacer()
                        }
                    }
                }
                TextField("제조 년도를 입력해주세요", text:$releasedYear)
                
                
                
            }
            Button("최종 디비 기입"){
                //위에 있는 값들 넣기 + 코멘트라는 이름을 가진 콜렉션 만들기.(안에 있는 항목들까지)
                addPerfume(id)
            }*/
        }
    }
}

struct InputStoreDataView_Previews: PreviewProvider {
    static var previews: some View {
        InputStoreDataView()
    }
}
