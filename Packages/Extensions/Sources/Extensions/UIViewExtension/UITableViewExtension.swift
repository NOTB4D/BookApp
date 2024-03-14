//
//  UITableViewExtension.swift
//
//
//  Created by Eser Kucuker on 14.03.2024.
//

import Foundation
import UIKit

public extension UITableView {
    /// Registers a nib file for use in creating new table view cells.
    /// Cell nib file name and identifier name should as same as the cell.
    /// - Parameters:
    ///   - type: Type of the cell.
    ///   - bundle: Bundle to be looked for the cell.
    func register(_ type: UITableViewCell.Type, bundle: Bundle) {
        register(
            UINib(nibName: type.identifier, bundle: bundle),
            forCellReuseIdentifier: type.identifier
        )
    }

    /// Registers a table view cell when it is created programmatically.
    /// Cell class name and identifier name should as same as the cell.
    /// - Parameters:
    ///   - type: Type of the cell.
    func register(_ type: UITableViewCell.Type) {
        register(type, forCellReuseIdentifier: type.identifier)
    }

    /// Returns a reusable table-view cell object for the specified reuse identifier with indexPath
    /// - Parameters:
    ///   - type: Type of the cell.
    ///   - indexPath: The index path specifying the location of the cell.
    /// - Returns: A valid UICollectionReusableView object with type specified type.
    func dequeueCell<CellType: UITableViewCell>(type: CellType.Type, indexPath: IndexPath) -> CellType {
        guard let cell = dequeueReusableCell(withIdentifier: CellType.identifier, for: indexPath) as? CellType else {
            fatalError("Wrong type of cell \(type)")
        }
        return cell
    }

    /// Returns a reusable table-view cell object for the specified reuse identifier
    /// - Parameters:
    ///   - type: Type of the cell.
    ///   - indexPath: The index path specifying the location of the cell.
    /// - Returns: A valid UTableReusableView object with type specified type.
    func dequeueCell<CellType: UITableViewCell>(type: CellType.Type) -> CellType {
        guard let cell = dequeueReusableCell(withIdentifier: CellType.identifier) as? CellType else {
            fatalError("Wrong type of cell \(type)")
        }
        return cell
    }
}
