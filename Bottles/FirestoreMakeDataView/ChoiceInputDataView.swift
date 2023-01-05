//
//  ChoiceInputDataView.swift
//  Bottles
//
//  Created by mac on 2023/01/04.
//

import SwiftUI

struct ChoiceInputDataView: View {
    var body: some View {
        NavigationView{
            List{
                NavigationLink("Input UserData", destination: InputUserDataView())
                NavigationLink("Input StoreData",
                destination: InputStoreDataView())
            }
        }
    }
}

struct ChoiceInputDataView_Previews: PreviewProvider {
    static var previews: some View {
        ChoiceInputDataView()
    }
}
