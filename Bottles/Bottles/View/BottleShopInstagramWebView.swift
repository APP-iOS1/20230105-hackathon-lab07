//
//  BottleShopInstagramWebView.swift
//  Bottles
//
//  Created by Jero on 2023/01/05.
//

import SwiftUI
import WebKit

struct BottleShopInstagramWebView: UIViewRepresentable {
    var urlToLoad: String
    
    //ui view 만들기
    func makeUIView(context: Context) -> WKWebView {
        
        //unwrapping
        guard let url = URL(string: self.urlToLoad) else {
            return WKWebView()
        }
        //웹뷰 인스턴스 생성
        let webView = WKWebView()
        
        //웹뷰를 로드한다
        webView.load(URLRequest(url: url))
        return webView
    }
    
    //업데이트 ui view
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<BottleShopInstagramWebView>) {
        
    }
}

struct BottleShopInstagramWebView_Previews: PreviewProvider {
    static var previews: some View {
        BottleShopInstagramWebView(urlToLoad: "https://www.instagram.com")
    }
}
