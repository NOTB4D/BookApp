//
//  SearchSUIP.swift
//  BookApp
//
//  Created by Eser Kucuker on 13.03.2024.
//

import SwiftUI

@available(iOS 13.0, *) struct SearchSUIP: PreviewProvider {
    static var previews: some View {
        let destination: SearchViewController = UIApplication.getViewController()
        return destination.preview
    }
}
