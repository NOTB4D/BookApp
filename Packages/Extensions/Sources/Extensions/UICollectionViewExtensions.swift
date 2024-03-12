//
//  UICollectionViewExtensions.swift
//
//
//  Created by Eser Kucuker on 12.03.2024.
//

import UIKit

public extension UICollectionView {
    /// Registers a nib file for use in creating new collection view cells.
    /// Cell nib file name and identifier name should as same as the cell.
    /// - Parameters:
    ///   - type: Type of the cell.
    ///   - bundle: Bundle to be looked for the cell.
    func register(_ type: UICollectionViewCell.Type, in bundle: Bundle) {
        register(UINib(nibName: type.identifier, bundle: bundle), forCellWithReuseIdentifier: type.identifier)
    }

    /// Dequeues a reusable cell object located by its type.
    /// - Parameters:
    ///   - type: Type of the cell.
    ///   - indexPath: The index path specifying the location of the cell.
    /// - Returns: A valid UICollectionReusableView object with type specified type.
    func dequeueCell<CellType: UICollectionViewCell>(type: CellType.Type, indexPath: IndexPath) -> CellType {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: CellType.identifier, for: indexPath
        ) as? CellType else {
            fatalError("Wrong type of cell \(type)")
        }
        return cell
    }
}
