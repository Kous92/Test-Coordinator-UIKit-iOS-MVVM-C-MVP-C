//
//  DetailCoordinator.swift
//  MVVM-C-Exemple-iOS
//
//  Created by Koussaïla Ben Mamar on 03/04/2023.
//

import Foundation
import UIKit

// On respecte les 4ème et 5ème principe du SOLID de la ségrégation d'interface et de l'inversion de dépendances
protocol DetailViewControllerDelegate: AnyObject {
    func backToListView()
}

final class DetailCoordinator: Coordinator, ParentCoordinator {
    // Attention à la rétention de cycle, le sous-flux ne doit pas retenir la référence avec le parent.
    weak var parentCoordinator: Coordinator?
    
    private(set) var navigationController: UINavigationController
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
        let detailViewController = DetailViewController.instantiate(storyboardName: "Main") ?? DetailViewController()
        
        // Ajout du lien vers le parent avec self, attention à la rétention de cycle
        detailViewController.configure(with: viewModel)
        detailViewController.coordinator = self
        
        print("[DetailCoordinator] DetailViewController prêt.")
        self.navigationController.pushViewController(detailViewController, animated: true)
    }
}

extension DetailCoordinator: DetailViewControllerDelegate {
    func backToListView() {
        // Nettoyage du coordinator enfant
        print("[DetailCoordinator] Retour à l'écran liste: Suppression du coordinator.")
        parentCoordinator?.removeChildCoordinator(childCoordinator: self)
        print(navigationController.viewControllers)
    }
}
