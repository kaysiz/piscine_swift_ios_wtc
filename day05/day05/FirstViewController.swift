//
//  FirstViewController.swift
//  day05
//
//  Created by kudakwashe on 2019/10/16.
//  Copyright © 2019 WeThinkCode. All rights reserved.
//

import UIKit
import Foundation

struct Location {
    var name: String;
    var latitude: Double;
    var longitude: Double;
    var information: String;
    var color: UIColor;
    
    init(name: String, information: String, latitude: Double, longitude: Double, color: UIColor) {
        self.name = name;
        self.latitude = latitude;
        self.longitude = longitude;
        self.information = information;
        self.color = color;
    }
}

let Locations: [Location] = [
    Location(name: "Ecole42", information: "Somewhere in France", latitude: 48.8952827, longitude: 2.3173602, color: UIColor.red),
    Location(name: "We Think Code", information: "An Elite school for coders", latitude: -26.2049385, longitude: 28.040159, color: UIColor.red),
    Location(name: "Rakodzi High School", information: "High School", latitude: -18.1741752, longitude: 31.5587161, color: UIColor.purple),
    Location(name: "Home ~ Zim", information: "Home sweet home!!", latitude: -18.1823146, longitude: 31.5609396, color: UIColor.blue),
];

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var locationsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationsTable.delegate = self
        locationsTable.dataSource = self
    }

    func tableView(_ locationsTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (Locations.count);
    }
    
    func tableView(_ locationsTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = locationsTable.dequeueReusableCell(withIdentifier: "listCell");
        cell?.textLabel?.text = Locations[indexPath.row].name;
        print(Locations[indexPath.row].name);
        return (cell!);
    }
    
    func tableView(_ locationsTable: UITableView, didSelectRowAt indexPath: IndexPath) {
        locationsTable.deselectRow(at: indexPath, animated: true);
        let SecondViewController = self.tabBarController?.viewControllers![1] as! SecondViewController;
        let actualLocationName = locationsTable.cellForRow(at: indexPath)?.textLabel?.text;
        for locationData in Locations {
            if (locationData.name == actualLocationName) {
                SecondViewController.snapToListLocation(locationData, locationName: locationData.name)
            }
        }
        self.tabBarController?.selectedViewController = SecondViewController;
    }
}

