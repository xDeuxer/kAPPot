//
//  UserProfileVC.swift
//  kAPPot
//
//  Created by YasserOsama on 6/20/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController {

    @IBOutlet weak var welcomeStatement: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userCar: UIImageView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        welcomeStatement.text = "Welcome , \(User.loggedInUser.getUserName())"
        userEmail.text = User.loggedInUser.getUserEmail()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        userCar.image = UIImage(named : User.loggedInUser.car.getCarModel())
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
