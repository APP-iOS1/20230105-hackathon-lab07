//
//  PickedUpBottleCell.swift
//  Bottles
//
//  Created by BOMBSGIE on 2023/01/05.
//

import SwiftUI

struct PickedUpBottleCell: View {
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://d1e2y5wc27crnp.cloudfront.net/media/smartorder_reservation/product/thumbnail/daaf7fc3-0abb-4aea-9001-c2fa450e2fd5.webp")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 170, height: 170)
                
            } placeholder: {
                Rectangle()
                    .frame(width: 170, height: 170)
            }
            Text("발베니 12년 산")
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 1)
        }
    }
}

struct PickedUpBottleCell_Previews: PreviewProvider {
    static var previews: some View {
        PickedUpBottleCell()
    }
}
