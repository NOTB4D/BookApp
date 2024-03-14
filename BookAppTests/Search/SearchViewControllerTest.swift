//
//  SearchViewControllerTest.swift
//  BookAppTests
//
//  Created by Eser Kucuker on 14.03.2024.
//

@testable import BookApp
@testable import Extensions
import XCTest

final class SearchViewControllerTest: XCTestCase {
    var sut: SearchViewController!

    override func setUp() {
        sut = UIApplication.getViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
    }

    func testViewWillAppearWithSussess() {
        // Given
        UnitTestStubs.result = .getData(withJson: "GetBooksResponse")
        // When
        sut.viewWillAppear(true)
        let expectation = expectation(description: "durationExpectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        // Then
        XCTAssertNotNil(sut?.books)
    }

    func testViewWillAppearewWithError() {
        // Given
        UnitTestStubs.result = .failureStatusCode(501)
        // When
        sut.viewWillAppear(true)
        let expectation = expectation(description: "durationExpectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        // Then
        XCTAssertTrue(sut?.books.count == 0)
    }

    func testcellForRowAt() {
        // Given
        UnitTestStubs.result = .getData(withJson: "GetBooksResponse")
        // When
        sut.viewWillAppear(true)
        let expectation = expectation(description: "durationExpectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        // Then
        guard let cell = sut.tableView(
            sut.tableView,
            cellForRowAt: IndexPath(row: 0, section: 0)
        ) as? BookTableViewCell else { return }

        XCTAssertTrue(cell.aurthorNameLabel.text == "Amy Knupp")
        XCTAssertTrue(cell.bookNameLabel.text == "Last First Kiss")

        // Again
        cell.prepareForReuse()
        XCTAssertTrue(cell.aurthorNameLabel.text == nil)
        XCTAssertTrue(cell.bookNameLabel.text == nil)
    }

    func testDidSelectItemAt() {
        // Given
        let navigationController = UINavigationController(rootViewController: sut)
        UnitTestStubs.result = .getData(withJson: "GetBooksResponse")
        // When
        sut.viewWillAppear(true)
        let expectation = expectation(description: "durationExpectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        // Then
        RunLoop.current.run(until: Date())
        XCTAssertTrue(navigationController.children.last is BookDetailViewController)
    }

    func testSearchBook() {
        // Given
        UnitTestStubs.result = .getData(withJson: "GetBooksResponse")
        sut.searchBar.text = "Last First Kiss"
        // When
        sut.viewWillAppear(true)
        let expectation = expectation(description: "durationExpectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        sut.fetchSearchBook()
        // Then
        XCTAssertNotNil(sut?.books)
    }
}
