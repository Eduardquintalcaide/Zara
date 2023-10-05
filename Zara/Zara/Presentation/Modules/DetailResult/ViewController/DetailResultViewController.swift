//
//  DetailResultViewController.swift
//  Zara
//
//  Created by Eduard Quintanilla Alcaide on 3/10/23.
//

import Foundation
import UIKit

class DetailResultViewController: UIViewController {
    
    // ViewModel to display character details
    var viewModel: DetailResultViewModel?
    
    // Outlets for UI elements
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var nameDetail: UILabel!
    @IBOutlet weak var specieDetail: UILabel!
    @IBOutlet weak var genderDetail: UILabel!
    @IBOutlet weak var originDetail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view controller title
        title = "Details"
        // Configure the user interface
        configureUI()
    }
    
    // Update the UI elements with data from the ViewModel
    func configureUI() {
        guard let viewModel = viewModel else {
            return
        }
        
        // Set character name, species, gender, and origin
        nameDetail.text = viewModel.name
        specieDetail.text = viewModel.species
        genderDetail.text = viewModel.gender
        originDetail.text = viewModel.origin.name
        
        // Load and display the character image if available
        if let imageURL = viewModel.originalimageURL {
            ImageLoader.shared.loadImage(fromURL: imageURL.absoluteString) { [weak self] image in
                // Ensure UI updates occur on the main thread
                DispatchQueue.main.async {
                    self?.imageDetail.image = image
                }
            }
        }
    }
}


