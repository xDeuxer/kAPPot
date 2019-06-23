//
//  Alert.swift
//  kAPPot
//
//  Created by YasserOsama on 6/22/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import Foundation
import UIKit

class Alert : UIViewController {
    
    class func showAlert(message : String , title : String) {
        let alertController = UIAlertController(title: title , message:"\(message)", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        UIViewController.present(alertController, animated: true, completion: nil)
    }

}
