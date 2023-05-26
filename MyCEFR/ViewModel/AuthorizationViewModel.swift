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
            toggleShowButton(texts: [passwordSFVM.bindingProperty, loginText], showButton: &showButtonLogIn)
            toggleShowButton(texts: [loginText], showButton: &showButtonSendCode)
            passwordSFVM.setupThereButton(showButtonLogIn)
        }
    }
    @Published var passwordSFVM = SecureFieldViewModel()
    @Published var verificationCodeText: String = "" {
        didSet {
            toggleShowButton(texts: [verificationCodeText], showButton: &showButtonSend)
        }
    }
    @Published var createPasswordSFVMOne = SecureFieldViewModel()
    @Published var createPasswordSFVMSecond = SecureFieldViewModel()
    @Published var showButtonLogIn = false
    @Published var showButtonSendCode = false
    @Published var showButtonSend = false
    @Published var showCodeTextFild = false
    @Published var showCreatePassword = false
    @Published var showButtonCompleteRegistration = false
    @Published var buttonSendViewModel = ButtonViewModel(buttonText: "Отправить")
    @Published var buttonSendCodeViewModel = ButtonViewModel(buttonText: "Выслать код")
    @Published var buttonLogInViewModel = ButtonViewModel(buttonText: "Войти")
    @Published var buttonRegComplitedViewModel = ButtonViewModel(buttonText: "Завершить регистрацию")
    @Published var buttomEditMailBIVM = ButtonImageViewModel(imageSystemName: "square.and.pencil")

    init() {
        buttonSendViewModel.setupAction { [unowned self] in
            self.showCreatePassword.toggle()
        }
        buttonSendCodeViewModel.setupAction { [unowned self] in
            self.showButtonSendCode.toggle()
            self.showCodeTextFild.toggle()
        }
        buttonLogInViewModel.setupAction {
            print("log in")
        }
        buttonRegComplitedViewModel.setupAction { [unowned self] in
            self.showCreatePassword.toggle()
        }
        passwordSFVM.setupDidSet { [unowned self] in
            self.toggleShowButton(texts: [self.passwordSFVM.bindingProperty, self.loginText], showButton: &self.showButtonLogIn)
            self.passwordSFVM.setupThereButton(self.showButtonLogIn)
        }
        createPasswordSFVMOne.setupDidSet { [unowned self] in
            self.toggleShowButton(texts: [self.createPasswordSFVMOne.bindingProperty, self.createPasswordSFVMSecond.bindingProperty],
                                  showButton: &self.showButtonCompleteRegistration)
        }
        createPasswordSFVMSecond.setupDidSet { [unowned self] in
            self.toggleShowButton(texts: [self.createPasswordSFVMOne.bindingProperty, self.createPasswordSFVMSecond.bindingProperty],
                                  showButton: &self.showButtonCompleteRegistration)
        }
        buttomEditMailBIVM.setupAction { [unowned self] in
            self.showCodeTextFild.toggle()
            self.showButtonSendCode.toggle()
        }
    }

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
