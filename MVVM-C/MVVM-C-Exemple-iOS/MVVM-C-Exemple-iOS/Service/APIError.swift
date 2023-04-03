//
//  APIError.swift
//  MVVM-C-Exemple-iOS
//
//  Created by Koussaïla Ben Mamar on 03/04/2023.
//

import Foundation

enum APIError: Error {
    case errorMessage(String)
    
    var errorMessageString: String {
        switch self {
        case .errorMessage(let message):
            return message
        }
    }
}
