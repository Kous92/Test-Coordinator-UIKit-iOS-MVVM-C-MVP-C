//
//  ListCoordinator.swift
//  MVP+C-Exemple-iOS
//
//  Created by Koussaïla Ben Mamar on 03/04/2023.
//

import Foundation
import UIKit

// On respecte les 4ème et 5ème principe du SOLID de la ségrégation d'interface et de l'inversion de dépendances
protocol ListViewControllerDelegate: AnyObject {
    func backToHomeView()
    func goToDetailView(with viewModel: PhoneViewModel)
    func displayAlertErrorMessage(with errorMessage: String)
}

final class ListCoordinator: Coordinator, ParentCoordinator {
    // Attention à la rétention de cycle, le sous-flux ne doit pas retenir la référence avec le parent.
    weak var parentCoordinator: Coordinator?
    
    private(set) var navigationController: UINavigationController
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
        
        // On n'oublie pas de faire l'injection de dépendance du Presenter
        listViewController.presenter = ListPresenter(with: NetworkAPIService(), listViewController: listViewController)
        
        print("[ListCoordinator] Navigation vers la vue de la liste.")
        navigationController.pushViewController(listViewController, animated: true)
        print(navigationController.viewControllers)
    }
}

// On respecte les principes de ségrégation d'interface et d'inversion de dépendances du SOLID.
extension ListCoordinator: ListViewControllerDelegate {
    func backToHomeView() {
        print("[ListCoordinator] Retour à l'écran d'accueil: suppression du coordinator.")
        
        // Nettoyage du coordinator enfant
        parentCoordinator?.removeChildCoordinator(childCoordinator: self)
        print(navigationController.viewControllers)
    }
    
    func goToDetailView(with viewModel: PhoneViewModel) {
        // La transition est séparée ici dans un sous-flux
        let detailCoordinator = DetailCoordinator(navigationController: navigationController, viewModel: viewModel)
        
        // Ajout du lien vers le parent avec self, attention à la rétention de cycle
        detailCoordinator.parentCoordinator = self
        addChildCoordinator(childCoordinator: detailCoordinator)
        
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
