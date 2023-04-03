//
//  Phone.swift
//  MVVM-C-Exemple-iOS
//
//  Created by Koussaïla Ben Mamar on 03/04/2023.
//

import Foundation

struct PhoneResponse: Decodable {
    let phones: [Phone]
}

// MARK: - Phone
struct Phone: Decodable {
    let id: Int
    let name: String
    let imageURL: String
    let details: Details
}

// MARK: - Details
struct Details: Decodable {
    let fullScreenImageURL: String
    let year: String
    let storageCapacities: [String]
    let chip: Chip
    let operatingSystems: [String]
}

// MARK: - Chip
struct Chip: Decodable {
    let name: String
    let architecture: String
    let cores: Int
    let ram: String
}
