//
//  BottleDetailView.swift
//  Bottles
//
//  Created by  장종환 on 2023/01/05.
//

import SwiftUI

struct BottleDetailView: View {
    
    @EnvironmentObject var itemInfoStore: ItemInfoStore
    @State var isSelected: Bool = true
    var bottle: ItemInfo
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    // 상품 이미지
                    ZStack {
                        AsyncImage(
                            url: URL(string: String(bottle.itemImage)),
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
                                .foregroundColor(.accentColor)
                                .onTapGesture {
                                    isSelected.toggle()
                                }
                        )
                    }
                    
                    // 상품 이름, 가격, 정보
                    VStack(alignment: .leading, spacing: 17) {
                        HStack{
                            Text(bottle.itemName)
                                .font(.system(size: 22))
                                .frame(alignment: .leading)
                                .bold()
                        }
                        
                        HStack{
                            Spacer()
                            Spacer()
                            Text("₩ \(bottle.itemPrice)")
                                .font(.system(size: 18))
                                .frame(alignment: .trailing)
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
                        Text(bottle.itemType)
                    }
                    
                    HStack {
                        Text("용도")
                        Divider()
                        Text("\(bottle.itemUse)")
                    }
                    
                    HStack {
                        Text("도수")
                        Divider()
                        Text(bottle.itemDegree == "" ? "12.5" : bottle.itemDegree)
                    }
                    
                    HStack {
                        Text("음용온도")
                        Divider()
                        Text("\(bottle.itemDegree == "" ? "9~11" : bottle.itemDegree)°C")
                    }
                    
                    HStack {
                        Text("용량")
                        Divider()
                        Text("\(bottle.itemML)")
                    }
                    
                    HStack {
                        Text("국가")
                        Divider()
                        Text("\(bottle.itemNation)  >  \(bottle.itemLocal1)")
                    }
                    
                    HStack {
                        Text("연도")
                        Divider()
                        Text(String(bottle.itemYear))
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
                        Text("부드러운 꿀과 바닐라, 깊고 우아한 초콜릿향")
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
                .background(Color.accentColor)
                .cornerRadius(10)
            }
            .padding(20)
        }
        .task{
            await itemInfoStore.requestItemInfos(shopId: bottle.id)
        }
    }
}


//struct BottleDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BottleDetailView(bottle: ItemInfo(id: "123123", itemImage: "https://media.discordapp.net/attachments/1013996253283106876/1060431379525017680/036.png", itemName: "123123123123123123123123123123123123", itemPrice: 1, itemML: 1, itemNation: "123123", itemProducer: "12312331", itemLocal1: "123123123", itemLocal2: "", itemLocal3: "123123123", itemVarities: "123123123", itemUse: "123123123", itemType: "123123123", itemYear: 1, itemDegree: "123123123")).environmentObject(ItemInfoStore())
//    }
//}
