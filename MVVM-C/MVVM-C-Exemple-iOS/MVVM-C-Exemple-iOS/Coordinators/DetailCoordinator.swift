//
//  DetailCoordinator.swift
//  MVVM-C-Exemple-iOS
//
//  Created by Koussaïla Ben Mamar on 03/04/2023.
//

import Foundation
import UIKit

final class DetailCoordinator: Coordinator {
    weak var parentCoordinator: ParentCoordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    let viewModel: PhoneViewModel
    
    init(navigationController : UINavigationController, viewModel: PhoneViewModel) {
        print("[DetailCoordinator] Initialisation")
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    deinit {
        print("[DetailCoordinator] Coordinator détruit")
    }
    
    // Définition du point d'entrée
    func start() {
        print("[DetailCoordinator] Instanciation de la vue détail")
        let detailViewController = DetailViewController.instantiate(storyboardName: "Main")
        
        detailViewController.configure(with: viewModel)
        detailViewController.coordinator = self
        print("DetailViewController prêt.")
        self.navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func backToListView() {
        // Nettoyage du coordinator enfant
        parentCoordinator?.removeChildCoordinator(childCoordinator: self)
        print(navigationController.viewControllers)
    }
}
