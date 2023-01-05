//
//  ContentView.swift
//  Bottles
//
//  Created by mac on 2023/01/04.
//

import SwiftUI

struct ContentView: View {
    @State var isLoading: Bool = true
    @State private var selection: Int = 1
    
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
        }
//        .onAppear {
//            UITabBar.appearance().backgroundColor = .black
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    
    var launchScreenView: some View {
        
        ZStack(alignment: .center) {
            
            LinearGradient(gradient: Gradient(colors: [Color("PrimaryColor"), Color("SubPrimaryColor")]),
                            startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            Image("LaunchScreenImage")
            
        }
        
    }
    
}
