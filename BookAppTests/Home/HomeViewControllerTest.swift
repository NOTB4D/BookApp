//
//  HomeViewControllerTest.swift
//  BookAppTests
//
//  Created by Eser Kucuker on 14.03.2024.
//

@testable import BookApp
@testable import Extensions
import XCTest

final class HomeViewControllerTest: XCTestCase {
    var sut: HomeViewController!

    override func setUp() {
        sut = UIApplication.getViewController()
        sut.loadView()
    }

    override func tearDown() {
        sut = nil
    }

    func testViewDidLoadWithSussess() {
        // Given
        UnitTestStubs.result = .getData(withJson: "GetBooksResponse")
        // When
        sut.viewDidLoad()
        let expectation = expectation(description: "durationExpectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        // Then
        XCTAssertNotNil(sut?.books)
    }

    func testViewDidLoadWithError() {
        // Given
        UnitTestStubs.result = .failureStatusCode(501)
        // When
        sut.viewDidLoad()
        let expectation = expectation(description: "durationExpectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        // Then
        XCTAssertNil(sut?.books)
    }

    func testCellForItemAt() {
        // Given
        UnitTestStubs.result = .getData(withJson: "GetBooksResponse")
        // When
        sut.viewDidLoad()
        let expectation = expectation(description: "durationExpectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        guard let cell = sut.collectionView(
            sut.collectionView,
            cellForItemAt: IndexPath(item: 0, section: 0)
        ) as? BookCell else { return }
        // Then
        XCTAssertTrue(cell.bookTitleLabel.text == "Last First Kiss")
        // Again :)
        cell.prepareForReuse()
        XCTAssertTrue(cell.bookTitleLabel.text == nil)
    }

    func testDidSelectItemAt() {
        // Given
        let navigationController = UINavigationController(rootViewController: sut)
        UnitTestStubs.result = .getData(withJson: "GetBooksResponse")
        // When
        sut.viewDidLoad()
        let expectation = expectation(description: "durationExpectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        sut.collectionView(
            sut.collectionView,
            didSelectItemAt: IndexPath(item: 0, section: 0)
        )
        // Then
        RunLoop.current.run(until: Date())
        XCTAssertTrue(navigationController.children.last is BookDetailViewController)
    }

    func testSubmitFilterButtont() {
        // Given
        let window = UIWindow()
        window.rootViewController = sut
        window.makeKeyAndVisible()
        sut.view.layoutIfNeeded()
        // When
        sut.submitFilterButton()
        // Then
        RunLoop.current.run(until: Date())
        XCTAssertTrue(sut.presentedViewController is UIAlertController)
    }

    func testSortedList() {
        // Given
        UnitTestStubs.result = .getData(withJson: "GetBooksResponse")
        // When
        sut.viewDidLoad()
        let expectation = expectation(description: "durationExpectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        sut.fetcSortedList(.newToOld)
        // Then
        XCTAssertTrue(sut.books?.first?.artistName == "LIFE … seen as a concentration camp")
        // Again
        sut.fetcSortedList(.oldToNew)
        XCTAssertTrue(sut.books?.first?.artistName == "Saving Grace (A Katie Connell Caribbean Mystery)")
    }

    func testListenFunc() {
        // Given
        LocalStorageManager.shared.removeAll()
        UnitTestStubs.result = .getData(withJson: "GetBooksResponse")
        // When
        sut.viewDidLoad()
        let expectation = expectation(description: "durationExpectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        let notification = Notification(
            name: Notification.Name("changedFavoriteStatus"),
            object: sut.books?.first?.id,
            userInfo: nil
        )
        sut.listenFunc(notification)
        // Then
        XCTAssertTrue(sut.books?.first?.isFavorite == true)
    }
}

extension UnitTestStubs.StubResult {
    static func getData(withJson json: String) -> Self {
        .getData(from: Bundle(for: HomeViewControllerTest.self).path(forResource: json, ofType: ".json"))
    }
}
