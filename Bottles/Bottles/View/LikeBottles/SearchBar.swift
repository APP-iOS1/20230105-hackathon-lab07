//
//  SearchBar.swift
//  Bottles
//
//  Created by 강창현 on 2023/01/05.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchBarText: String
    
    var body: some View {
        
        // MARK: - SearchBar
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.accentColor)
                .bold()
            TextField("검색어를 입력해주세요", text: $searchBarText)
                .multilineTextAlignment(.center)
            if !searchBarText.isEmpty {
                Button(action: {
                    self.searchBarText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                }
            } else {
                EmptyView()
            }
        }
        .padding(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 1)
        }
        .padding(.horizontal, 20)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchBarText: .constant(""))
    }
}
