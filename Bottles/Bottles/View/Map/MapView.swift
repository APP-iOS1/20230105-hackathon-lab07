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
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct MapView: View {
    
    @StateObject private var mapViewModel: MapViewModel = MapViewModel()
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center:
            CLLocationCoordinate2D(
                latitude: 37.559781,
                longitude: 127.076192),
        span: MKCoordinateSpan(
            latitudeDelta: 0.02,
            longitudeDelta: 0.02))
    @State private var isCarousel: Bool = false
//
//    let myAroundShopData: [MyAroundShop] = [
//        MyAroundShop(
//            shopInfo:
//                ShopInfo(
//                    id: "",
//                    shopAddress: "",
//                    shopItems: [
//                        ItemInfo(
//                            id: "",
//
//                            itemImage: "",
//                            itemName: "",
//                            itemPrice: 0,
//                    shopIntroduction: "",
//                    shopLocationLatitude: 37.559781,
//                    shopLocationLontitude: 127.076192,
//                    shopName: "미들",
//                    shopNoticeBoard: [ShopPost(id: "", postContents: "", postDate: Date())],
//                    shopPhoneNumber: "",
//                    shopSNSLink: ""))
//
//    ]
//
//    @State private var shopData: ShopInfo =
//    ShopInfo(
//        id: "",
//        shopAddress: "",
//        shopItems: [
//            ItemInfo(
//                id: "",
//
//                itemImage: "",
//                itemName: "",
//                itemPrice: 0)],
//        shopIntroduction: "",
//        shopLocationLatitude: 37.559781,
//        shopLocationLontitude: 127.076192,
//        shopName: "",
//        shopPhoneNumber: "",
//        shopSNSLink: "")
    
    var body: some View {
        NavigationStack {
            /*
            ZStack {
                Map(coordinateRegion: $mapViewModel.region,
                    showsUserLocation: true, annotationItems: myAroundShopData
                ) { item in
                    MapAnnotation(coordinate: item.coordinate) {
                        VStack {
                            Group {
                                Button {
                                    isCarousel = true
                                    shopData = item.shopInfo
                                } label: {
                                    Image("MapMarker")
                                    //                                    Text(item.shopInfo.shopName)
                                    //                                        .padding()
                                    //                                        .font(.headline)
                                    //                                        .frame(height: 35)
                                    //                                        .background(.white)
                                    //                                        .foregroundColor(.black)
                                    //                                        .cornerRadius(10)
                                    //                                        .border(Color("AroundSearchViewColor"))
                                }
                            }
                        }
                    }
                    
                }
                if isCarousel {
                    NavigationLink {
                        
                    } label: {
                        MapViewCell(shopInfo: shopData)
                    }
                    .position(x: 200, y: 600)
                }
                Button(action:{
                    mapViewModel.checkLocationIsEnbeld()
                }) {
                    Text("내위치로 돌아가기")
                }
                .position(x: 300, y: 520)
            }
        */
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
