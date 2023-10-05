//
//  ViewController.swift
//  Zara
//
//  Created by Eduard Quintanilla Alcaide on 29/9/23.
//

import Foundation
import UIKit

class ViewListResultViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
        
    var viewModel = ListResultViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        registerCells()
        configureSearchBar()
        fetchResult()
    }
    
    // Register custom table view cells
    func registerCells() {
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomCell")
    }
    
    // Configure the search bar for character searching
    func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Characters"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // Fetch character list using the view model
    func fetchResult() {
        viewModel.fetchResult { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// UITableViewDataSource extension for handling table view data
extension ViewListResultViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else {
            fatalError("Could not dequeue a CustomCell")
        }

        // Configure the custom cell with character data
        cell.nameList.text = viewModel.result[indexPath.row].name

        // Load and display character images
        let imageURLString = viewModel.result[indexPath.row].image
        ImageLoader.shared.loadImage(fromURL: imageURLString) { [weak cell] image in
            DispatchQueue.main.async {
                cell?.imageList.image = image
            }
        }

        return cell
    }
}

// UITableViewDelegate extension for table view interactions
extension ViewListResultViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = viewModel.result[indexPath.row]
        
        // Create a view model for character details
        let viewModel = DetailResultViewModel(resultDetail: selectedResult)

        // Navigate to the detail view
        guard let navigationController = self.navigationController,
              let storyboard = storyboard else { return }
        
        AppCoordinator(navigationController: navigationController,
                       storyboard: storyboard).navigateToDetailViewController(withCharacter: selectedResult, viewModel: viewModel)
    }
}

// UISearchBarDelegate extension for handling search bar interactions
extension ViewListResultViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Perform character search based on the search text
        searchCharacters(with: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Clear the search text and refresh the table view
        searchBar.text = ""
        fetchResult()
    }
    
    func searchCharacters(with query: String) {
        viewModel.searchCharacters(with: query) { [weak self] in
            self?.tableView.reloadData()
        }
    }
}



