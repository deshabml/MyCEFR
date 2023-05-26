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
                if viewModel.showCreatePassword {
                    SecureField("Password", text: $viewModel.createPasswordTextOne)
                        .font(.custom("ItimCyrillic", size: 18))
                        .padding()
                        .background(.white)
                        .cornerRadius(8)
                    SecureField("Password", text: $viewModel.createPasswordTextSecond)
                        .font(.custom("ItimCyrillic", size: 18))
                        .padding()
                        .background(.white)
                        .cornerRadius(8)
                    if viewModel.showButtonCompleteRegistration {
                        Button {
                            viewModel.showCreatePassword.toggle()
                        } label: {
                            Text("Завершить регистрацию")
                                .font(.custom("ItimCyrillic", size: 24))
                                .foregroundColor(.black)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .background(Color("MainTopicColor"))
                                .cornerRadius(8)
                        }
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
                                Button {
                                    viewModel.showCodeTextFild.toggle()
                                    viewModel.showButtonSendCode.toggle()
                                } label: {
                                    Image(systemName: "square.and.pencil")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(Color("RedTopicColor"))
                                        .padding(.horizontal, 8)
                                }
                            }
                        }
                        TextField("Код", text: $viewModel.verificationCodeText)
                            .font(.custom("ItimCyrillic", size: 24))
                            .frame(width: 110, height: 20)
                            .padding()
                            .background(.white)
                            .cornerRadius(8)
                        if viewModel.showButtonSend {
                            Button {
                                viewModel.showCreatePassword.toggle()
                            } label: {
                                Text("Отправить")
                                    .font(.custom("ItimCyrillic", size: 24))
                                    .frame(width: 110)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(Color("MainTopicColor"))
                                    .cornerRadius(8)
                            }
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
                        Button {
                            viewModel.showButtonSendCode.toggle()
                            viewModel.showCodeTextFild.toggle()
                        } label: {
                            Text("Выслать код")
                                .font(.custom("ItimCyrillic", size: 24))
                                .foregroundColor(.black)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .background(Color("MainTopicColor"))
                                .cornerRadius(8)
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
                            .cornerRadius(8)
                        if viewModel.showButtonLogIn {
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
                                        .cornerRadius(8)
                                }
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
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("AuthorizationBackground")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .blur(radius: isAuthorization ? 0 : 12)
        )
        .animation(.easeInOut(duration: 0.4), value: viewModel.showButtonLogIn)
        .animation(.easeInOut(duration: 0.4), value: viewModel.showButtonSendCode)
        .animation(.easeInOut(duration: 0.3), value: isAuthorization)
        .animation(.easeInOut(duration: 0.3), value: viewModel.showCodeTextFild)
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView()
    }
}
