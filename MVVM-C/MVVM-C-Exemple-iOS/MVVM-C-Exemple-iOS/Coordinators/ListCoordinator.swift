//
//  ListCoordinator.swift
//  MVVM-C-Exemple-iOS
//
//  Created by Koussaïla Ben Mamar on 03/04/2023.
//

import Foundation
import UIKit

final class ListCoordinator: Coordinator {
    
    var parentCoordinator: ParentCoordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init(navigationController : UINavigationController) {
        print("[ListCoordinator] Initialisation")
        self.navigationController = navigationController
    }
    
    // À titre d'exemple pour vérifier que lorsqu'on retourne sur l'écran d'accueil qu'il n'y a pas de memory leak.
    deinit {
        print("[ListCoordinator] Coordinator détruit.")
    }
    
    // Définition du point d'entrée
    func start() {
        print("[ListCoordinator] Instanciation de la vue de la liste.")
        let listViewController = ListViewController.instantiate(storyboardName: "Main") ?? ListViewController()
        listViewController.coordinator = self
        
        // On n'oublie pas de faire l'injection de dépendance du ViewModel
        listViewController.viewModel = ListViewModel(with: NetworkAPIService())
        
        print("[ListCoordinator] Navigation vers la vue de la liste.")
        navigationController.pushViewController(listViewController, animated: true)
        print(navigationController.viewControllers)
    }
    
    func backToHomeView() {
        print("[ListCoordinator] Retour à l'écran d'accueil.")
        
        // Nettoyage du coordinator enfant
        parentCoordinator?.removeChildCoordinator(childCoordinator: self)
        print(navigationController.viewControllers)
    }
    
    func goToDetailView(with viewModel: PhoneViewModel) {
        // La transition est séparée ici dans un sous-flux
        let detailCoordinator = DetailCoordinator(navigationController: navigationController, viewModel: viewModel)
        
        // Ajout du lien vers le parent avec self
        detailCoordinator.parentCoordinator = self
        childCoordinators.append(detailCoordinator)
        
        // On transite de l'écran liste à l'écran détail
        detailCoordinator.start()
    }
    
    func displayAlertErrorMessage(with errorMessage: String) {
        print("[ListCoordinator] Affichage d'une alerte.")
        
        let alert = UIAlertController(title: "Erreur", message: errorMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            print("OK")
        }))
        
        navigationController.present(alert, animated: true, completion: nil)
    }
}

// On respecte le principe de ségrégation d'interface du SOLID.
extension ListCoordinator: ParentCoordinator {
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
