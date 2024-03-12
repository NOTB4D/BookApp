//
//  UIApplicationExtension.swift
//
//
//  Created by Eser Kucuker on 11.03.2024.
//

import Foundation
import UIKit

public extension UIApplication {
    /// Returns UIViewController with the specified generic type.
    ///  If `inScene` is not specified,  this function will look into UIViewController by
    ///  removing ViewController suffix.
    ///  eg. LoginViewController would be queried in Login.storyboard file.
    ///  Otherwise, view controller will be looked up in the specified scene.
    /// - Parameters:
    ///   - named: Scene name of the view controller.
    ///   - isInitialViewController: Bool indicating whether view controler with the
    ///   specified type is initial view controller.
    /// - Returns: Returns specifed controller in the specified storyboard.
    /// Throws error if there controller could not be found.
    class func getViewController<T: UIViewController>(
        inScene named: String? = nil,
        isInitialViewController: Bool = true
    ) -> T {
        let controllerName = String(describing: T.self)
        let storyboardName = named ?? substringStoryboardName(withViewControllerName: controllerName)
        if isInitialViewController,
           let viewController = UIStoryboard(
               name: String(storyboardName), bundle: nil
           ).instantiateInitialViewController() as? T
        {
            return viewController
        } else if let viewController = UIStoryboard(
            name: String(storyboardName), bundle: nil
        ).instantiateViewController(withIdentifier: controllerName) as? T {
            return viewController
        } else {
            fatalError("InstantiateInitialViewController not found")
        }
    }

    private class func substringStoryboardName(withViewControllerName controllerName: String) -> String {
        let viewControllerName = controllerName
        if let range = viewControllerName.range(of: "ViewController") {
            return String(viewControllerName[..<range.lowerBound])
        } else {
            return controllerName
        }
    }
}
