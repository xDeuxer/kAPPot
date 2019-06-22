//
//  AdminControlPanelVC.swift
//  kAPPot
//
//  Created by YasserOsama on 6/19/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

class AdminControlPanelVC: UIViewController {

    
    var shopReference : Shop = Shop()
    var retrievedShops = [Shop]()
    
  
   
    @IBOutlet weak var shopTypesHandle: UIButton!
    
    @IBOutlet weak var dropDownShop: UIButton!
    
    
    ////////////////////
    
    @IBOutlet weak var operationTypeHandle: UIButton!
    
    @IBOutlet weak var dropDownOperation: UIButton!
    
    var currentSelectedCar:String = ""
    var selectedCars = ["","","","","","","","",""]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.customNavBar()
        

        // Do any additional setup after loading the view.
    }
  
    
    
    func loadDataforView(completion: @escaping () -> Void) {
        self.retrievedShops.removeAll()
        self.shopReference.getAllCarShops(carType:currentSelectedCar) { (res) in
            
            switch res
            {
                
            case .success(let retrievedShops):
                
                self.retrievedShops = retrievedShops
                completion()
            case .failure(let error):
                print("\(error)")
                completion()
            }
        }
    }
    
    ///////////////////////////
    @IBAction func shopHandle(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.dropDownShop.isHidden = !self.dropDownShop.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func shopDropDown(_ sender: UIButton) {
        let temp = shopTypesHandle.currentTitle
        shopTypesHandle.setTitle(sender.currentTitle, for: .normal)
        sender.setTitle(temp, for: .normal)
        sender.isHidden = !sender.isHidden
        
    }
    
    ///////////////////////////
    
    @IBAction func operationHandle(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.dropDownOperation.isHidden = !self.dropDownOperation.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func operationDropDown(_ sender: UIButton) {
        let temp = operationTypeHandle.currentTitle
        operationTypeHandle.setTitle(sender.currentTitle, for: .normal)
        sender.setTitle(temp, for: .normal)
        sender.isHidden = !sender.isHidden
        
    }
    
    /////////////////////
    
    @IBAction func selectCar(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if(sender.isSelected)
        {
            currentSelectedCar=sender.currentTitle!
            selectedCars[sender.tag] = sender.currentTitle ?? ""
          
            
        }else{
            currentSelectedCar=sender.currentTitle!
            selectedCars[sender.tag] = ""
            
        }
        print(selectedCars)
    }
    ////////////
    
    
    @IBAction func ApplyOperation(_ sender: UIButton) {
       if(operationTypeHandle.currentTitle == "Add")
       {

            self.performSegue(withIdentifier: "Add", sender: self)
        
       }
        else{
            if(sender.currentTitle == "Repair")
            {
                shopReference = RepairShop(repairType:"Electrical")
                
            }
            self.loadDataforView {
                DispatchQueue.main.async {
                    
                    self.performSegue(withIdentifier: "Update/Delete", sender: self)
                }
            }
        
        
        
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "Add")
        {
            let vc = segue.destination as! ShopAdditionVC
            selectedCars.forEach { (car) in
                if (car != "")
                {
                    vc.selectedCars.append(car)
                }
            }
            vc.shopType = shopTypesHandle.currentTitle!
        }else if(segue.identifier == "Update/Delete"){
            let vc = segue.destination as! ShopUpdate_DeletionVC
            vc.retrievedShops = self.retrievedShops
        }
    }
    
    

}





