//
//  AdminControlPanelVC.swift
//  kAPPot
//
//  Created by YasserOsama on 6/19/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

class AdminControlPanelVC: UIViewController {

    var selectedCars = ["","","","","","","","",""]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func selectCar(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected)
        {
            selectedCars[sender.tag] = sender.currentTitle ?? ""
          
            
        }else{
            selectedCars[sender.tag] = ""
            
        }
        print(selectedCars)
    }

    

}
