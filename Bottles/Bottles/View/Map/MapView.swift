//
//  MyMapView.swift
//  Bottles
//
//  Created by Jero on 2023/01/05.
//

import SwiftUI
import MapKit

struct MyAroundShop: Identifiable {
    let id = UUID()
    var shopInfo: ShopInfo

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: shopInfo.shopLocationLatitude, longitude: shopInfo.shopLocationLontitude)
    }
}

struct MapView: View {
    
    @StateObject private var mapViewModel: MapViewModel = MapViewModel()
    @State private var isCarousel: Bool = false
    
    @EnvironmentObject var shopInfoStore: ShopInfoStore
    
    let myAroundShopData: [MyAroundShop] = [
        MyAroundShop(
            shopInfo:
                ShopInfo(
                    id: "",
                    shopAddress: "",
//                    shopItems: [
//                        ItemInfo(
//                            id: "",
//
//                            itemImage: "",
//                            itemName: "",
//                            itemPrice: 0,
                    shopIntroduction: "",
                    shopLocationLatitude: 37.559781,
                    shopLocationLontitude: 127.076192,
                    shopName: "미들",
//                    shopNoticeBoard: [ShopPost(id: "", postContents: "", postDate: Date())],
                    shopPhoneNumber: "",
                            shopSNSLink: ""))

    ]

    @State private var shopData: ShopInfo =
    ShopInfo(
        id: "",
        shopAddress: "",
//        shopItems: [
//            ItemInfo(
//                id: "",
//
//                itemImage: "",
//                itemName: "",
//                itemPrice: 0)],
        shopIntroduction: "",
        shopLocationLatitude: 37.559781,
        shopLocationLontitude: 127.076192,
        shopName: "",
        shopPhoneNumber: "",
        shopSNSLink: "")
    
    @State private var mapViewSearchText: String = ""
    var body: some View {
        NavigationStack {
            ZStack {
                
                Map(coordinateRegion: $mapViewModel.region,
                    showsUserLocation: true, annotationItems: shopInfoStore.shopInfos
                ) { shopInfo in
                    MapAnnotation(coordinate: shopInfo.shopCoordinates) {
                        VStack {
                            Group {
                                Button {
                                    isCarousel = true
                                    shopData = shopInfo
                                } label: {
                                    VStack{
                                        Image("MapMarker")
                                        Text(shopInfo.shopName)
                                            .padding()
                                            .font(.headline)
                                            .frame(height: 35)
                                            .background(.white)
                                            .foregroundColor(.black)
                                            .cornerRadius(10)
                                            .border(Color("AroundSearchViewColor"))
                                    }
                                }
                            }
                        }
                    }
                    
                }
                
                SearchBar(searchBarText: $mapViewSearchText)
                    .offset(y: -330)
                
                if isCarousel {
                    NavigationLink {
//                       BottleShopDetailView()
                    } label: {
                        MapViewCell()
                    }
                    .position(x: 176, y: 620)
                    .padding(.horizontal, 20)
                }
                Button(action:{
                    mapViewModel.checkLocationIsEnbeld()
                }) {
                    Image("gps_Image")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .position(x: 354, y: 520)
            }
        }
        .onAppear{
            mapViewModel.checkLocationIsEnbeld()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
