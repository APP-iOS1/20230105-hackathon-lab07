//
//  WaitingPickupCell.swift
//  Bottles
//
//  Created by BOMBSGIE on 2023/01/05.
//

import SwiftUI

struct WaitingPickupCell: View {
    var body: some View {
        ZStack(alignment:.top){
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 340, height: 235)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 3, y: 3)
            VStack{
                AsyncImage(url: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLsl0hsNIXjL0ZmE_BfBtrftwt56--mFxJVQ&usqp=CAU")) { image in
                    image
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: 340, height: 160)
                        .aspectRatio(contentMode: .fit)
                    
                } placeholder: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 340, height: 160)
                }
                VStack{
                    HStack {
                        Text("Middle Bottle")
                            .font(.title3)
                            .fontWeight(.heavy)
                        Spacer()
                        Text("2023-01-05")
                            .bold()
                    }
                    HStack{
                        Text("로얄 살루트")
                            .font(.subheadline)
                        Spacer()
                        Text("18:00~19:00 픽업 예정")
                            .font(.subheadline)
                    }
                }
                .padding(5)
            }
        }
        .padding(30)
    }
}

struct WaitingPickupCell_Previews: PreviewProvider {
    static var previews: some View {
        WaitingPickupCell()
    }
}
