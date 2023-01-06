//
//  MyPageView.swift
//  Bottles
//
//  Created by BOMBSGIE on 2023/01/05.
//

import SwiftUI

struct MyPageView: View {
    @EnvironmentObject var userInfo: UserInfo
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10, alignment: nil),
        GridItem(.flexible(), spacing: 10, alignment: nil)
    ]
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack {
                    HStack{
                        Text(userInfo.userNickName)
                            .font(.title)
                        Spacer()
                        NavigationLink(destination: EditUserInfoView()) {
                            Text("회원정보 수정")
                        }
                    }
                    .padding(20)
                    
                    
                    // MARK: - 픽업을 기다리고 있어요
                    
                    VStack(alignment: .leading) {
                        Text("픽업을 기다리고 있어요!")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        if /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/ {
                            TabView {
                                ForEach(1..<4, id: \.self) { _ in
                                    NavigationLink {
                                        //                                    BottleShopDetailView()
                                    } label: {
                                        VStack {
                                            WaitingPickupCell()
                                            Rectangle()
                                                .foregroundColor(.white)
                                                .frame(height: 20)
                                        }
                                    }
                                }
                            }
                            .frame(height: 300)
                            .tabViewStyle(.page)
                            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                            .padding(.top, -15)
                        } else {
                            /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 15)
                    
                    // MARK: - 내가 픽업했던 보틀
                    VStack(alignment:.leading){
                        Text("내가 픽업했던 보틀")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        ForEach(1 ..< 4, id: \.self) { _ in
                            PickedUpBottleCell()
                                .padding(.bottom, 5)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
