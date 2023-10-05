//
//  DetailViewController.swift
//  Zara
//
//  Created by Eduard Quintanilla Alcaide on 2/10/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var receivedCharacters: Result?
    
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var nameDetail: UILabel!
    @IBOutlet weak var specieDetail: UILabel!
    @IBOutlet weak var genderDetail: UILabel!
    @IBOutlet weak var originDetail: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"

    }
    



}
