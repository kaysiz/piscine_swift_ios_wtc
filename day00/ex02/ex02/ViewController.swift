//
//  ViewController.swift
//  ex02
//
//  Created by kudakwashe on 2019/08/22.
//  Copyright © 2019 WeThinkCode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var laNumberShow: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func AddNumberToInput(number:String){
        var textNumber = String(laNumberShow.text!)
        textNumber = textNumber + number
        laNumberShow.text = textNumber
    }
    
    @IBAction func bu0(_ sender: Any) {
        AddNumberToInput(number: "0")
    }
    @IBAction func bu1(_ sender: Any) {
        AddNumberToInput(number: "1")
    }
    @IBAction func bu2(_ sender: Any) {
        AddNumberToInput(number: "2")
    }
    @IBAction func bu3(_ sender: Any) {
        AddNumberToInput(number: "3")
    }
    @IBAction func bu4(_ sender: Any) {
        AddNumberToInput(number: "4")
    }
    @IBAction func bu5(_ sender: Any) {
        AddNumberToInput(number: "5")
    }
    @IBAction func bu6(_ sender: Any) {
        AddNumberToInput(number: "6")
    }
    @IBAction func bu7(_ sender: Any) {
        AddNumberToInput(number: "7")
    }
    @IBAction func bu8(_ sender: Any) {
        AddNumberToInput(number: "8")
    }
    @IBAction func bu9(_ sender: Any) {
        AddNumberToInput(number: "9")
    }
    
}

