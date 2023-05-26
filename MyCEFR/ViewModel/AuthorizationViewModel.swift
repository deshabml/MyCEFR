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
            toggleIsShowButtonLogIn()
        }
    }
    @Published var passwordText: String = "" {
        didSet {
            toggleIsShowButtonLogIn()
        }
    }
    @Published var verificationCodeText: String = ""
    @Published var isShowButtonLogIn: Bool = false
    @Published var isShowButtonSendCode: Bool = false

}

extension AuthorizationViewModel {

    func toggleIsShowButtonLogIn() {
        if passwordText.count > 0, loginText.count > 0 {
            isShowButtonLogIn = true
        } else {
            isShowButtonLogIn = false
        }
        if loginText.count > 0 {
            isShowButtonSendCode = true
        } else {
            isShowButtonSendCode = false
        }
    }

}
