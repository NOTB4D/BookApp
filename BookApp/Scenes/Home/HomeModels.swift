//
//  HomeModels.swift
//  BookApp
//
//  Created by Eser Kucuker on 12.03.2024.
//

import Foundation
import UIKit

// swiftlint:disable nesting
enum Home {
    
    enum FetchBooks {

        struct Request {
            
        }
        
        struct Response {
            let books: [Book]

            struct Book {
                let artistName: String?
                let image: String?
            }
        }

        struct ViewModel {
            let books: [Book]

            struct Book {
                let artistName: String?
                let image: String?
            }

        }
        
    }
    
}
// swiftlint:enable nesting
