//
//  LikeBottleView.swift
//  Bottles
//
//  Created by 강창현 on 2023/01/05.
//

import SwiftUI

struct LikeBottleView: View {
    @EnvironmentObject var userInfoStore: UserInfoStore
    @EnvironmentObject var itemInfoStore: ItemInfoStore
    @State private var searchBarText: String = ""
    @State private var filterType: String = ""
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10, alignment: nil),
        GridItem(.flexible(), spacing: 10, alignment: nil),
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // MARK: - SearchBar
                SearchBar(searchBarText: $searchBarText)
                
                HStack {
                    Text("Favorites")
                        .font(.title)
                        .bold()
//                    Image("appLogo")
//                        .resizable()
//                        .frame(width: 150, height: 50)
                    Spacer()
                    
                    // MARK: - 정렬 Menu
                    Text(filterType)
                    Menu {
                        Button("최신 순", action: {
                            filterType = "최신 순"
                        })
                        Button("낮은 가격 순", action: {
                            filterType = "낮은 가격 순"
                        })
                        Button("높은 가격 순", action: {
                            filterType = "높은 가격 순"
                        })
                    } label: {
                        Image(systemName: "chevron.up.chevron.down")
                            .foregroundColor(.accentColor)
                    }
                }
                .padding(.bottom, -5)
                .padding(.horizontal, 20)
                
                // MARK: - GridView
                ScrollView {
                    LazyVGrid(
                        columns: columns,
                        alignment: .center,
                        spacing: 10,
                        // List의 Section 기능(header 별 sorting)
                        // pinnedViews: [],
                        content: {
                            ForEach(userInfoStore.userInfo.userFavoriteBottles, id:\.self) { favoriteItemInfoPair in
                                NavigationLink {
                                    BottleDetailView(bottle: itemInfoStore.likeItemInfos?.filter{$0.id == favoriteItemInfoPair.itemId}.first ?? ItemInfo(id: "", itemImage: "", itemName: "", itemPrice: 0, itemML: 0, itemNation: "", itemProducer: "", itemLocal1: "", itemLocal2: "", itemLocal3: "", itemVarities: "", itemUse: "", itemType: "", itemYear: 0, itemAbv: "", itemDegree: ""))
                                } label: {
                                    LikeBottleCell(shopId: favoriteItemInfoPair.shopId, itemId: favoriteItemInfoPair.itemId)

                                }
                            }
                        })
                    .padding(.top, 5)
                    .padding(.horizontal, 20)
                }
            }
            .refreshable {
                //
            }
        }.task{
            await userInfoStore.requestUserLikes()
            await itemInfoStore.requestLikeItemInfos(likeInfos: userInfoStore.userInfo.userFavoriteBottles)
            
        }
    }
}

struct LikeBottleView_Previews: PreviewProvider {
    static var previews: some View {
        LikeBottleView()
    }
}
