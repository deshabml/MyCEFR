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
        var password = "123"
        var mail = "mail@mail.ru"
        viewModel.toggleShowButton(texts: [password, mail], showButton: &isShow)
        XCTAssertTrue(isShow)
    }


}
