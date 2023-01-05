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
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center:
            CLLocationCoordinate2D(
                latitude: 37.559781,
                longitude: 127.076192),
        span: MKCoordinateSpan(
            latitudeDelta: 0.02,
            longitudeDelta: 0.02))
    @State private var isCarousel: Bool = false
    
    let myAroundShopData: [MyAroundShop] = [
        MyAroundShop(
            shopInfo:
                ShopInfo(
                    id: "미들보틀",
                    shopAddress: "서울 광진구 면목로7길 25",
                    shopItems: [
                        ItemInfo(
                            id: "",
                            itemDescription: "",
                            itemImage: "",
                            itemName: "",
                            itemPrice: 0, itemTags: [])],
                    shopIntroduction: "",
                    shopLocation: Location(id: "54612312221", latitude: 37.559781, longtitude: 127.076192),
                    shopName: "미들보틀",
                    shopNoticeBoard: [ShopPost(id: "", postContents: "", postDate: Date())],
                    shopOpenTimes: [OpenTime(id: "", closedTime: Date(), openTime: Date(), isOpened: false)],
                    shopPhoneNumber: "",
                    shopSNSLink: ""),
            latitude: 37.559781,
            longitude: 127.076192)
    ]
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Map(coordinateRegion: $region,
                    annotationItems: myAroundShopData
                ) { item in
                    MapAnnotation(coordinate: item.coordinate) {
                        VStack {
                            Group {
                                Button {
                                    isCarousel = true
                                } label: {
                                    Text(item.shopInfo.shopName)
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
                
                if isCarousel {
                    NavigationLink {
                        
                    } label: {
//                        Rectangle()
                    }
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
