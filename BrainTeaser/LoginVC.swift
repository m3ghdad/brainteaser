//
//  ViewController.swift
//  BrainTeaser
//
//  Created by Meghdad Abbaszadegan on 7/14/16.
//  Copyright © 2016 Meghdad. All rights reserved.
//

import UIKit
import pop

class LoginVC: UIViewController {

    @IBOutlet weak var emailConstrainst: NSLayoutConstraint!
    @IBOutlet weak var passwordConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginConstraint: NSLayoutConstraint!
    var animEngine: AnimationEngine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animEngine = AnimationEngine(constraints: [emailConstrainst,passwordConstraint,loginConstraint])
    }

   
    
    override func viewDidAppear(animated: Bool) {
        self.animEngine.animateOnScreen(1)
    }

}

