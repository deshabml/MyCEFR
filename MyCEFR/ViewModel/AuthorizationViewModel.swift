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
    @Published var verificationCodeTFVM = TextFieldViewModel(placeHolder: "code".localized)
    @Published var createPasswordSFVMOne = SecureFieldViewModel()
    @Published var createPasswordSFVMSecond = SecureFieldViewModel()
    @Published var isAuthorization = true
    @Published var showButtonLogIn = false
    @Published var showButtonSendCode = false
    @Published var showButtonSend = false
    @Published var showCodeTextFild = false
    @Published var showCreatePassword = false
    @Published var showAllertError = false
    @Published var showPasswordErrorText = false
    @Published var showlogInErrorText = false
    @Published var showButtonCompleteRegistration = false
    @Published var forgotPassword = false {
        didSet {
            passwordSFVM.bindingProperty = ""
        }
    }
    @Published var buttonSendViewModel = ButtonViewModel(buttonText: "send".localized)
    @Published var buttonSendCodeViewModel = ButtonViewModel(buttonText: "sendMail".localized)
    @Published var buttonLogInViewModel = ButtonViewModel(buttonText: "logIn".localized)
    @Published var buttonRegComplitedViewModel = ButtonViewModel(buttonText: "completeReg".localized)
    @Published var buttomEditMailBIVM = ButtonImageViewModel(imageSystemName: "square.and.pencil")
    var backgraundText: String {
        if isAuthorization {
            return "authorize".localized
        } else {
            if forgotPassword {
                return "passwordRecovery".localized
            } else {
                return "register".localized
            }
        }
    }
    var buttonSwicthScreenText: String {
        if isAuthorization {
            return "notWithUsYet".localized
        } else {
            if forgotPassword {
                return "backToAuthorisation".localized
            } else {
                return "alreadyHaveAnAccount".localized
            }
        }
    }
    var allertTextError = ""
    var passwordErrorText = ""
    var logInErrorText = ""
    private var verificationCode = ""
    var completeonUpdatingUser: (()->())!

    init() {
        setupComlpitionElements()
    }

    func setupCompleteonUpdatingUser(completeonUpdatingUser: @escaping ()->()) {
        self.completeonUpdatingUser = completeonUpdatingUser
    }

    func sendVerificationCode() {
        let code = generateVerificationCode()
        verificationCode = code
        Task {
            await SMTPService.shared.sendMail(mail: loginTFVM.bindingProperty,
                                              verificationCode: code,
                                              forgotPassword: forgotPassword)
        }
    }

    func checkVerificationCode() -> Bool {
        guard verificationCodeTFVM.bindingProperty == verificationCode else {
            allertTextError = "wrongCode".localized
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
                self.verificationCodeTFVM.clear()
            }
        }
        buttonSendCodeViewModel.setupAction { [unowned self] in
            self.sendCodeAction()
        }
        buttonLogInViewModel.setupAction { [unowned self] in
            self.actionButtonLogIn()
        }
        buttonRegComplitedViewModel.setupAction { [unowned self] in
            self.actionButtonRegComplited()
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

    func sendCodeAction() {
        do {
            try checkEmail()
            Task {
                do {
                    let isFreeLogin = try await AuthService.shared.freeLogin(login: loginTFVM.bindingProperty)
                    DispatchQueue.main.async {
                        self.freeLogin(isFreeLogin)
                    }
                } catch {
                    print(error)
                }
            }
        } catch ErrorsAuthorization.notMail {
            allertTextError = "incorrectEMail".localized
            showAllertError.toggle()
        } catch {
            print(error)
        }
    }

    func freeLogin(_ isFreeLogin: Bool) {
        if isFreeLogin {
            if forgotPassword {
                allertTextError = "anAccountWithThisEmailDoesNotExist".localized
                showAllertError.toggle()
            } else {
                showButtonSendCode.toggle()
                showCodeTextFild.toggle()
                sendVerificationCode()
            }
        } else {
            if forgotPassword {
                showButtonSendCode.toggle()
                showCodeTextFild.toggle()
                Task {
                    do {
                        try await AuthService.shared.sendPasswordReset(login: loginTFVM.bindingProperty)
                    } catch {
                        print(error)
                    }
                }
                actionButtonAuthOrReg()
            } else {
                allertTextError = "eMailAlreadyExistTryLogginIn".localized
                showAllertError.toggle()
            }
        }
    }

    func actionButtonAuthOrReg() {
        isAuthorization.toggle()
        showCodeTextFild = false
        if showCreatePassword {
            showCreatePassword = false
        }
        showlogInErrorText = false
        forgotPassword = false
    }

    func actionButtonRegComplited() {
        guard createPasswordSFVMOne.bindingProperty == createPasswordSFVMSecond.bindingProperty else {
            passwordErrorText = "passwordsDontMatch".localized
            passwordErrorAnimation()
            return
        }
        let password = createPasswordSFVMOne.bindingProperty
        do {
            try ValidationAuthorization.shared.checkAuthorization(login: loginTFVM.bindingProperty, password: password)
            Task {
                do {
                    let _ = try await AuthService.shared.signUp(login:loginTFVM.bindingProperty, password: password)
                    DispatchQueue.main.async { [unowned self] in
                        self.completeonUpdatingUser()
                    }
                } catch {
                    print(error)
                }
            }
        } catch ErrorsAuthorization.shortPassword {
            passwordErrorText = "notSecurePassword".localized
            passwordErrorAnimation()
        } catch {
            print(error)
        }
    }

    func passwordErrorAnimation() {
        createPasswordSFVMOne.showErrorToggle()
        createPasswordSFVMSecond.showErrorToggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(50)) { [unowned self] in
            self.createPasswordSFVMOne.showErrorToggle()
            self.createPasswordSFVMSecond.showErrorToggle()
            self.showPasswordErrorText = true
        }
    }

    func logInErrorAnimation() {
        loginTFVM.showErrorToggle()
        passwordSFVM.showErrorToggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(50)) { [unowned self] in
            self.loginTFVM.showErrorToggle()
            self.passwordSFVM.showErrorToggle()
            self.showlogInErrorText = true
        }
    }

    func actionButtonLogIn() {
        do {
            try ValidationAuthorization.shared.checkAuthorization(login: loginTFVM.bindingProperty, password: passwordSFVM.bindingProperty)
            Task {
                do {
                    let _ = try await AuthService.shared.signIn(login: loginTFVM.bindingProperty, password: passwordSFVM.bindingProperty)
                    DispatchQueue.main.async { [unowned self] in
                        self.completeonUpdatingUser()
                    }
                } catch {
                    DispatchQueue.main.async { [unowned self] in
                        self.logInErrorText = "incorrectLoginOrPassword".localized
                        self.logInErrorAnimation()
                    }
                }
            }
        } catch ErrorsAuthorization.emptyAll {
            logInErrorText = "eMailCanNotBeEmpty".localized
            logInErrorAnimation()
        } catch ErrorsAuthorization.notMail {
            logInErrorText = "incorrectEMail".localized
            logInErrorAnimation()
        } catch ErrorsAuthorization.shortPassword {
            logInErrorText = "notSecurePassword".localized
            logInErrorAnimation()
        } catch {
            print(error)
        }
    }

}
