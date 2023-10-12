//
//  SelectLevelViewModelTests.swift
//  MyCEFRTests
//
//  Created by Лаборатория on 12.10.2023.
//

import XCTest
@testable import MyCEFR

final class SelectLevelViewModelTests: XCTestCase {

    var viewModel: SelectLevelViewModel?

    override func setUpWithError() throws {
        viewModel = SelectLevelViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testGetLevelsShouldSuccessfulUpload() {
        guard let viewModel else {
            XCTFail()
            return
        }
        let expactation = XCTestExpectation()
        Task {
            do {
                let level = try await FirestoreService.shared.getlevels()
                expactation.fulfill()
                viewModel.levels = level
            } catch {
                XCTFail()
            }
        }
        wait(for: [expactation])
        XCTAssertFalse(viewModel.levels.isEmpty)
    }


}
