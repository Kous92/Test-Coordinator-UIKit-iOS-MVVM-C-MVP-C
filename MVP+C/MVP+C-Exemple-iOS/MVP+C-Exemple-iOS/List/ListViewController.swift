//
//  ListViewController.swift
//  MVP+C-Exemple-iOS
//
//  Created by Koussaïla Ben Mamar on 03/04/2023.
//

import UIKit

final class ListViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // Il faut que le ViewController puisse communiquer avec le Coordinator pour les différentes transitions de navigation.
    // Attention à la rétention de cycle, ici: ListCoordinator -> UINavigationController -> ListViewController -> ListCoordinator
    weak var coordinator: ListViewControllerDelegate?
    var presenter: ListPresenter?
    private var iPhoneViewModels = [PhoneViewModel]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backBarButton = UIBarButtonItem(title: "Retour", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButton
        
        setTableView()
        setSearchBar()
        presenter?.fetchiPhonesData()
    }
    
    // ATTENTION: Cela se déclenche aussi bien lorsque l'écran est détruit que lorsque qu'il y a un écran qui va aller au-dessus de celui-ci.
    override func viewWillDisappear(_ animated: Bool) {
        // On s'assure qu'on fait bien un retour
        if isMovingFromParent {
            coordinator?.backToHomeView()
        }
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setSearchBar() {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Annuler"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .label
        searchBar.searchTextField.textColor = .white
        searchBar.backgroundImage = UIImage() // Supprimer le fond par défaut
        searchBar.showsCancelButton = false
        searchBar.delegate = self
    }
    
    func displayAlertErrorMessage(with errorMessage: String) {
        coordinator?.displayAlertErrorMessage(with: errorMessage)
    }
}

extension ListViewController: PresenterViewDelegate {
    func didLoadData(with viewModels: [PhoneViewModel]) {
        iPhoneViewModels = viewModels
        tableView.reloadData()
    }
    
    func didErrorOccured(with errorMessage: String) {
        displayAlertErrorMessage(with: errorMessage)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iPhoneViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "iPhoneCell", for: indexPath) as? PhoneTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: iPhoneViewModels[indexPath.row].getPhoneCellViewModel())
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Navigation vers la vue détail
        coordinator?.goToDetailView(with: iPhoneViewModels[indexPath.row])
    }
}

// MARK: - Fonctions de la barre de recherche
extension ListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(true, animated: true) // Afficher le bouton d'annulation
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
            self?.presenter?.searchiPhone(searchQuery: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // Masquer le clavier et stopper l'édition du texte
        self.searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // Masquer le clavier et stopper l'édition du texte
        self.searchBar.setShowsCancelButton(false, animated: true) // Masquer le bouton d'annulation
    }
}
