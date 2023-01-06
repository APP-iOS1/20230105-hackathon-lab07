//
//  MyMapView.swift
//  Bottles
//
//  Created by Jero on 2023/01/05.
//

import SwiftUI

struct MainLoadingView: View {
    @State private var isActive = false
    var body: some View {
        if isActive {
            RouteView()
//            ContentView()
        } else {
            ZStack {
                Image("appLogo")
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.isActive = true
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
