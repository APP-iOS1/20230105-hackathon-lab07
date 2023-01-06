//
//  RegisterView.swift
//  Bottles
//
//  Created by dev on 2023/01/06.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var authStore : AuthStore
    @Binding var userEmail : String
    @Binding var userName : String
    @State private var resisterCheck : Bool = false
    @State private var isValid = true
    
    //현재 인스턴스를 해제하기 위해 사용
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text("Welcome Bottles")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.purple)
                .padding(.top, 40)
            
            Text("아래 내용으로 회원가입하시겠습니까?")
                .font(.title2)
                .bold()
            
            Text("이름")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.purple)
                .padding(.top, 20)
            
            Text("\(userName)")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                
            
            Text("이메일")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.purple)
                .padding(.top, 20)
            
            Text("\(userEmail)")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.purple) // 색상변경해야 됨2
                        .frame(height: 40)
                    Text("취소")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }

            
            Button(action: {
                
                //Firebase로 계정 생성
                Task{
                    resisterCheck = await authStore.resistUser(email: userEmail, nickname: userName)
                    print("회원가입 성공 \(resisterCheck)")
                    
                    if resisterCheck == true {
                        authStore.userEmail = userEmail
                        authStore.page = "Page2"
                    } else {
                        dismiss()
                    }
                }
                
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.purple) // 색상변경해야 됨2
                        .frame(height: 40)
                    Text("가입하기")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom)
            
        }
        .onAppear {
            print("\(userName)")
            print("\(userEmail)")
        }
        .padding()
    }
    // 이메일 정규식
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}

//struct UserInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterView(authStore: AuthStore(), userEmail: "", userName: "", isValid: true)
//    }
//}
