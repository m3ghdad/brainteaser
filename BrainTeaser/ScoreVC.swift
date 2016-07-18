//
//  ScoreVC.swift
//  BrainTeaser
//
//  Created by Meghdad Abbaszadegan on 7/18/16.
//  Copyright © 2016 Meghdad. All rights reserved.
//

import UIKit

class ScoreVC: UIViewController {

    @IBOutlet weak var scoreLbl: UILabel!
    var correctCards: Int!
    var wrongCards: Int!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLbl.text = "\(correctCards) / \(correctCards + wrongCards)"
        
    }

}
