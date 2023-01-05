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
    var bottleShopInfo: [ShopOperationInfo] = [
        ShopOperationInfo(
            iconName: "pin",
            operationTime: "",
            iconContent: "서울 광진구 면목로7길 25"),
        ShopOperationInfo(
            iconName: "clock",
            operationTime: "영업시간",
            iconContent: "19:00 ~ 24:00"),
        ShopOperationInfo(
            iconName: "phone",
            operationTime: "",
            iconContent: "010-1234-5678"),
        ShopOperationInfo(
            iconName: "house",
            operationTime: "",
            iconContent: "https://www.instagram.com/middle_bottle/"),
        ShopOperationInfo(
            iconName: "list",
            operationTime: "",
            iconContent: "바틀샵 Middle Bottle입니다. 열심히 고른 국내/해외 맥주와 와인을 판매합니다.")
    ]
    
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
                        Text("미들보틀")
                            .font(.largeTitle)
                            .bold()
                        
                        // 주소
                        HStack {
                            Image(bottleShopInfo[0].iconName)
                            Text(bottleShopInfo[0].iconContent)
                        }
                        
                        // 영업시간
                        HStack {
                            Image(bottleShopInfo[1].iconName)
                            Text(bottleShopInfo[1].operationTime)
                                .foregroundColor(.purple)
                                .bold()
                            Text(bottleShopInfo[1].iconContent)
                            
                        }
                        
                        // 전화번호
                        HStack {
                            Image(bottleShopInfo[2].iconName)
                            Text(bottleShopInfo[2].iconContent)
                        }
                        
                        // 인스타그램 주소
                        HStack {
                            Image(bottleShopInfo[3].iconName)
                            Button {
                                isShowingSheet.toggle()
                            } label: {
                                Text(bottleShopInfo[3].iconContent)
                            }
                            .sheet(isPresented: $isShowingSheet) {
                                BottleShopInstagramWebView(urlToLoad: bottleShopInfo[3].iconContent)
                                    .presentationDetents([.medium, .large])
                            }
                            
                        }
                        
                        // 보틀샵 소개
                        HStack(alignment: .top) {
                            Image(bottleShopInfo[4].iconName)
                            Text(bottleShopInfo[4].iconContent)
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
                            ForEach(0 ..< 2) { _ in
                                
                                NavigationLink {
                                    //
                                } label: {
                                    BottleShopBottlesCell()
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
//        .edgesIgnoringSafeArea(.top)
    }
}

struct BottleShopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BottleShopDetailView()
    }
}
