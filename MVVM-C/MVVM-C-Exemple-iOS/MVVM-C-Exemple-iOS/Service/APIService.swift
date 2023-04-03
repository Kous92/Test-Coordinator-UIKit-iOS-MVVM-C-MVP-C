//
//  APIService.swift
//  MVVM-C-Exemple-iOS
//
//  Created by Koussaïla Ben Mamar on 03/04/2023.
//

import Foundation

// Abstraction pour l'indépendance et la testabilité du service de données.
protocol APIService {
    func fetchiPhones() async throws -> [Phone]
}
