//
//  AuthorizationViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 21.04.2023.
//

import Foundation

class AuthorizationViewModel: ObservableObject {

    @Published var loginTFVM = TextFieldViewModel(placeHolder: "E-mail")
    @Published var passwordSFVM = SecureFieldViewModel()
    @Published var verificationCodeTFVM = TextFieldViewModel(placeHolder: "Код")
    @Published var createPasswordSFVMOne = SecureFieldViewModel()
    @Published var createPasswordSFVMSecond = SecureFieldViewModel()
    @Published var showButtonLogIn = false
    @Published var showButtonSendCode = false
    @Published var showButtonSend = false
    @Published var showCodeTextFild = false
    @Published var showCreatePassword = false
    @Published var showAllertError = false
    @Published var showButtonCompleteRegistration = false
    @Published var buttonSendViewModel = ButtonViewModel(buttonText: "Отправить")
    @Published var buttonSendCodeViewModel = ButtonViewModel(buttonText: "Выслать код")
    @Published var buttonLogInViewModel = ButtonViewModel(buttonText: "Войти")
    @Published var buttonRegComplitedViewModel = ButtonViewModel(buttonText: "Завершить регистрацию")
    @Published var buttomEditMailBIVM = ButtonImageViewModel(imageSystemName: "square.and.pencil")
    var allertTextError = ""
    private var verificationCode = ""

    init() {
        setupComlpitionElements()
    }

    func sendVerificationCode() {
        let code = generateVerificationCode()
        verificationCode = code
        Task {
            await SMTPService.shared.sendMail(mail: loginTFVM.bindingProperty, verificationCode: code)
        }
    }

    func checkVerificationCode() -> Bool {
        guard verificationCodeTFVM.bindingProperty == verificationCode else {
            allertTextError = "Вы ввели неверный код!"
            showAllertError.toggle()
            return false
        }
        return true
    }

}

extension AuthorizationViewModel {

    func setupComlpitionElements() {
        buttonSendViewModel.setupAction { [unowned self] in
            if self.checkVerificationCode() {
                self.showCreatePassword.toggle()
            }
        }
        buttonSendCodeViewModel.setupAction { [unowned self] in
            self.sendCodeViewAction()
        }
        buttonLogInViewModel.setupAction { [unowned self] in
            print("log in")
            print(self.generateVerificationCode())
        }
        buttonRegComplitedViewModel.setupAction { [unowned self] in
            self.showCreatePassword.toggle()
        }
        loginTFVM.setupDidSet { [unowned self] in
            self.toggleShowButton(texts: [self.passwordSFVM.bindingProperty, self.loginTFVM.bindingProperty],
                                  showButton: &self.showButtonLogIn)
            self.toggleShowButton(texts: [self.loginTFVM.bindingProperty],
                                  showButton: &self.showButtonSendCode)
            self.passwordSFVM.setupThereButton(self.showButtonLogIn)
        }
        passwordSFVM.setupDidSet { [unowned self] in
            self.toggleShowButton(texts: [self.passwordSFVM.bindingProperty, self.loginTFVM.bindingProperty], showButton: &self.showButtonLogIn)
            self.passwordSFVM.setupThereButton(self.showButtonLogIn)
        }
        verificationCodeTFVM.setupDidSet { [unowned self] in
            self.toggleShowButton(texts: [self.verificationCodeTFVM.bindingProperty],
                                  showButton: &self.showButtonSend)
        }
        createPasswordSFVMOne.setupDidSet { [unowned self] in
            self.toggleShowButton(texts: [self.createPasswordSFVMOne.bindingProperty,
                                          self.createPasswordSFVMSecond.bindingProperty],
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

    func toggleShowButton(texts: [String], showButton: inout Bool) {
        let filterText = texts.filter { $0 != "" }
        if filterText.count == texts.count {
            showButton = true
        } else {
            showButton = false
        }
    }

}

extension AuthorizationViewModel {

    func checkEmail() throws {
        let itog = ValidationAuthorization.shared.isMail(login: loginTFVM.bindingProperty)
        guard itog else { throw ErrorsAuthorization.notMail }
    }

    func generateVerificationCode() -> String {
        var arrayString: [String] = []
        for _ in 0 ... 7 {
            let isString = Bool.random()
            let element: String
            if isString {
                let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                element = "\(letters.randomElement() ?? "E")"
            } else {
                element = "\(Int.random(in: 0...9))"
            }
            arrayString.append(element)
        }
        return arrayString.joined()
    }

    func sendCodeViewAction() {
        do {
            try checkEmail()
            Task {
                do {
                    try await AuthService.shared.searchLogin(login: loginTFVM.bindingProperty)
//                    try await AuthService.shared.signUp(login: loginTFVM.bindingProperty, password: "Gegcbr1q2w3e")
                    showButtonSendCode.toggle()
                    showCodeTextFild.toggle()
                    DispatchQueue.main.async { [unowned self] in
                        self.sendVerificationCode()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        } catch ErrorsAuthorization.notMail {
            allertTextError = "Введен не корректный E-mail"
            showAllertError.toggle()
        } catch {
            print(error)
        }
    }

}
