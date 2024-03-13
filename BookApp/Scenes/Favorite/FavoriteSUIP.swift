//
//  FavoriteSUIP.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import SwiftUI

@available(iOS 13.0, *) struct FavoriteSUIP: PreviewProvider {
    static var previews: some View {
        let destination: FavoriteViewController = UIApplication.getViewController()
        return destination.preview
    }
}
