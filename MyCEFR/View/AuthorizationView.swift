//
//  ContentView.swift
//  MyCEFR
//
//  Created by Лаборатория on 21.04.2023.
//

import SwiftUI

struct AuthorizationView: View {

    @StateObject var viewModel = AuthorizationViewModel()
    @State var isAuthorization = true
    @State var isShowCodeTextFild = false

    var body: some View {
        VStack {

            Text(isAuthorization ? "Авторизуйтесь" : "Зарегистрируйтесь")
                .font(.custom("ItimCyrillic", size: 28))
                .padding(.vertical, 30)
            VStack(spacing: 10) {
                if isShowCodeTextFild {
                    ZStack {
                        Text(viewModel.loginText)
                            .font(.custom("ItimCyrillic", size: 18))
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.white)
                            .background(.black.opacity(0.6))
                        HStack {
                            Spacer()
                            Button {
                                isShowCodeTextFild.toggle()
                                viewModel.isShowButtonSendCode.toggle()
                            } label: {
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color("RedTopicColor"))
                                    .padding(.horizontal, 8)
                            }
                        }
                    }
                    TextField("Введите код", text: $viewModel.verificationCodeText)
                        .font(.custom("ItimCyrillic", size: 28))
                        .frame(width: 100)
                        .padding()
                        .background(.white)
                } else {
                    TextField("E-mail", text: $viewModel.loginText)
                        .font(.custom("ItimCyrillic", size: 18))
                        .padding()
                        .background(.white)
                }
                if viewModel.isShowButtonSendCode, !isAuthorization {
                    HStack {
                        Spacer()
                        Button {
                            viewModel.isShowButtonSendCode.toggle()
                            isShowCodeTextFild.toggle()
                        } label: {
                            Text("Выслать код")
                                .font(.custom("ItimCyrillic", size: 24))
                                .foregroundColor(.black)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .background(Color("MainTopicColor"))
                        }
                    }
                    .padding(.horizontal, 2)
                }
                if isAuthorization {
                    ZStack {
                        SecureField("Password", text: $viewModel.passwordText)
                            .font(.custom("ItimCyrillic", size: 18))
                            .padding()
                            .background(.white)
                        if viewModel.isShowButtonLogIn {
                            HStack {
                                Spacer()
                                Button {
                                    print("log in")
                                } label: {
                                    Text("Войти")
                                        .font(.custom("ItimCyrillic", size: 24))
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                        .background(Color("MainTopicColor"))
                                }
                            }
                            .padding(.horizontal, 2)
                        }
                    }
                }
                Button {
                    isAuthorization.toggle()
                    isShowCodeTextFild = false
                } label: {
                    Text(isAuthorization ? "Ещё не с нами?" : "Уже есть аккаунт")
                        .foregroundColor(Color("RedTopicColor"))
                        .font(.custom("ItimCyrillic", size: 18))
                }
            }
            .padding(.vertical, 70)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
         Image("AuthorizationBackground")
             .resizable()
             .ignoresSafeArea()
             .scaledToFill()
             .blur(radius: isAuthorization ? 0 : 12)
         )
        .animation(.easeInOut(duration: 0.4), value: viewModel.isShowButtonLogIn)
        .animation(.easeInOut(duration: 0.4), value: viewModel.isShowButtonSendCode)
        .animation(.easeInOut(duration: 0.3), value: isAuthorization)
        .animation(.easeInOut(duration: 0.3), value: isShowCodeTextFild)
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView()
    }
}
