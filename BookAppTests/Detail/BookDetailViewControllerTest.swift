//
//  BookDetailViewControllerTest.swift
//  BookAppTests
//
//  Created by Eser Kucuker on 14.03.2024.
//

@testable import BookApp
@testable import Extensions
import XCTest

final class BookDetailViewControllerTest: XCTestCase {
    var sut: BookDetailViewController!

    override func setUp() {
        sut = UIApplication.getViewController()
        (sut.interactor as? BookDetailInteractor)?.book = getDummyData()
        sut.loadView()
    }

    override func tearDown() {
        sut = nil
    }

    func testViewDidLoad() {
        // When
        sut.viewDidLoad()
        // Then
        XCTAssertTrue(sut.artistNameLabel.text == "Amy Knupp")
    }

    func testChangedFavoriteStatus() {
        // Given
        sut.viewDidLoad()
        // When
        sut.changedFavoriteStatus()
        // Then
        XCTAssertTrue(sut.starBarButton.tintColor == .darkGray)
    }

    // MARK: PrepareData

    private func getDummyData() -> BookDetail.fetchBook.Response {
        var model: Books? {
            guard
                let model: BooksResponse = getJson(name: "GetBooksResponse")
            else {
                return nil
            }
            return model.results.first
        }
        return .init(
            id: model?.id,
            artistName: model?.artistName,
            name: model?.name,
            releaseDate: model?.releaseDate,
            image: model?.artworkUrl100,
            isFavorite: true
        )
    }
}
