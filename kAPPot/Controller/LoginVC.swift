//
//  File.swift
//  kAPPot
//
//  Created by macOS Mojave on 4/10/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseFirestore



class LoginVC: UIViewController , FBSDKLoginButtonDelegate{
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        facebookLoginButton.delegate=self
        facebookLoginButton.readPermissions=["email"]
        
    }
    
    
    @IBAction func buLogin(_ sender: Any) {

        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!){
            (user,error) in
            if let error = error{
                print("OOPAAAAAA1 :")
                print(error)
            }else{
                User.signin(email: self.txtEmail.text!
                    , completion: { (res) in
                        switch res
                        {
                            
                        case .success(let user):
                            User.loggedInUser = user
                            dump(User.loggedInUser)
                            
                        case .failure(let error):
                            print(error)
                        }
                })
                print("User UID: \(String(describing: Auth.auth().currentUser!.email))")
                
                //move to car selection VC
                self.performSegue(withIdentifier: "goToCarSelectionFromLogIn", sender: self)
            }
            
        }
    }
    
  
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error==nil
        {
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                // User is signed in
                // ...
            }
            if let error=error{
                print(error.localizedDescription)
                return
            }
        }
        else
        {
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("the user signed out")
    }
    
}

