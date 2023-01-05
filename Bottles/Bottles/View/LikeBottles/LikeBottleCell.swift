//
//  LikeBottleCell.swift
//  Bottles
//
//  Created by 강창현 on 2023/01/05.
//

import SwiftUI

struct LikeBottleCell: View {
    
    @State private var isLiked: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isLiked.toggle()
                } label: {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundColor(.purple)
                }
            }
            Image("whisky_Image1")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading, spacing: 5) {
                // 술 이름
                Text("발렌타인 파이니스트")
                    .font(.title3)
                    .bold()
                //바틀샵 상호명
                Text("Middle Bottle")
                    .font(.subheadline)
                // 바틀샵 주소
                Text("서울특별시 광진구 면목로7길 25 세광빌딩 1층")
                    .font(.caption)
            }
            .multilineTextAlignment(.leading)
            .foregroundColor(.black)
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 1)
        }
    }
}

struct LikeBottleCell_Previews: PreviewProvider {
    static var previews: some View {
        LikeBottleCell()
    }
}
