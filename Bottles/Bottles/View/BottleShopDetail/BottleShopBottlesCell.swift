//
//  BottleShopBottlesCell.swift
//  Bottles
//
//  Created by Jero on 2023/01/05.
//

import SwiftUI

struct BottleShopBottlesCell: View {
    @State private var isSelected: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(
                    url: URL(string: "https://myplace-phinf.pstatic.net/20220320_154/1647784529619JP7be_JPEG/upload_bff822e07464876659c23012350d0067.jpg")) { image in
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
                            .foregroundColor(.blue)
                            .offset(x: 60, y: -60)
                            .onTapGesture {
                                isSelected.toggle()
                            }
                    )
            }
            
            Text("멕켈란 1947")
                .bold()
            Text("₩ 8,500,000")
                .bold()
        }
        .foregroundColor(.black)
    }
}

struct BottleShopBottlesCell_Previews: PreviewProvider {
    static var previews: some View {
        BottleShopBottlesCell()
    }
}
