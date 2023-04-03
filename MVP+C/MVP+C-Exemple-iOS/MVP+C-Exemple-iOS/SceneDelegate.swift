//
//  SceneDelegate.swift
//  MVP+C-Exemple-iOS
//
//  Created by Koussaïla Ben Mamar on 03/04/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    // C'est ici qu'on va mettre en place la racine de la logique de navigation, le Coordinator parent, étant aussi le point d'entrée de l'application.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Le NavigationController principal à être utilisé dans l'app
        let navigationController = UINavigationController()
        
        // C'est d'ici qu'on démarre l'application et donc ici qu'on démarre avec le coordinator.
        print("Initialisation Coordinator")
        coordinator = AppCoordinator(with: navigationController)
        coordinator?.start()
        
        print("Ouverture de la première vue")
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        // Si on définit le point d'entrée de manière programmatique, la fenêtre doit avoir une vue racine définie, ici le NavigationController où des vues y seront poussées.
        window?.rootViewController = coordinator?.navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

