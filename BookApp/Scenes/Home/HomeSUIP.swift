//
//  HomeSUIP.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import SwiftUI

@available(iOS 13.0, *) struct HomeSUIP: PreviewProvider {
    static var previews: some View {
        let destination: HomeViewController = UIApplication.getViewController()
        return destination.preview
    }
}
