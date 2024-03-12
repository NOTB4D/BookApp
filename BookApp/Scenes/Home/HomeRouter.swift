//
//  HomeRouter.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import Foundation

protocol HomeRoutingLogic: AnyObject {}

protocol HomeDataPassing: AnyObject {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: HomeRoutingLogic, HomeDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
}
