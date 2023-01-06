//
//  RegisterView.swift
//  Bottles
//
//  Created by dev on 2023/01/06.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var isValid = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            Text("이메일을 입력해주세요")
                .font(.title)
                .bold()
            VStack(alignment: .leading) {
                TextField("이메일 입력", text: $email)
                    .font(.title3)
                    .bold()
                    .padding(.bottom, 5)
                Divider()
                    .frame(height: 2)
                    .background(.purple) // 색상변경해야 됨
                if !isValid {
                    Text("이메일 양식이 맞지 않습니다.")
                        .foregroundColor(.purple)
                        .font(.footnote)
                        .padding(.top, 5)
                }
            }
            Spacer()
            Button(action: {
                if isValidEmail(email: email) {
                    isValid = true
                } else {
                    isValid = false
                    email = ""
                }
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.purple) // 색상변경해야 됨2
                        .frame(height: 50)
                    Text("가입하기")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom)
            
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

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
