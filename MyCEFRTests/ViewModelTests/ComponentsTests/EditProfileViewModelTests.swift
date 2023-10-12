//
//  EditProfileViewModelTests.swift
//  MyCEFRTests
//
//  Created by Лаборатория on 12.10.2023.
//

import XCTest
@testable import MyCEFR

final class EditProfileViewModelTests: XCTestCase {

    var viewModel: EditProfileViewModel?

    override func setUpWithError() throws {
        viewModel = EditProfileViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testSetupComlpitionElementsShouldSuccessFulInitialization() {
        guard let viewModel else {
            XCTFail()
            return
        }
        XCTAssertNotNil(viewModel.cancelButtonVM.action)
        XCTAssertNotNil(viewModel.saveButtonVM.action)
    }

    func testDismissScreenShouldCompletedSuccessfully() {
        guard let viewModel else {
            XCTFail()
            return
        }
        let isShow = viewModel.showScreenEditProfile.isShow
        viewModel.dismissScreen()
        XCTAssertNotEqual(isShow, viewModel.showScreenEditProfile.isShow)
    }

    func testSetUserProfileShouldCompletedSuccessfully() {
        guard let viewModel else {
            XCTFail()
            return
        }
        let userProfile = UserProfile(name: "name", eMail: "mail", phone: 8888, imageUrl: "url")
        viewModel.setUserProfile(userProfile: userProfile)
        XCTAssertEqual(userProfile.name, viewModel.userProfile.name)
        XCTAssertEqual(userProfile.eMail, viewModel.userProfile.eMail)
        XCTAssertEqual(userProfile.phone, viewModel.userProfile.phone)
        XCTAssertEqual(userProfile.imageUrl, viewModel.userProfile.imageUrl)
    }

    func testSutupCompitionShouldCompletedSuccessfully() {
        guard let viewModel else {
            XCTFail()
            return
        }
        XCTAssertNil(viewModel.completion)
        viewModel.sutupCompition {
            let _ = "text"
        }
        XCTAssertNotNil(viewModel.completion)
    }

    func testEditProfileShouldWillNotBeExecuted() {
        guard let viewModel else {
            XCTFail()
            return
        }
        viewModel.editProfile()
        XCTAssertNotEqual(viewModel.userProfile.name, viewModel.nameTFVM.bindingProperty)
    }

    func testEditProfileShouldCompletedSuccessfully() {
        guard let viewModel else {
            XCTFail()
            return
        }
        viewModel.nameTFVM.bindingProperty = "name"
        viewModel.sutupCompition {
            let _ = "text"
        }
        viewModel.editProfile()
        XCTAssertEqual(viewModel.userProfile.name, viewModel.nameTFVM.bindingProperty)
        let expactation = XCTestExpectation()
        Task {
            let userProfile = UserProfile(id: "JdexI3zLDdYjRiLTqrdrSRkwzpf1", name: "Сергей Деряба", eMail: "deshab@yandex.ru", phone: 0, imageUrl: "UserImage/JdexI3zLDdYjRiLTqrdrSRkwzpf1Image.jpg")
            do {
                let _ = try await FirestoreService.shared.editProfile(userProfile: userProfile)
            } catch {
                XCTFail()
            }
        }
    }

}
