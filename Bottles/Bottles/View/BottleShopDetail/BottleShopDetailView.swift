//
//  BottleShopDetailView.swift
//  Bottles
//
//  Created by Jero on 2023/01/05.
//

import SwiftUI

struct ShopOperationInfo: Hashable {
    var iconName: String
    var operationTime: String
    var iconContent: String
}

struct BottleShopDetailView: View {
    @EnvironmentObject var itemInfoStore: ItemInfoStore
    let shopInfo: ShopInfo
    
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 200)),
        GridItem(.adaptive(minimum: 200))]
    
    @State private var isShowingSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    AsyncImage(url: URL(string: "https://ldb-phinf.pstatic.net/20210410_158/16180579695185cNKa_JPEG/mJAiVsSp95nvonvlDMLH71Uq.jpeg.jpg")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 400)
                    } placeholder: {
                        ProgressView()
                    }
                    .padding(.bottom, 30)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(shopInfo.shopName)
                            .font(.largeTitle)
                            .bold()
                        // 주소
                        HStack {
                            Image("pin")
                            Text(shopInfo.shopAddress)
                        }
                        
                        // 영업시간: 임의 데이터
                        HStack {
                            Image("clock")
                            Text("영업시간")
                                .foregroundColor(.purple)
                                .bold()
                            Text("18:00 ~ 24:00")
                        }
                        
                        // 전화번호: 임의 데이터
                        HStack {
                            Image("phone")
                            Text("010-1234-5678")
                        }
                        
                        // 인스타그램 주소: 임의 데이터
                        HStack {
                            Image("house")
                            Button {
                                isShowingSheet.toggle()
                            } label: {
                                Text("https://www.instagram.com/middle_bottle/")
                            }
                            .sheet(isPresented: $isShowingSheet) {
                                BottleShopInstagramWebView(urlToLoad: "https://www.instagram.com/middle_bottle/")
                                    .presentationDetents([.medium, .large])
                            }
                            
                        }
                        
                        // 보틀샵 소개
                        HStack(alignment: .top) {
                            Image("list")
                            Text(shopInfo.shopIntroduction)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    
                    Section {
                        HStack {
                            AsyncImage(url: URL(string: "https://myplace-phinf.pstatic.net/20220320_154/1647784529619JP7be_JPEG/upload_bff822e07464876659c23012350d0067.jpg")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                            } placeholder: {
                                ProgressView()
                            }
                            Spacer()
                            Text("미국 나파밸리 인기 레드와인 2종 한정 판매 중!")
                                .font(.headline)
                            Spacer()
                        }
                        .background(.white)
                        .background(
                            Color.gray
                                .opacity(0.4)
                                .shadow(color: Color("BottleShopDetailBGShadowColor"), radius: 6, x: 0, y: 4)
                                .blur(radius: 3, opaque: false)
                        )
                    } header: {
                        Text("공지사항")
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                    
                    Section {
                        LazyVGrid(columns: columns) {
                            ForEach(itemInfoStore.itemInfos ?? [], id: \.self) { item in
                                NavigationLink {
//                                    BottleDetailView(bottle: item)
                                } label: {
                                    BottleShopBottlesCell(itemInfo: item)
                                }
                            }
                        }
                    } header: {
                        Text("Bottles")
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        .task {
            await itemInfoStore.requestItemInfos(shopId: self.shopInfo.id)
        }
    }
}

struct BottleShopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BottleShopDetailView(shopInfo: ShopInfo(shopAddress: "", shopIntroduction: "", shopLocationLatitude: 0.0, shopLocationLontitude: 0.0, shopName: "", shopPhoneNumber: "", shopSNSLink: ""))
    }
}
