//
//  CustomCell.swift
//  Zara
//
//  Created by Eduard Quintanilla Alcaide on 29/9/23.
//

import UIKit

class CustomCell: UITableViewCell {

    
    @IBOutlet weak var imageList: UIImageView!
    @IBOutlet weak var nameList: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
