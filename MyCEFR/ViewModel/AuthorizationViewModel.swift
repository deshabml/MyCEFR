//
//  AuthorizationViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 21.04.2023.
//

import Foundation

class AuthorizationViewModel: ObservableObject {

    let contentViewModel: ContentViewModel
    @Published var loginTFVM = TextFieldViewModel(placeHolder: "E-mail")
    @Published var passwordSFVM = SecureFieldViewModel()
    @Published var verificationCodeTFVM = TextFieldViewModel(placeHolder: "Code")
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
    @Published var buttonSendViewModel = ButtonViewModel(buttonText: "Send")
    @Published var buttonSendCodeViewModel = ButtonViewModel(buttonText: "Send code")
    @Published var buttonLogInViewModel = ButtonViewModel(buttonText: "log in")
    @Published var buttonRegComplitedViewModel = ButtonViewModel(buttonText: "Complete regisrtation")
    @Published var buttomEditMailBIVM = ButtonImageViewModel(imageSystemName: "square.and.pencil")
    var allertTextError = ""
    var passwordErrorText = ""
    var logInErrorText = ""
    private var verificationCode = ""

    init(contentViewModel: ContentViewModel) {
        self.contentViewModel = contentViewModel
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
            allertTextError = "Wrong code!"
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
            allertTextError = "Incorrect e-mail"
            showAllertError.toggle()
        } catch {
            print(error)
        }
    }

    func freeLogin(_ isFreeLogin: Bool) {
        if isFreeLogin {
            showButtonSendCode.toggle()
            showCodeTextFild.toggle()
            sendVerificationCode()
        } else {
            allertTextError = "E-mail already exist, try loggin in!"
            showAllertError.toggle()
        }
    }

    func actionButtonAuthOrReg() {
        isAuthorization.toggle()
        showCodeTextFild = false
        if showCreatePassword {
            showCreatePassword = false
        }
        showlogInErrorText = false
    }

    func actionButtonRegComplited() {
        guard createPasswordSFVMOne.bindingProperty == createPasswordSFVMSecond.bindingProperty else {
            passwordErrorText = "passwords don't match!"
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
                        self.contentViewModel.updatingUser()
                    }
                } catch {
                    print(error)
                }
            }
        } catch ErrorsAuthorization.shortPassword {
            passwordErrorText = "Not a secure password! Must be at least 8 characters (latin aiphabet, mixed case and numbers)"
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
                        self.contentViewModel.updatingUser()
                    }
                } catch {
                    DispatchQueue.main.async { [unowned self] in
                        self.logInErrorText = "Incorrect login or password"
                        self.logInErrorAnimation()
                    }
                }
            }
        } catch ErrorsAuthorization.emptyAll {
            logInErrorText = "E-mail can not be empty!"
            logInErrorAnimation()
        } catch ErrorsAuthorization.notMail {
            logInErrorText = "Incorrect e-mail"
            logInErrorAnimation()
        } catch ErrorsAuthorization.shortPassword {
            logInErrorText = "Not a secure password! Must be at least 8 characters (latin aiphabet, mixed case and numbers)"
            logInErrorAnimation()
        } catch {
            print(error)
        }
    }

}
