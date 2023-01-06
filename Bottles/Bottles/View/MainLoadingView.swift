//
//  MyMapView.swift
//  Bottles
//
//  Created by Jero on 2023/01/05.
//

import SwiftUI

struct MainLoadingView: View {
    @State private var isActive = false
    @State private var isloading = true
    var body: some View {
        if isActive {
            RouteView()
            //            ContentView()
        } else {
            if isloading {
                ZStack {
                    Image("bottlesLogo").transition(.opacity).zIndex(1)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation {
                            self.isActive = true
                            self.isloading.toggle()
                        }
                    }
                }
            }
        }
    }
}

struct MainLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        MainLoadingView()
    }
}
