//
//  MapViewSearchBar.swift
//  Bottles
//
//  Created by BOMBSGIE on 2023/01/06.
//

import SwiftUI

struct MapViewSearchBar: View {
    @EnvironmentObject var shopInfoStore: ShopInfoStore
    
    @Binding var mapSearchBarText: String

    @Binding var searchResult: [ShopInfo]
    
    var body: some View {
        HStack {
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(.accentColor)
                .bold()
            TextField("검색어를 입력해주세요", text: $mapSearchBarText)
                .multilineTextAlignment(.center)
            if !mapSearchBarText.isEmpty {
                Button(action: {
                    searchResult = shopInfoStore.shopInfos
                    self.mapSearchBarText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                }
            } else {
                EmptyView()
            }
        }
        .padding(10)
        .frame(width: 290)
        
        .background{
            Color.white
        }
        .cornerRadius(10)
        .shadow(color: Color("BottleShopDetailBGShadowColor"), radius: 3, x: 0, y: 4)
        .padding(.horizontal, 20)
    }
}

//struct MapViewSearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        MapViewSearchBar(mapSearchBarText: .constant(""))
//    }
//}
