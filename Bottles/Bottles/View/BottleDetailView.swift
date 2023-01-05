//
//  BottleDetailView.swift
//  Bottles
//
//  Created by  장종환 on 2023/01/05.
//

import SwiftUI

struct ItemInfo1: Codable, Hashable, Identifiable {
    var id: String = UUID().uuidString
    var itemDescription: String
    var itemImage: String
    var itemName: String
    var itemPrice: Int
    var itemTags: [String]
}

struct BottleDetailView: View {
    
    let itemInfo1: [ItemInfo1] = [
        ItemInfo1(itemDescription: "사장님 한마디 하세요..", itemImage: "https://media.discordapp.net/attachments/1013996253283106876/1060431379525017680/036.png", itemName: "맥켈란 1947", itemPrice: 8500000, itemTags: ["1"])
    ]
    
    @State var isSelected: Bool = true
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(itemInfo1) { item in
                    VStack {
                        // 상품 이미지
                        ZStack {
                            AsyncImage(
                                url: URL(string: String(item.itemImage)),
                                content: { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 250, height: 250)
                                        .padding(.bottom, 15)
                                },
                                placeholder: {
                                    ProgressView()
                                }
                            )
                            
                            // 하트 이미지
                            .overlay(
                                Image(systemName: isSelected ? "heart.fill" : "heart")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .offset(x: 160, y: -120)
                                    .foregroundColor(.purple)
                                    .onTapGesture {
                                        isSelected.toggle()
                                    }
                            )
                        }
                        
                        // 상품 이름, 가격, 정보
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Text(item.itemName)
                                    .font(.system(size: 25))
                                
                                Spacer()
                                
                                Text("₩ \(item.itemPrice)")
                                    .font(.system(size: 20))
                            }
                            .bold()
                            
                            Text(item.itemDescription)
                        }
                    }
                }
                
                Divider()
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                
                // 상품 소개
                VStack(alignment: .leading, spacing: 20) {
                    Text("Information")
                        .font(.system(size: 20))
                        .bold()
                    
                    HStack {
                        Text("종류")
                        Divider()
                        Text("버번 위스키")
                    }
                    HStack {
                        Text("용량")
                        Divider()
                        Text("750ml")
                    }
                    HStack {
                        Text("도수")
                        Divider()
                        Text("50%")
                    }
                    HStack {
                        Text("국가")
                        Divider()
                        Text("미국")
                    }
                    HStack {
                        Text("케이스")
                        Divider()
                        Text("없음")
                        Spacer()
                    }
                }
                
                Divider()
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                
                // 상품 tasting notes
                VStack(alignment: .leading, spacing: 20) {
                    Text("Tasting Notes")
                        .font(.system(size: 20))
                        .bold()
                    HStack {
                        Text("Aroma")
                            .frame(width: 50)
                        Text("달콤한 바닐라, 꿀향 토스트")
                    }
                    HStack {
                        Text("Taste")
                            .frame(width: 50)
                        Text("부드러운 꿀과 바닐라, 깊고 우아한 다크 초콜릿향")
                    }
                    HStack {
                        Text("Finish")
                            .frame(width: 50)
                        Text("토스트, 길고 달콤한 피니쉬")
                        
                        Spacer()
                    }
                }
                .padding(.bottom, 20)
                
                // 픽업 예약하기 버튼
                Button {
                    print("버튼 클릭!")
                } label: {
                    Text("픽업 예약하기")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 350, height: 60)
                }
                .background(.purple)
                .cornerRadius(10)
            }
            .padding(20)
        }
    }
}


struct BottleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BottleDetailView()
    }
}
