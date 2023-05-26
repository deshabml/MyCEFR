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

    var body: some View {
        VStack {
            Text(isAuthorization ? "Авторизуйтесь" : "Зарегистрируйтесь")
                .font(.custom("ItimCyrillic", size: 28))
                .padding(.vertical, 30)
            VStack(spacing: 10) {
                if viewModel.showCreatePassword, !isAuthorization {
                    SecureFieldView(viewModel: viewModel.createPasswordSFVMOne)
                    SecureFieldView(viewModel: viewModel.createPasswordSFVMSecond)
                    if viewModel.showButtonCompleteRegistration {
                        ButtonView(viewModel: viewModel.buttonRegComplitedViewModel,
                                   color: Color("MainTopicColor"),
                                   width: nil)
                    }
                } else {
                    if viewModel.showCodeTextFild {
                        ZStack {
                            Text(viewModel.loginText)
                                .font(.custom("ItimCyrillic", size: 18))
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.white)
                                .background(.black.opacity(0.6))
                                .cornerRadius(8)
                            HStack {
                                Spacer()
                                ButtonImageView(viewModel: viewModel.buttomEditMailBIVM)
                            }
                        }
                        TextField("Код", text: $viewModel.verificationCodeText)
                            .font(.custom("ItimCyrillic", size: 24))
                            .frame(width: 110, height: 20)
                            .padding()
                            .background(.white)
                            .cornerRadius(8)
                        if viewModel.showButtonSend {
                            ButtonView(viewModel: viewModel.buttonSendViewModel,
                                       color: Color("MainTopicColor"),
                                       width: 110)
                        }
                    } else {
                        TextField("E-mail", text: $viewModel.loginText)
                            .font(.custom("ItimCyrillic", size: 18))
                            .padding()
                            .background(.white)
                            .cornerRadius(8)
                    }
                }
                if viewModel.showButtonSendCode, !isAuthorization {
                    HStack {
                        Spacer()
                        ButtonView(viewModel: viewModel.buttonSendCodeViewModel,
                                   color: Color("MainTopicColor"),
                                           width: nil)
                    }
                    .padding(.horizontal, 2)
                }
                if isAuthorization {
                    ZStack {
                        SecureFieldView(viewModel: viewModel.passwordSFVM)
                        if viewModel.showButtonLogIn {
                            HStack {
                                Spacer()
                                ButtonView(viewModel: viewModel.buttonLogInViewModel,
                                           color: Color("MainTopicColor"),
                                           width: nil)
                            }
                            .padding(.horizontal, 2)
                        }
                    }
                }
                Button {
                    isAuthorization.toggle()
                    viewModel.showCodeTextFild = false
                } label: {
                    Text(isAuthorization ? "Ещё не с нами?" : "Уже есть аккаунт")
                        .foregroundColor(Color("RedTopicColor"))
                        .font(.custom("ItimCyrillic", size: 18))
                }
            }
            .padding(.vertical, 70)
            Spacer()
        }
        .modifier(BackgroundElement(isShowView: $isAuthorization,
                                    ImageName: "AuthorizationBackground"))
        .animation(.easeInOut(duration: 0.4), value: viewModel.showButtonLogIn)
        .animation(.easeInOut(duration: 0.4), value: viewModel.showButtonSendCode)
        .animation(.easeInOut(duration: 0.4), value: isAuthorization)
        .animation(.easeInOut(duration: 0.4), value: viewModel.showCodeTextFild)
        .animation(.easeInOut(duration: 0.4), value: viewModel.showButtonCompleteRegistration)
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView()
    }
}
