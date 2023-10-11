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



}
