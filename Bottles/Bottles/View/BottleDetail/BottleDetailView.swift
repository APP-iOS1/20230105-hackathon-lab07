//
//  BottleDetailView.swift
//  Bottles
//
//  Created by  장종환 on 2023/01/05.
//

import SwiftUI

struct BottleDetailView: View {
    
    @EnvironmentObject var itemInfoStore: ItemInfoStore
    @State var isSelected: Bool = false
    var bottle: ItemInfo
    
    var body: some View {
        ScrollView {
            VStack {
                
                // 상품 이미지
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
                
                // 상품 이름, 가격, 정보
                VStack(alignment: .leading, spacing: 10) {
                    Text(bottle.itemName)
                        .font(.title2)
                        .frame(alignment: .leading)
                        .bold()
                    
                    HStack {
                        Spacer()
                        Text("₩ \(bottle.itemPrice)")
                            .font(.system(size: 18))
                            .frame(alignment: .trailing)
                    }
                }
                
                Divider()
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                
                // 상품 소개
                VStack(alignment: .leading, spacing: 15) {
                    Text("Information")
                        .font(.title3)
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
                        Text(bottle.itemAbv == "" ? "12.5" : bottle.itemAbv)
                    }
                    HStack {
                        Text("음용온도")
                        Divider()
                        Text("\(bottle.itemDegree == "" ? "9~11" : bottle.itemDegree)°C")
                    }
                    HStack {
                        Text("용량")
                        Divider()
                        Text("\(bottle.itemML)mL")
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
                VStack(alignment: .leading, spacing: 15) {
                    Text("Tasting Notes")
                        .font(.title3)
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
        .task {
            await itemInfoStore.requestItemInfos(shopId: bottle.id)
        }
    }
}


struct BottleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BottleDetailView(bottle: ItemInfo(id: "123123", itemImage: "https://seoulwine.net/data/2022/07/28/20220728190640.jpg", itemName: "Meo Camuzet, Charmes Chambertin", itemPrice: 1742000, itemML: 750, itemNation: "프랑스 France", itemProducer: "도멘 메오 까뮈제 Domaine Meo Camuzet", itemLocal1: "부르고뉴 Bourgogne", itemLocal2: "꼬뜨 드 뉘 Cote de Nuits", itemLocal3: "쥬브레-샹베르땅 Gevrey-Chambertin", itemVarities: "Cabernet Sauvignon, Malbec, Petit Verdot,", itemUse: "Table", itemType: "Red", itemYear: 2002, itemAbv: "14~15", itemDegree: "16~18")).environmentObject(ItemInfoStore())
    }
}
