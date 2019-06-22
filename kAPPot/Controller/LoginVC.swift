//
//  File.swift
//  kAPPot
//
//  Created by macOS Mojave on 4/10/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore



class LoginVC: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        
        
    }
    
    
    @IBAction func buLogin(_ sender: Any) {

        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!){
            (user,error) in
            if let error = error{
               
                print(error)
            }else{
                User.signin(email: self.txtEmail.text!
                    , completion: { (res) in
                        
                        switch res
                        {
                        
                            case .success(let user):
                                
                                User.loggedInUser = user 
                                dump(User.loggedInUser)
                                DispatchQueue.main.async {
                                    if(user.getUserType() == "user"){
                                        self.performSegue(withIdentifier: "goToKappot", sender: self)
                                    }
                                    else {
                                        
                                        self.performSegue(withIdentifier: "GoToAdminPanel", sender: self)
                                    }
                                }
                            
                            
                            case .failure(let error):
                                
                                print(error)
                            
                            
                        }
                })
                print("User UID: \(String(describing: Auth.auth().currentUser!.email))")
                
                //move to car selection VC
                
            }
            
        }
    }
    
  
    
}

