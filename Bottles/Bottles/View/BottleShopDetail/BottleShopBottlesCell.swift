//
//  BottleShopBottlesCell.swift
//  Bottles
//
//  Created by Jero on 2023/01/05.
//

import SwiftUI

struct BottleShopBottlesCell: View {
    let itemInfo: ItemInfo
    @State private var isSelected: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(
                    url: URL(string: itemInfo.itemImage)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170, height: 150)
                    } placeholder: {
                        Image("ready_image")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170, height: 150)
//                        Rectangle()
//                            .frame(width: 170, height: 150)
//                            .foregroundColor(.gray)
                    }
                    .overlay(
                        Image(systemName: isSelected ? "heart.fill" : "heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.mainColor)
                            .offset(x: 63, y: -55)
                            .onTapGesture {
                                isSelected.toggle()
                            })
            }
            Text(itemInfo.itemName)
                .font(.title3)
                .lineLimit(2)
                .bold()
            Text("\(itemInfo.itemPrice)")
                .font(.subheadline)
                .bold()
        }
        .multilineTextAlignment(.leading)
        .foregroundColor(.black)
    }
}

//struct BottleShopBottlesCell_Previews: PreviewProvider {
//    static var previews: some View {
//        BottleShopBottlesCell(itemInfo: ItemInfo(id: "", itemImage: "", itemName: "", itemPrice: 0, itemML: , itemNation: "", itemProducer: "", itemLocal1: "", itemLocal2: "", itemLocal3: "", itemVarities: "", itemUse: "", itemType: "", itemYear: 0, itemDegree: ""))
//    }
//}
