//
//  ViewController.swift
//  rush00
//
//  Created by kudakwashe on 2019/10/15.
//  Copyright © 2019 WeThinkCode. All rights reserved.
//

import UIKit
var Token : String = "";
var token_duration: Int = 0;

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        appLogin()
        
    }

    func appLogin() {
        print("Authorising!");
        let authEndPoint: String = "https://api.intra.42.fr/oauth/token"
        let url = URL(string: authEndPoint)
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        
        request.httpBody =     "grant_type=client_credentials&client_id=5c15d0164aa753e9b2903f57fc21fbe330fd34e51315bc34d632537f50d863ce&client_secret=9807057f913469dc20ac0f17354b98c93ce0b4227d80628ced241384cdf930e1".data(using: String.Encoding.utf8)
        
        let session = URLSession.shared
        var token = ""
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                    
                    if let tempToken = dictionary
                    {
                        token = (tempToken["access_token"] as! String)
                        Token = token;
                    }
                    
                }catch let error {
                    print(error)
                }
            }
            }.resume()
    }
}

//{
//    "error": "Not authorized",
//    "message": "The access token expired"
//}
