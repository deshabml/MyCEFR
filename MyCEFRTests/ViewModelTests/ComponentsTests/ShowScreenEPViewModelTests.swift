//
//  ShowScreenEPViewModelTests.swift
//  MyCEFRTests
//
//  Created by Лаборатория on 12.10.2023.
//

import XCTest
@testable import MyCEFR

final class ShowScreenEPViewModelTests: XCTestCase {

    var viewModel: ShowScreenEPViewModel?

    override func setUpWithError() throws {
        viewModel = ShowScreenEPViewModel(imageName: "TestImageName")
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testSetupComlpitionElementsShouldSuccessFulInitialization() {
        guard let viewModel else {
            XCTFail()
            return
        }
        XCTAssertEqual(viewModel.imageName, "TestImageName")
    }

}
