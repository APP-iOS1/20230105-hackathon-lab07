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
                            .frame(width: 160)
                    } placeholder: {
                        ProgressView()
                    }
                    .overlay(
                        Image(systemName: isSelected ? "heart.fill" : "heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                            .offset(x: 60, y: -60)
                            .onTapGesture {
                                isSelected.toggle()
                            })
            }
            Text(itemInfo.itemName)
                .bold()
            Text("\(itemInfo.itemPrice)")
                .bold()
        }
        .foregroundColor(.black)
    }
}

//struct BottleShopBottlesCell_Previews: PreviewProvider {
//    static var previews: some View {
//        BottleShopBottlesCell(itemInfo: ItemInfo(id: "", itemImage: "", itemName: "", itemPrice: 0, itemML: , itemNation: "", itemProducer: "", itemLocal1: "", itemLocal2: "", itemLocal3: "", itemVarities: "", itemUse: "", itemType: "", itemYear: 0, itemDegree: ""))
//    }
//}
