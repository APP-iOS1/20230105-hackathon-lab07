//
//  LikeBottleView.swift
//  Bottles
//
//  Created by 강창현 on 2023/01/05.
//

import SwiftUI

struct LikeBottleView: View {
    @EnvironmentObject var userInfoStore: UserInfoStore
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
                    Text("Bottles")
                        .font(.title)
                        .bold()
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
                            ForEach(0..<10) { index in
                                NavigationLink {
//                                    BottleDetailView(bottle: index)
                                } label: {
                                    LikeBottleCell()

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
        }
    }
}

struct LikeBottleView_Previews: PreviewProvider {
    static var previews: some View {
        LikeBottleView()
    }
}
