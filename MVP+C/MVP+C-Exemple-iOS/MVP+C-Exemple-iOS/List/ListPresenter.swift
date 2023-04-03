//
//  ListPresenter.swift
//  MVP+C-Exemple-iOS
//
//  Created by Koussaïla Ben Mamar on 03/04/2023.
//

import Foundation

protocol PresenterViewDelegate: AnyObject {
    func didLoadData(with viewModels: [PhoneViewModel])
    func didErrorOccured(with errorMessage: String)
}

final class ListPresenter {
    private var iPhoneData = [Phone]()
    private var iPhoneViewModels = [PhoneViewModel]()
    private var filteredViewModels = [PhoneViewModel]()
    private var errorMessage: String = ""
    private let apiService: APIService
    
    // Référence avec la vue, attention à la rétention de cycle (memory leak)
    weak private var listViewController: PresenterViewDelegate?
    
    // Injection de dépendance pour le mock ou le service réseau
    init(with apiService: APIService, listViewController: PresenterViewDelegate?) {
        self.apiService = apiService
        self.listViewController = listViewController
    }
    
    func fetchiPhonesData() {
        Task {
            do {
                iPhoneData = try await apiService.fetchiPhones()
            } catch APIError.errorMessage(let message) {
                errorMessage = message
                await updateViewWithError()
                
                return
            }
            
            print("Données: \(iPhoneData.count), errorMessage = \(errorMessage)")
            print(iPhoneData.map { $0.name })
            
            await parseViewModels()
            await updateView()
        }
    }
    
    func searchiPhone(searchQuery: String) {
        Task {
            guard !searchQuery.isEmpty else {
                filteredViewModels = iPhoneViewModels
                await updateView()
                
                return
            }
            
            filteredViewModels = iPhoneViewModels.filter { $0.iPhone.name.lowercased().contains(searchQuery.lowercased()) }
            await updateView()
        }
    }
    
    private func parseViewModels() async {
        iPhoneData.forEach { iPhoneViewModels.append(PhoneViewModel(iPhone: $0)) }
        filteredViewModels = iPhoneViewModels
        await updateView()
    }
    
    // @MainActor remplace DispatchQueue.main.async, mais doit être appelé avec await dans un bloc async.
    // Le ViewModel va ici dire à la vue de se mettre à jour, par le biais des closures (data binding)
    @MainActor private func updateView() {
        listViewController?.didLoadData(with: filteredViewModels)
    }
    
    @MainActor private func updateViewWithError() {
        listViewController?.didErrorOccured(with: errorMessage)
    }
}
