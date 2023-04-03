//
//  Storyboarded.swift
//  MVP+C-Exemple-iOS
//
//  Created by Koussaïla Ben Mamar on 03/04/2023.
//

import Foundation
import UIKit

// Ce protocole permet à un ViewController de s'instancier depuis un Storyboard
protocol Storyboarded {
    static func instantiate(storyboardName: String) -> Self
}

/*
-> Avec une extension sur le protocole, on définit un comportement par défaut sur une fonction, ici instantiate.
-> De plus, le ViewController adoptant le protocole Storyboarded n'aura pas l'obligation de réimplémenter.
-> ATTENTION: Bien définir dans le Storyboard l'identifiant de Storyboard (Storyboard ID) le nom de classe du ViewController concerné. L'appli crashera sinon !
*/
extension Storyboarded where Self: UIViewController {
    static func instantiate(storyboardName: String) -> Self {
        // Ça retourne "<NomApp>.<Nom>ViewController"
        let fullName = NSStringFromClass(self)

        // Le nom complet est séparé par le point en plusieurs chaînes, donnant le nom de la classe du ViewController
        let className = fullName.components(separatedBy: ".")[1]

        // Si plusieurs Storyboards sont utilisés dans un projet, ce qui peut être possible. Sinon, c'est Main s'il y en a un seul, à moins qu'il soit renommé.
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)

        // Instancie un ViewController avec ce même identifiant et retournant le type demandé. Self: le type courant du contexte actuel, ici le ViewController qui adopte ce protocole.
        guard let viewController = storyboard.instantiateViewController(withIdentifier: className) as? Self else {
            fatalError("Le ViewController \(className) n'a pas pu être détecté dans le Storyboard \(storyboardName). Assurez-vous que le ViewController \(className) soit défini et que son StoryboardID soit défini sur \(className).")
        }
        
        return viewController
    }
}
