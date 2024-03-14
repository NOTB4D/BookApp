//
//  SearchRouter.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import Foundation

protocol SearchRoutingLogic: AnyObject {}

protocol SearchDataPassing: AnyObject {
    var dataStore: SearchDataStore? { get }
}

final class SearchRouter: SearchRoutingLogic, SearchDataPassing {
    weak var viewController: SearchViewController?
    var dataStore: SearchDataStore?
}
