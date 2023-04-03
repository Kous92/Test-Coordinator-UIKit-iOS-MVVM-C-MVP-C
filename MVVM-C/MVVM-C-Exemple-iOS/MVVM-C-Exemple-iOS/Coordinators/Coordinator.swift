//
//  Coordinator.swift
//  MVVM-C-Exemple-iOS
//
//  Created by Koussaïla Ben Mamar on 03/04/2023.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

protocol ParentCoordinator: AnyObject {
    func addChildCoordinator(childCoordinator: Coordinator)
    func removeChildCoordinator(childCoordinator: Coordinator)
}
