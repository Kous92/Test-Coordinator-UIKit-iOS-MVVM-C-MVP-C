//
//  DetailViewController.swift
//  MVP+C-Exemple-iOS
//
//  Created by Koussaïla Ben Mamar on 03/04/2023.
//

import UIKit

final class DetailViewController: UIViewController, Storyboarded {
    private var viewModel: PhoneViewModel?
    
    // Il faut que le ViewController puisse communiquer avec le Coordinator pour les différentes transitions de navigation.
    // Attention à la rétention de cycle, ici: DetailCoordinator -> UINavigationController -> DetailViewController -> DetailCoordinator
    weak var coordinator: DetailCoordinator?
    
    @IBOutlet weak var iPhoneNameLabel: UILabel!
    @IBOutlet weak var iPhoneImageView: UIImageView!
    @IBOutlet weak var iPhoneYearLabel: UILabel!
    @IBOutlet weak var iPhoneStorageLabel: UILabel!
    @IBOutlet weak var iPhoneChipLabel: UILabel!
    @IBOutlet weak var iPhoneiOSversionsLabel: UILabel!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    // ATTENTION: Cela se déclenche aussi bien lorsque l'écran est détruit que lorsque qu'il y a un écran qui va aller au-dessus de celui-ci.
    override func viewWillDisappear(_ animated: Bool) {
        // On s'assure qu'on fait bien un retour
        if isMovingFromParent {
            coordinator?.backToListView()
        }
    }
    
    func configure(with viewModel: PhoneViewModel) {
        self.viewModel = viewModel
    }
    
    private func setViews() {
        iPhoneNameLabel.text = viewModel?.iPhone.name
        iPhoneImageView.loadImage(with: viewModel?.iPhone.details.fullScreenImageURL ?? "")
        iPhoneYearLabel.text = "Année de sortie: \(viewModel?.iPhone.details.year ?? "")"
        iPhoneStorageLabel.text = "Capacités de stockage: \(viewModel?.iPhone.details.storageCapacities.joined(separator: ", ") ?? "")"
        iPhoneChipLabel.text = viewModel?.getChipDetails()
        iPhoneiOSversionsLabel.text = viewModel?.getOperatingSystems()
    }
}
