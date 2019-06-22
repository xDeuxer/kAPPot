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
  //var addedShop  = Shop()
    
    @IBOutlet weak var shopName: UITextField!
    
   
    @IBOutlet weak var failureType: UITextField!
    
    @IBOutlet weak var Latitude: UITextField!
    
    @IBOutlet weak var Longitude: UITextField!
    
    @IBOutlet weak var telephoneNo: UITextField!
    
    @IBOutlet weak var Rating: UITextField!
    
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

