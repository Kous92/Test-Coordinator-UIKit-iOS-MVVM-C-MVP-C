//
//  AppCoordinator.swift
//  MVVM-C-Exemple-iOS
//
//  Created by Koussaïla Ben Mamar on 03/04/2023.
//

import Foundation
import UIKit

// On respecte les 4ème et 5ème principe du SOLID de la ségrégation d'interface et de l'inversion de dépendances
protocol HomeViewControllerDelegate: AnyObject {
    func goToListView()
}

// Le principal Coordinator de l'app, la racine même du flux de navigation.
final class AppCoordinator: Coordinator {
    // Sous-flux
    var childCoordinators = [Coordinator]()
    private(set) var navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("[AppCoordinator] Instanciation de la vue de départ")
        
        // Pour la testabilité et l'indépendance
        let homeViewController = HomeViewController.instantiate(storyboardName: "Main") ?? HomeViewController()
        homeViewController.coordinator = self
        
        // Pas d'animation pour l'écran de départ.
        print("[AppCoordinator] HomeViewController prêt.")
        navigationController.pushViewController(homeViewController, animated: false)
    }
}

extension AppCoordinator: HomeViewControllerDelegate {
    func goToListView() {
        // La transition est séparée ici dans un sous-flux
        let listCoordinator = ListCoordinator(navigationController: navigationController)
        
        // Ajout du lien vers le parent avec self, attention à la rétention de cycle
        listCoordinator.parentCoordinator = self
        addChildCoordinator(childCoordinator: listCoordinator)
        
        // On transite de l'écran liste à l'écran détail
        listCoordinator.start()
    }
}
