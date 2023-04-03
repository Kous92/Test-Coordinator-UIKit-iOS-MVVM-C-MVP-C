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
    var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let backBarButton = UIBarButtonItem(title: "Retour", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButton
    }

    @IBAction func goToListScreen(_ sender: Any) {
        coordinator?.goToListView()
    }
}
