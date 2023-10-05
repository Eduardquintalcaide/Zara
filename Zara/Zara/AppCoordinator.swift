//
//  ListResultCoordinator.swift
//  Zara
//
//  Created by Eduard Quintanilla Alcaide on 4/10/23.
//

import Foundation
import UIKit

protocol ListResultViewModelDependencies {
    var characterListUseCase: CharacterListUseCase { get }
    var characterSearchUseCase: CharacterSearchUseCase { get }
}

protocol DetailResultViewModelDependencies {
    var selectedResult: Character { get }
}

struct ListResultViewModelCoordinator: ListResultViewModelDependencies {
    let characterListUseCase: CharacterListUseCase
    let characterSearchUseCase: CharacterSearchUseCase
    
    init() {
        let networkService = NetworkService()
        characterListUseCase = CharacterListUseCaseImpl(networkService: networkService)
        characterSearchUseCase = CharacterSearchUseCaseImpl(characterListUseCase: characterListUseCase)
    }
    
}


class AppCoordinator {
    var navigationController: UINavigationController
    var storyboard: UIStoryboard

     init(navigationController: UINavigationController, storyboard: UIStoryboard) {
         self.navigationController = navigationController
         self.storyboard = storyboard
     }

    func navigateToDetailViewController(withCharacter character: Character, viewModel: DetailResultViewModel) {

         // Navegar a la vista de detalle
         if let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailResultViewController") as? DetailResultViewController {
             // Establecer el viewModel
             detailViewController.viewModel = viewModel
             // Navegar a la vista de detalle utilizando el navigationController
             navigationController.pushViewController(detailViewController, animated: true)
         }
     }

}
