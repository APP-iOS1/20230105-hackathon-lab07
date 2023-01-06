//
//  EditUserInfoView.swift
//  Bottles
//
//  Created by BOMBSGIE on 2023/01/05.
//

import SwiftUI

struct EditUserInfoView: View {
    @EnvironmentObject var authStore : AuthStore
    @State var changeUserNickname: String = ""
    var body: some View {
        VStack(alignment: .leading){
            Spacer()
            Text("유저 닉네임")
            HStack{
                TextField("변경할 닉네임을 입력해주세요", text: $changeUserNickname)
                    .padding(.leading, 10)
                    .frame(width: 300)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.mainColor)
                            .frame(width: 300,height: 40)
                    }
                Button(action: {
                    
                }){
                    Text("확인")
                        .foregroundColor(.white)
                }
                .frame(width: 50, height: 40)
                .background(Color.mainColor)
                .cornerRadius(10)
            }
            Spacer()
            Button(action:{
                authStore.page = "Page1"
            }){
                Text("로그아웃")
                    .frame(width: 360, height: 40)
                    .foregroundColor(.white)
                    .bold()
            }
            .background(Color.mainColor)
            .cornerRadius(10)
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct EditUserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserInfoView()
    }
}
