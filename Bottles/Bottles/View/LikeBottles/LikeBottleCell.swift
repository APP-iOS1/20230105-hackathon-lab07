//
//  LikeBottleCell.swift
//  Bottles
//
//  Created by 강창현 on 2023/01/05.
//

import SwiftUI

struct LikeBottleCell: View {
    @EnvironmentObject var itemInfoStore:ItemInfoStore
    @EnvironmentObject var shopInfoStore:ShopInfoStore
    @State private var isLiked: Bool = false
    var shopId: String
    var itemId: String
    @State private var itemInfo: ItemInfo?
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isLiked.toggle()
                } label: {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundColor(.mainColor)
                }
            }
            AsyncImage(
                url: URL(string: itemInfo?.itemImage ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140, height: 150)
                } placeholder: {
                    Image("ready_image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140, height: 150)
                }
            VStack(alignment: .leading, spacing: 5) {
                // 술 이름
                Text(itemInfo?.itemName ?? "")
                    .font(.title3)
                    .lineLimit(2)
                    .bold()
                //바틀샵 상호명
                Text(shopInfoStore.shopInfos.filter{$0.id == shopId}.first?.shopName ?? "")
                    .lineLimit(1)
                    .font(.subheadline)
                // 바틀샵 주소
                Text(shopInfoStore.shopInfos.filter{$0.id == shopId}.first?.shopAddress ?? "")
                    .lineLimit(2)
                    .font(.caption)
                // 술 가격
                Text("₩ \(itemInfo?.itemPrice ?? 170000)")
                    .lineLimit(1)
                    .font(.caption)
                    .bold()
            }
            .multilineTextAlignment(.leading)
            .foregroundColor(.black)
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 1)
            
        }.task{
            itemInfo = await itemInfoStore.requsetItemInfoUsingTwoParam(shopId: shopId, itemId: itemId)
        }
    }
}
