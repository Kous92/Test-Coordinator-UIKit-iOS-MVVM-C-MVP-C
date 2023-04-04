//
//  AppCoordinator.swift
//  MVVM-C-Exemple-iOS
//
//  Created by Koussaïla Ben Mamar on 03/04/2023.
//

import Foundation
import UIKit

// Le principal Coordinator de l'app, la racine même du flux de navigation.
final class AppCoordinator: Coordinator {
    // Sous-flux
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("Instanciation de la vue de départ")
        let homeViewController = HomeViewController.instantiate(storyboardName: "Main") ?? HomeViewController()
        homeViewController.coordinator = self
        
        // Pas d'animation pour l'écran de départ.
        print("HomeViewController prêt.")
        navigationController.pushViewController(homeViewController, animated: false)
    }
    
    func goToListView() {
        // La transition est séparée ici dans un sous-flux
        let listCoordinator = ListCoordinator(navigationController: navigationController)
        
        // Ajout du lien vers le parent avec self
        listCoordinator.parentCoordinator = self
        childCoordinators.append(listCoordinator)
        
        // On transite de l'écran liste à l'écran détail
        listCoordinator.start()
    }
}

// On respecte le principe de ségrégation d'interface du SOLID.
extension AppCoordinator: ParentCoordinator {
    // Ajout d'un coordinator enfant au parent, le parent aura une référence sur le coordinator enfant
    func addChildCoordinator(childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }

    // Supprime un coordinator enfant depuis le parent
    func removeChildCoordinator(childCoordinator: Coordinator) {
        // Il faut bien vérifier la référence entre les coordinators, on utilise du coup === au lieu de ==.
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
}
