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
    
//    @State var mapRegion =
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
    
    // 바틀샵 이름 검색 기능
//    var searchResult: [ShopInfo] {
//        let filteredData = shopInfoStore.shopInfos
//
//        if !mapViewSearchText.isEmpty {
//            return filteredData.filter {
//                $0.shopName.contains(mapViewSearchText)
//            }
//        }
//        return filteredData
//    }
    
    @State var searchResult: [ShopInfo] = []
    
    @State var distancefilter: Bool = false
    
    @State private var mapViewSearchText: String = ""
    var body: some View {
        NavigationStack {
            ZStack {
                
                Map(coordinateRegion: $mapViewModel.region,
                    showsUserLocation: true, annotationItems: $searchResult
                ) { $shopInfo in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: shopInfo.shopLocationLatitude, longitude: shopInfo.shopLocationLontitude)) {
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
                HStack {
                    MapViewSearchBar(mapSearchBarText: $mapViewSearchText, searchResult: $searchResult)
                    Button(action: {
                        searchResult = getSearchResult(searchText: mapViewSearchText)
                    }){
                        Text("검색")
                            .foregroundColor(.white)
                    }
                    .frame(width: 50, height: 40)
                    .background(Color.mainColor)
                    .cornerRadius(10)
                }
                .offset(y: -330)

                    
                    
                
                if isCarousel {
                    NavigationLink {
                        BottleShopDetailView(shopInfo: shopData)
                    } label: {
                        MapViewCell(shopInfo: shopData)
                    }
                    .position(x: 176, y: 620)
                    .padding(.horizontal, 20)
                }
                Button(action:{
                    mapViewModel.region.center = mapViewModel.locationManager?.location?.coordinate ?? MapDetails.startingLocation
//                    mapViewModel.checkLocationIsEnbeld()
//                    mapViewModel.region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
                }) {
                    Image("gps_Image")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .position(x: 354, y: 520)
                
                
                // 내 주변 5km
                Button(action:{
                    distancefilter.toggle()
                    searchResult = getSearchResult(searchText: mapViewSearchText)
                }) {
                    Text("내 주변 5km")
//                    Image("gps_Image")
//                        .resizable()
//                        .frame(width: 40, height: 40)
                }
                .position(x: 354, y: 420)
            }
        }
        .task {
            await shopInfoStore.requestShopInfos()
            searchResult = shopInfoStore.shopInfos
            mapViewModel.checkLocationIsEnbeld()
        }
        
    }
    // 검색 기능
    func getSearchResult(searchText: String) -> [ShopInfo] {
        let filteredData = self.shopInfoStore.shopInfos
        
        if distancefilter {
            if !searchText.isEmpty {
                return filteredData.filter {
                    $0.shopName.contains(searchText) &&
                    $0.shopCoordinates.distance(from: mapViewModel.region.center) < 5000
                }
            } else {
                return filteredData.filter {
                    $0.shopCoordinates.distance(from: mapViewModel.region.center) < 5000
                }
            }
        } else {
            if !searchText.isEmpty {
                return filteredData.filter {
                    $0.shopName.contains(searchText)
                }
            }
        }
        return filteredData
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
