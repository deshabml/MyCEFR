//
//  AuthorizationViewModelTests.swift
//  MyCEFRTests
//
//  Created by Лаборатория on 05.10.2023.
//

import XCTest
@testable import MyCEFR

final class AuthorizationViewModelTests: XCTestCase {

    var viewModel: AuthorizationViewModel?

    override func setUpWithError() throws {
        viewModel = AuthorizationViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testSetupComlpitionElementsShouldSuccessFulInitialization() {
        guard let viewModel else {
            XCTFail()
            return
        }
        XCTAssertNotNil(viewModel.buttonSendViewModel.action)
        XCTAssertNotNil(viewModel.buttonSendCodeViewModel.action)
        XCTAssertNotNil(viewModel.buttonLogInViewModel.action)
        XCTAssertNotNil(viewModel.buttonRegComplitedViewModel.action)
        XCTAssertNotNil(viewModel.loginTFVM.completion)
        XCTAssertNotNil(viewModel.passwordSFVM.completion)
        XCTAssertNotNil(viewModel.verificationCodeTFVM.completion)
        XCTAssertNotNil(viewModel.createPasswordSFVMOne.completion)
        XCTAssertNotNil(viewModel.createPasswordSFVMSecond.completion)
        XCTAssertNotNil(viewModel.buttomEditMailBIVM.action)
    }

    func testSetupCompleteonUpdatingUserShouldWorksCorrectly() {
        guard let viewModel else {
            XCTFail()
            return
        }
        let randomVolue = Int.random(in: 0 ..< 100)
        var itogOne: Int = randomVolue + randomVolue
        var itogTwo: Int = 0
        viewModel.setupCompleteonUpdatingUser(completeonUpdatingUser: {
            itogTwo = randomVolue + randomVolue
        })
        viewModel.completeonUpdatingUser()
        XCTAssertEqual(itogOne, itogTwo)
    }

    func testGenerateVerificationCodeShouldCorrectFormat() {
        guard let viewModel else {
            XCTFail()
            return
        }
        let itog = viewModel.generateVerificationCode()
        let itogUniqueElements = Set(Array(itog))
        XCTAssertGreaterThan(itogUniqueElements.count, 1)
        XCTAssertEqual(itog.count, 8)
    }

    func testGenerateVerificationCodeShouldUniqueResult() {
        guard let viewModel else {
            XCTFail()
            return
        }
        let itogFirst = viewModel.generateVerificationCode()
        let itogSecond = viewModel.generateVerificationCode()
        let itogThird = viewModel.generateVerificationCode()
        XCTAssertNotEqual(itogFirst, itogSecond)
        XCTAssertNotEqual(itogFirst, itogThird)
        XCTAssertNotEqual(itogSecond, itogThird)
    }

    func testCheckVerificationCodeShouldIncorrectCode() {
        guard let viewModel else {
            XCTFail()
            return
        }
        viewModel.sendVerificationCode()
        let correctCode = viewModel.verificationCode
        let randomCode = viewModel.generateVerificationCode()
        viewModel.verificationCodeTFVM.bindingProperty = randomCode
        let itog = viewModel.checkVerificationCode()
        XCTAssertFalse(itog)
    }

    func testCheckVerificationCodeShouldCorrectCode() {
        guard let viewModel else {
            XCTFail()
            return
        }
        viewModel.sendVerificationCode()
        let correctCode = viewModel.verificationCode
        viewModel.verificationCodeTFVM.bindingProperty = correctCode
        let itog = viewModel.checkVerificationCode()
        XCTAssertTrue(itog)
    }

    func testToggleShowButtonShouldButtonNotDisplayed() {
        guard let viewModel else {
            XCTFail()
            return
        }
        var isShow = false
        var password = ""
        var mail = "mail@mail.ru"
        viewModel.toggleShowButton(texts: [password, mail], showButton: &isShow)
        XCTAssertFalse(isShow)
        password = "123"
        mail = ""
        viewModel.toggleShowButton(texts: [password, mail], showButton: &isShow)
        XCTAssertFalse(isShow)
    }

    func testToggleShowButtonShouldButtonDisplayed() {
        guard let viewModel else {
            XCTFail()
            return
        }
        var isShow = false
        let password = "123"
        let mail = "mail@mail.ru"
        viewModel.toggleShowButton(texts: [password, mail], showButton: &isShow)
        XCTAssertTrue(isShow)
    }

    func testCheckEmailShouldIncorrectMail() {
        guard let viewModel else {
            XCTFail()
            return
        }
        let noValidMails = ["12@ma.5",
                            "example.com",
                            "#@%^%#$@#$@#.com",
                            "@example.com",
                            "Joe Smith <email@example.com>",
                            "email.example.com",
                            "email@example@example.com",
                            ".email@example.com",
                            "email.@example.com",
                            "email..email@example.com",
                            "あいうえお@example.com",
                            "email@example.com (Joe Smith)",
                            "email@example",
                            "email@-example.com",
                            "email@example.web",
                            "email@111.222.333.44444",
                            "email@example..com",
                            "Abc..123@example.com"
        ]
        for noValidMail in noValidMails {
            viewModel.loginTFVM.bindingProperty = noValidMail
            do {
                try viewModel.checkEmail()
                XCTFail("\(noValidMail)")
            } catch {
                let returnedErrror = error as? ErrorsAuthorization
                XCTAssertEqual(returnedErrror, ErrorsAuthorization.notMail)
            }
        }
    }

    func testCheckEmailShouldCorrectMail() {
        guard let viewModel else {
            XCTFail()
            return
        }
        let validMails = ["email@example.com",
                          "firstname.lastname@example.com",
                          "email@subdomain.example.com",
                          "firstname+lastname@example.com",
                          "1234567890@example.com",
                          "email@example-one.ru",
                          "_______@example.com",
                          "email@example.name",
                          "email@example.museum",
                          "email@example.co.jp",
                          "firstname-lastname@example.com"]
        for validMail in validMails {
            viewModel.loginTFVM.bindingProperty = validMail
            XCTAssertNoThrow(try viewModel.checkEmail(), "\(validMail)")
        }
    }

    func testFreeLoginShouldLoginBusy() {
        guard let viewModel else {
            XCTFail()
            return
        }
        viewModel.forgotPassword = false
        viewModel.freeLogin(false)
        XCTAssertTrue(viewModel.showAllertError)
        XCTAssertEqual(viewModel.allertTextError, "eMailAlreadyExistTryLogginIn".localized)
        XCTAssertFalse(viewModel.showCodeTextFild)
        viewModel.showCodeTextFild = true
        viewModel.forgotPassword = true
        viewModel.freeLogin(false)
        XCTAssertTrue(viewModel.showButtonSendCode)
        XCTAssertFalse(viewModel.showCodeTextFild)
    }

    func testFreeLoginShouldLoginFree() {
        guard let viewModel else {
            XCTFail()
            return
        }
        viewModel.forgotPassword = false
        viewModel.freeLogin(true)
        XCTAssertFalse(viewModel.showAllertError)
        XCTAssertNotEqual(viewModel.allertTextError, "eMailAlreadyExistTryLogginIn".localized)
        XCTAssertTrue(viewModel.showButtonSendCode)
        XCTAssertTrue(viewModel.showCodeTextFild)
        viewModel.forgotPassword = true
        viewModel.freeLogin(true)
        XCTAssertTrue(viewModel.showButtonSendCode)
        XCTAssertTrue(viewModel.showCodeTextFild)
    }

    func testActionButtonAuthOrReg() {
        guard let viewModel else {
            XCTFail()
            return
        }
        let isAuthorization = viewModel.isAuthorization
        viewModel.actionButtonAuthOrReg()
        XCTAssertNotEqual(isAuthorization, viewModel.isAuthorization)
        XCTAssertFalse(viewModel.showCodeTextFild)
        XCTAssertFalse(viewModel.showCreatePassword)
        XCTAssertFalse(viewModel.showlogInErrorText)
        XCTAssertFalse(viewModel.forgotPassword)
    }

}
