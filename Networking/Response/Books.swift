//
//  Books.swift
//  BookApp
//
//  Created by Eser Kucuker on 11.03.2024.
//

import Foundation


struct BooksResponse: Decodable {
    let results: [Books]
}

// MARK: - Result
struct Books: Codable {
    let artistName: String?
    let id: String?
    let name: String?
    let releaseDate: String?
    let kind: String?
    let artistId: String?
    let artistUrl: String?
    let contentAdvisoryRating: ContentAdvisoryRating?
    let artworkUrl100: String?
    let genres: [Genre]?
    let url: String?

    init(
        artistName: String?,
        id: String?,
        name: String?,
        releaseDate: String?,
        kind: String?,
        artistId: String?,
        artistUrl: String?,
        contentAdvisoryRating: ContentAdvisoryRating?,
        artworkUrl100: String?,
        genres: [Genre]?,
        url: String?
    ) {
        self.artistName = artistName
        self.id = id
        self.name = name
        self.releaseDate = releaseDate
        self.kind = kind
        self.artistId = artistId
        self.artistUrl = artistUrl
        self.contentAdvisoryRating = contentAdvisoryRating
        self.artworkUrl100 = artworkUrl100
        self.genres = genres
        self.url = url
    }
}

enum ContentAdvisoryRating: String, Codable {
    case explict = "Explict"
}

// MARK: - Genre
struct Genre: Codable {
    let genreID: String?
    let name: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }
}
