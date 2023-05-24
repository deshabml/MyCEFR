//
//  ContentView.swift
//  MyCEFR
//
//  Created by Лаборатория on 21.04.2023.
//

import SwiftUI

struct AuthorizationView: View {

    @StateObject var viewModel = AuthorizationViewModel()

    var body: some View {
        VStack {
            Text("Авторизуйтесь")
                .font(.custom("ItimCyrillic", size: 24))
                .padding(.vertical, 50)
            VStack {
                TextField("Login", text: $viewModel.loginText)
                    .padding()
                    .background(.white)
                SecureField("Password", text: $viewModel.loginText)
                    .padding()
                    .background(.white)
            }
            .padding(.vertical, 50)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
         Image("AuthorizationBackground")
             .resizable()
             .ignoresSafeArea()
             .scaledToFill()
         )
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView()
    }
}
