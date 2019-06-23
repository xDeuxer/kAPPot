//
//  ShopAdditionVC.swift
//  kAPPot
//
//  Created by YasserOsama on 6/21/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

class ShopAdditionVC: UIViewController {

 
    var shopType :String = ""
    
    var selectedCars :[String] = []
    
    var shopToUpdate = Shop()
    var retrievedShops = [Shop]()
    var Cell : Int = 0
    var action : String = ""
  //var addedShop  = Shop()
    
   
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var shopName: UITextField!
    
   
    @IBOutlet weak var failureType: UITextField!
    
    @IBOutlet weak var Latitude: UITextField!
    
    @IBOutlet weak var Longitude: UITextField!
    
    @IBOutlet weak var telephoneNo: UITextField!
    
    @IBOutlet weak var Rating: UITextField!
    func showAlert(message : String , title : String) {
        let alertController = UIAlertController(title: title , message:"\(message)", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func addShop(_ sender: UIButton) {
        var addedShop = Shop()
        
        if(shopType == "Repair")
        {
            shopType = "car_workshops"
            
            addedShop = RepairShop(repairType: failureType.text!)
            
        }else{
            shopType = "car_stores"
        }
        
        addedShop.setShopName(shopname: shopName.text!)
        var tempnumbers : [Int] = []
        tempnumbers.append(Int(telephoneNo.text!)!)
        addedShop.setTelephoneNo(telephoneNo: tempnumbers)
        let tempLocations = [["lat" : Double(Latitude.text!)!, "long" : Double(Longitude.text!)!]]
        addedShop.setLocations(location: tempLocations )
        addedShop.setRating(rating: Double(Rating.text!)!)
        
        selectedCars.forEach { (car) in
            
            User.loggedInUser.addShopToCar(cartype: car, shop: addedShop, ShopType: shopType)
            
        }
        showAlert(message: "\(shopName.text) added successfully ", title: "Success")
        
        
    }
    
    func setUpdatedShopFields()
    {
        addButton.isHidden = true
        updateButton.isHidden = false
        
        shopName.text = shopToUpdate.getShopName()
        Latitude.text = "\(shopToUpdate.getLocations()[0]["lat"]!)"
        Longitude.text = "\(shopToUpdate.getLocations()[0]["long"]!)"
        telephoneNo.text = "\(shopToUpdate.getTelephoneNo())"
        Rating.text = "\(shopToUpdate.getRating())"
        
        
        if(shopType == "Repair")
        {
            failureType.isHidden = false
            failureType.text = "\(RepairShop.getFailureType(shop: shopToUpdate as! RepairShop))"
        }else{
            failureType.isHidden = true
            
        }
        
        
    }
    
    @IBAction func updateShopButton(_ sender: UIButton) {
        print("updaaaaaaate")
        if(shopType == "Repair"){
            let updatedShop = [
                "ShopName" : shopName.text! ,
                "location" : [["lat" : Double(Latitude.text!) , "long" : Double(Longitude.text!) ]] ,
                "rating" : Double(Rating.text!)! ,
                "telephoneNo" : [Int(telephoneNo.text!)!]
                 , "failureType" : [failureType.text!]] as [String : Any]
            dump(RepairShop.convertToRepairShop(JsonObject: updatedShop))
        User.loggedInUser.updateShop(cartype: "Jeep", UpdatedShop: RepairShop.convertToRepairShop(JsonObject: updatedShop), shops: retrievedShops, index: Cell, shopType: shopType)
        }
        selectedCars.forEach { (car) in
            if(car != "")
            {
                if(shopType == "Repair")
                {
                    shopType = "car_workshops"
                }
                else {
                    shopType = "car_stores"
                }
                let updatedShop = ["ShopName" : shopName.text! , "location" : [["lat" : Double(Latitude.text!) , "long" : Double(Longitude.text!) ]] , "rating" : Double(Rating.text!)! , "telephoneNo" : Int(telephoneNo.text!)!] as [String : Any]
                User.loggedInUser.updateShop(cartype: car, UpdatedShop: Shop.convertToShop(JsonObject: updatedShop), shops: retrievedShops, index: Cell, shopType: shopType)
                showAlert(message: "Shop Updated Successfully", title: "Success")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
       
        if(shopType == "Repair")
        {
            failureType.isHidden = false
        }else{
            failureType.isHidden = true
        }
        if(action != "")
        {
            setUpdatedShopFields()
        }
        
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

