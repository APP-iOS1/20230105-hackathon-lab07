//
//  LookingAroundView.swift
//  Bottles
//
//  Created by 강창현 on 2023/01/05.
//

import SwiftUI

struct LookingAroundView: View {
    var body: some View {
        VStack{
            Image("oakDrum_Image")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("Comming Soon")
                .font(.largeTitle)
                .bold()
                .padding(.top, -50)
        }
    }
}

struct LookingAroundView_Previews: PreviewProvider {
    static var previews: some View {
        LookingAroundView()
    }
}
