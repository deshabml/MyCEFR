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
                .modifier(TextElement(size: 28,
                                      verticalPadding: 30,
                                      foregroundColor: .black))
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
                            Text(viewModel.loginTFVM.bindingProperty)
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
                        TextFieldView(viewModel: viewModel.verificationCodeTFVM,
                                      size: 24,
                                      width: 110,
                                      height: 24)
                        if viewModel.showButtonSend {
                            ButtonView(viewModel: viewModel.buttonSendViewModel,
                                       color: Color("MainTopicColor"),
                                       width: 110)
                        }
                    } else {
                        TextFieldView(viewModel: viewModel.loginTFVM,
                                      size: 18,
                                      width: nil,
                                      height: nil)
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
                        .modifier(TextElement(size: 18,
                                              foregroundColor: Color("RedTopicColor")))
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
