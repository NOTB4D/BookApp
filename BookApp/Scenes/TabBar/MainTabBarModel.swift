//
//  MainTabBarModel.swift
//  BookApp
//
//  Created by Eser Kucuker on 11.03.2024.
//

import Foundation
import Extensions

enum MarketTabs: Int, CaseCountable {
    case home = 0
    case search
    case favorite

    var title: String {
        switch self {
        case .home: "Ana Sayfa"
        case .search: "Arama"
        case .favorite: "Favoriler"
        }
    }
}
