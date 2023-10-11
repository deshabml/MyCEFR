//
//  ProfileSettingsViewModelTests.swift
//  MyCEFRTests
//
//  Created by Лаборатория on 12.10.2023.
//

import XCTest
@testable import MyCEFR

final class ProfileSettingsViewModelTests: XCTestCase {

    var viewModel: ProfileSettingsViewModel?

    override func setUpWithError() throws {
        viewModel = ProfileSettingsViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testSetupShouldSuccessFulNotSetup() {
        guard let viewModel else {
            XCTFail()
            return
        }
        XCTAssertNil(viewModel.completeonUpdatingUser)
        XCTAssertNil(viewModel.buttonExitVM.action)
    }

    func testSetupShouldSuccessFulSetup() {
        guard let viewModel else {
            XCTFail()
            return
        }
        viewModel.setup {
            let test = 4
        }
        XCTAssertNotNil(viewModel.completeonUpdatingUser)
        XCTAssertNotNil(viewModel.buttonExitVM.action)
    }

    func testEditUserDataShouldIsShowToggle() {
        guard let viewModel else {
            XCTFail()
            return
        }
        let isShow = viewModel.editPVM.showScreenEditProfile.isShow
        viewModel.editUserData()
        XCTAssertNotEqual(isShow, viewModel.editPVM.showScreenEditProfile.isShow)
    }

}
