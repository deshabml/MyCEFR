//
//  ContentView.swift
//  MyCEFR
//
//  Created by Лаборатория on 21.04.2023.
//

import SwiftUI

struct AuthorizationView: View {

    @StateObject var viewModel: AuthorizationViewModel

    var body: some View {
        VStack {
            VStack(spacing: 10) {
                if viewModel.showCreatePassword, !viewModel.isAuthorization {
                    VStack {
                        SecureFieldView(viewModel: viewModel.createPasswordSFVMOne)
                        SecureFieldView(viewModel: viewModel.createPasswordSFVMSecond)
                    }
                    if viewModel.showPasswordErrorText {
                        Text(viewModel.passwordErrorText)
                            .modifier(TextElement(size: 18,
                                                  foregroundColor: .red))
                    }
                    if viewModel.showButtonCompleteRegistration {
                            ButtonView(viewModel: viewModel.buttonRegComplitedViewModel,
                                       color: (.black, Color("MainTopicColor")),
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
                                       color: (.black, Color("MainTopicColor")),
                                       width: 110)
                        }
                    } else {
                        TextFieldView(viewModel: viewModel.loginTFVM,
                                      size: 18,
                                      width: nil,
                                      height: nil)
                    }
                }
                if viewModel.showButtonSendCode, !viewModel.isAuthorization {
                    HStack {
                        Spacer()
                        ButtonView(viewModel: viewModel.buttonSendCodeViewModel,
                                   color: (.black, Color("MainTopicColor")),
                                           width: nil)
                    }
                    .padding(.horizontal, 2)
                }
                if viewModel.isAuthorization {
                    VStack {
                        ZStack {
                            SecureFieldView(viewModel: viewModel.passwordSFVM)
                            if viewModel.showButtonLogIn {
                                HStack {
                                    Spacer()
                                    ButtonView(viewModel: viewModel.buttonLogInViewModel,
                                               color: (.black, Color("MainTopicColor")),
                                               width: nil)
                                }
                                .padding(.horizontal, 2)
                            }
                        }
                        if viewModel.showlogInErrorText {
                            Text(viewModel.logInErrorText)
                                .modifier(TextElement(size: 18,
                                                      foregroundColor: .red))
                                .padding(10)
                                .background(
                                    Color("WhiteColor").blur(radius: 40)
                                )
                        }
                    }
                }
                if viewModel.showlogInErrorText {
                    HStack {
                        Spacer()
                        Button {
                            viewModel.actionButtonAuthOrReg()
                            viewModel.forgotPassword.toggle()
                        } label: {
                            Text("forgotPassword".localized)
                                .modifier(TextElement(size: 18,
                                                      foregroundColor: .white))
                                .padding(10)
                                .background(
                                    Color("BlackColor").blur(radius: 50)
                                )
                        }
                    }
                }
                Button {
                    viewModel.actionButtonAuthOrReg()
                } label: {
                    Text(viewModel.buttonSwicthScreenText)
                        .modifier(TextElement(size: 18,
                                              foregroundColor: .white))
                        .padding(10)
                        .background(
                            Color("BlackColor").blur(radius: 50)
                        )
                }
            }
            .padding(.top, 170)
            Spacer()
        }
        .modifier(AuthBackgroundElement(isShowView: $viewModel.isAuthorization,
                                        headingText: viewModel.backgraundText,
                                    ImageName: "AuthorizationBackground"))
        .onTapGesture {
            hideKeyboard()
        }
        .alert(viewModel.allertTextError, isPresented: $viewModel.showAllertError) {
            Button("ОК") { }
        }
        .animation(.easeInOut(duration: 0.2), value: viewModel.forgotPassword)
        .animation(.easeInOut(duration: 0.2), value: viewModel.showPasswordErrorText)
        .animation(.easeInOut(duration: 0.4), value: viewModel.showButtonLogIn)
        .animation(.easeInOut(duration: 0.4), value: viewModel.showButtonSendCode)
        .animation(.easeInOut(duration: 0.4), value: viewModel.isAuthorization)
        .animation(.easeInOut(duration: 0.4), value: viewModel.showCodeTextFild)
        .animation(.easeInOut(duration: 0.4), value: viewModel.showButtonCompleteRegistration)
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView(viewModel: AuthorizationViewModel(contentViewModel: ContentViewModel()))
    }
}
