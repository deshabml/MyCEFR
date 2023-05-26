//
//  AuthorizationViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 21.04.2023.
//

import Foundation

class AuthorizationViewModel: ObservableObject {

    @Published var loginText: String = "" {
        didSet {
            toggleShowButton(texts: [passwordText, loginText], showButton: &showButtonLogIn)
            toggleShowButton(texts: [loginText], showButton: &showButtonSendCode)
        }
    }
    @Published var passwordText: String = "" {
        didSet {
            toggleShowButton(texts: [passwordText, loginText], showButton: &showButtonLogIn)
        }
    }
    @Published var verificationCodeText: String = "" {
        didSet {
            toggleShowButton(texts: [verificationCodeText], showButton: &showButtonSend)
        }
    }
    @Published var createPasswordTextOne = "" {
        didSet {
            toggleShowButton(texts: [createPasswordTextOne, createPasswordTextSecond], showButton: &showButtonCompleteRegistration)
        }
    }
    @Published var createPasswordTextSecond = "" {
        didSet {
            toggleShowButton(texts: [createPasswordTextOne, createPasswordTextSecond], showButton: &showButtonCompleteRegistration)
        }
    }
    @Published var showButtonLogIn = false
    @Published var showButtonSendCode = false
    @Published var showButtonSend = false
    @Published var showCodeTextFild = false
    @Published var showCreatePassword = false
    @Published var showButtonCompleteRegistration = false


}

extension AuthorizationViewModel {

    func toggleShowButton(texts: [String], showButton: inout Bool) {
        let filterText = texts.filter { $0 != "" }
        if filterText.count == texts.count {
            showButton = true
        } else {
            showButton = false
        }
    }

}
