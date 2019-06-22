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
    
    @IBOutlet weak var shopsCollectionView: UICollectionView!
    //////////////
    @IBOutlet weak var shopTypesHandle: UIButton!
    
    @IBOutlet weak var dropDownShop: UIButton!
    
    
    ////////////////////
    
    @IBOutlet weak var operationTypeHandle: UIButton!
    
    @IBOutlet weak var dropDownOperation: UIButton!
    
    
    var selectedCars = ["","","","","","","","",""]
    var currentSelectedCar : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.customNavBar()

        // Do any additional setup after loading the view.
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
            currentSelectedCar = sender.currentTitle ?? ""
            selectedCars[sender.tag] = sender.currentTitle ?? ""
          
            
        }else{
            currentSelectedCar = ""
            selectedCars[sender.tag] = ""
            
        }
        print(selectedCars)
    }
    ////////////
    
    
    @IBAction func ApplyOperation(_ sender: UIButton) {
        if(sender.currentTitle == "Repair")
        {
            shopReference = RepairShop()
            
        }
        self.performSegue(withIdentifier: operationTypeHandle.currentTitle!, sender: self)
    }
    
    

}
extension AdminControlPanelVC: UICollectionViewDataSource , UICollectionViewDelegate
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
       // return retrievedShops.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as! ShopCollectionViewCell
        
        
       
        
        cell.delegate=self
        
        //cell.setShop(shop: retrievedShops[indexPath.row] , cellindex: indexPath.row)
        
        cell.setupCellappearance()
   
        
        return cell
        
        
    }
}



extension AdminControlPanelVC : ShopCellDelegate
{
    func UpdateShop(shop: Shop, cellindex: Int) {
        
    }
    
    func DeleteShop(cellindex: Int) {
        
    }
    
    func getDirections(shop: Shop) {
        // only operable in ShopsVC
    }
    
    func shopOnline(shop: Shop) {
        // only operable in ShopsVC
    }
    
 
    
}
