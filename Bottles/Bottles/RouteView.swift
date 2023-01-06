//
//  RouteView.swift
//  Bottles
//
//  Created by dev on 2023/01/06.
//

import SwiftUI

struct RouteView: View {
    
    @EnvironmentObject var authStore : AuthStore
    
    var body: some View {
        VStack {
            if authStore.page == "Page1" {
                LoginView()
            } else if authStore.page == "Page2" {
                ContentView()
            } else {
                LoginView()
            }
        }
    }
}

struct RouteView_Previews: PreviewProvider {
    static var previews: some View {
        RouteView().environmentObject(AuthStore())
    }
}
