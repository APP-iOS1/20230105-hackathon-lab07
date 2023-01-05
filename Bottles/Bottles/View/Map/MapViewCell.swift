//
//  MapViewCell.swift
//  Bottles
//
//  Created by 강창현 on 2023/01/05.
//

import SwiftUI

struct MapViewCell: View {
    var bottleShopInfo: [ShopOperationInfo] = [
        ShopOperationInfo(
            iconName: "pin",
            operationTime: "",
            iconContent: "서울 광진구 면목로7길 25"),
        ShopOperationInfo(
            iconName: "clock",
            operationTime: "영업시간",
            iconContent: "19:00 ~ 24:00"),
        ShopOperationInfo(
            iconName: "phone",
            operationTime: "",
            iconContent: "010-1234-5678"),
        ShopOperationInfo(
            iconName: "house",
            operationTime: "",
            iconContent: "https://www.instagram.com/middle_bottle/"),
        ShopOperationInfo(
            iconName: "list",
            operationTime: "",
            iconContent: "바틀샵 Middle Bottle입니다. 열심히 고른 국내/해외 맥주와 와인을 판매합니다.")
    ]
    var shopInfo: ShopInfo
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 150)
                .foregroundColor(.white)
                .shadow(color: Color("BottleShopDetailBGShadowColor"), radius: 10, x: 0, y: 4)
//                .blur(radius: 3, opaque: false)
                .overlay {
                    HStack {
                        AsyncImage(url: URL(string: "https://myplace-phinf.pstatic.net/20220320_154/1647784529619JP7be_JPEG/upload_bff822e07464876659c23012350d0067.jpg")) { image in
                            image
                                .resizable()
                                .cornerRadius(10)
                                
                                .frame(width: 160, height: 150)
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Rectangle()
                                .frame(width: 160, height: 150)
                                .foregroundColor(.white)
                        }
                        
                        VStack(alignment: .leading){
                            Text("신미지바보")
                                .font(.headline)
                                
                                .multilineTextAlignment(.leading)
                            HStack {
                                Image(bottleShopInfo[0].iconName)
                                Text(bottleShopInfo[0].iconContent)
                            }
                            .font(.footnote)
                            
                            // 영업시간
                            HStack {
                                Image(bottleShopInfo[1].iconName)
                                Text(bottleShopInfo[1].operationTime)
                                    .foregroundColor(.purple)
                                    .bold()
                                Text(bottleShopInfo[1].iconContent)
                                
                            }
                            .font(.footnote)
                            
                            // 전화번호
                            HStack {
                                Image(bottleShopInfo[2].iconName)
                                Text(bottleShopInfo[2].iconContent)
                            }
                            .font(.footnote)
                            
                        }
                        .foregroundColor(.black)
                        Spacer()
                    }
                   
                }
         
        }
    }
}

//struct MapViewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        MapViewCell()
//    }
//}
