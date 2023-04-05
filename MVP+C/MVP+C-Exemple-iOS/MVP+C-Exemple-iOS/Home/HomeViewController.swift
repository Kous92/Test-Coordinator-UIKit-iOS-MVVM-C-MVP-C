//
//  HomeViewController.swift
//  MVP+C-Exemple-iOS
//
//  Created by Koussaïla Ben Mamar on 03/04/2023.
//

import UIKit

// L'écran principal de l'application
final class HomeViewController: UIViewController, Storyboarded {
    
    // Il faut que le ViewController puisse communiquer avec le Coordinator pour les différentes transitions de navigation.
    // Attention à la rétention de cycle, ici: HomeCoordinator -> UINavigationController -> HomeViewController -> HomeCoordinator
    weak var coordinator: HomeViewControllerDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let backBarButton = UIBarButtonItem(title: "Retour", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButton
    }

    @IBAction private func goToListScreen(_ sender: Any) {
        coordinator?.goToListView()
    }
}
