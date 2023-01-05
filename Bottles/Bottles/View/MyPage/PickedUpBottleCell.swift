//
//  PickedUpBottleCell.swift
//  Bottles
//
//  Created by BOMBSGIE on 2023/01/05.
//

import SwiftUI

struct PickedUpBottleCell: View {
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://cdn.imweb.me/thumbnail/20210103/27cdbc402d949.jpg")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 130, height: 110)
                    .padding(.vertical, 15)
                    .padding(.bottom, -5)
                
                
            } placeholder: {
                Rectangle()
                    .frame(width: 140, height: 140)
            }
            VStack(alignment: .leading){
                Text("Dom Perignon rose vintage")
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
                    .padding(.top, 10)
                    .padding(.bottom, -6)
                    .padding(.horizontal, 10)
                
                Text("와인앤모어 뱅뱅사거리점")
                    .fontWeight(.medium)
                    .font(.system(size: 12))
                    .padding(.bottom, -6)
                    .padding(.horizontal, 10)
                
                Text("2023.01.02 오후 7:00")
                    .fontWeight(.medium)
                    .font(.system(size: 12))
                    .foregroundColor(.accentColor)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 10)
            }
            .padding()
            .padding(.leading, -20)
            .frame(alignment: .leading)
            
            
        }
        .padding(.horizontal, 5)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(UIColor.systemGray4), lineWidth: 1)
            
            
        }
    }
}

struct PickedUpBottleCell_Previews: PreviewProvider {
    static var previews: some View {
        PickedUpBottleCell()
    }
}
