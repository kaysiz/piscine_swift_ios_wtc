//
//  ViewController.swift
//  ex01
//
//  Created by kudakwashe on 2019/08/22.
//  Copyright © 2019 WeThinkCode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBAction func clickMe() {
        self.myLabel.text = "Welcome to iOS Bootcamp"
    }
}

