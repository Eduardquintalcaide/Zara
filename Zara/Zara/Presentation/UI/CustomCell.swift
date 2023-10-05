//
//  CustomCell.swift
//  Zara
//
//  Created by Eduard Quintanilla Alcaide on 2/10/23.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var imageList: UIImageView!
    @IBOutlet weak var nameList: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // Configure the cell with character data
    func configure(with result: Character) {
        nameList.text = result.name

        // Load and display the character image from the provided URL
        if let imageURL = URL(string: result.image) {
            ImageLoader.shared.loadImage(fromURL: imageURL.absoluteString) { [weak self] image in
                // Ensure UI updates occur on the main thread
                DispatchQueue.main.async {
                    self?.imageList.image = image
                    
                }
            }
        }
    }
    
    func setUpImage() {
        imageList.layer.cornerRadius = 10
        imageList.layer.masksToBounds = true
    }
}

