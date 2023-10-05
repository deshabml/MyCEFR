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

    func testSetupCompleteonUpdatingUserShouldWorksCorrectly() {
        let randomVolue = Int.random(in: 0 ..< 100)
        var itogOne: Int = randomVolue + randomVolue
        var itogTwo: Int = 0
        viewModel?.setupCompleteonUpdatingUser(completeonUpdatingUser: {
            itogTwo = randomVolue + randomVolue
        })
        viewModel?.completeonUpdatingUser()
        XCTAssertEqual(itogOne, itogTwo)
    }

}
