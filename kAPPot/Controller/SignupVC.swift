//
//  File.swift
//  kAPPot
//
//  Created by macOS Mojave on 4/28/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//


import UIKit
import Firebase

class SignupVC: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    
    }
    func showAlert(error : String) {
        let alertController = UIAlertController(title: "Error", message:"\(error)", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func buRegister(_ sender: Any) {
        
        if password.text != passwordConfirm.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            if (userName.text!.isEmpty) {
                let alertController = UIAlertController(title: "Error", message: "please enter your Name", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            Auth.auth().createUser(withEmail: email.text!, password: password.text!){ (user, error) in
                if error == nil {
                    let user = User(name: self.userName.text!, email: self.email.text!, password: self.password.text!,type: "user")
                    if(user.signup())
                    {
                        User.signin(email: self.email.text!
                            , completion: { (res) in
                               
                                switch res
                                {
                                    
                                case .success(let user):
                                    
                                    User.loggedInUser = user
                                    
                                    DispatchQueue.main.async {
                                        self.performSegue(withIdentifier: "goToCarSelectionFromRegister", sender: self)
                                    }
                                    
                                    
                                case .failure(let error):
                                    
                                    print(error)
                                }
                        })
                        
                    }
                    else
                    {
                        self.showAlert(error: "something went wrong while regestring")
                    }
                }
                else{
                    self.showAlert(error: error!.localizedDescription)
                }
            }
        }
    }
    
    
}



