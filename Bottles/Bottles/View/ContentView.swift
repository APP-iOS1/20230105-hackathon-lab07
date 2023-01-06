//  ContentView.swift
//  Bottles
//
//  Created by mac on 2023/01/04.
//

import SwiftUI

struct ContentView: View {
    @State var isLoading: Bool = true
    @State private var selection: Int = 1
    
    @EnvironmentObject var authStore : AuthStore
    @EnvironmentObject var shopInfoStore: ShopInfoStore
    @EnvironmentObject var userInfoStore: UserInfoStore
    @EnvironmentObject var itemInfoStore: ItemInfoStore
    
    
    
    //@EnvironmentObject userInfoStore: UserInfoStore
    
    
    
    var body: some View {
        TabView(selection: $selection) {
            MapView().tabItem {
                Image(systemName: "map")
            }.tag(1)
            LikeBottleView().tabItem {
                Image(systemName: "heart")
            }.tag(2)
            LookingAroundView().tabItem {
                Image(systemName: "list.bullet")
            }.tag(3)
            FollowBottleShopView().tabItem {
                Image(systemName: "cart")
            }.tag(4)
            MyPageView().tabItem {
                Image(systemName: "person")
            }.tag(5)
        }.task{
            await shopInfoStore.requestShopInfos()
            print("\(authStore.userEmail)")
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ShopInfoStore()).environmentObject(ItemInfoStore())
        
    }
    
    
}

