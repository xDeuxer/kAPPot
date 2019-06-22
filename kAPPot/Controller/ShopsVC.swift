//
//  ShopsVC.swift
//  kAPPot
//
//  Created by macOS Mojave on 5/8/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//
// defined car_storeModel 3shan a2ra mno instance -

import UIKit

class ShopsVC:  UIViewController {
    
    @IBOutlet weak var sortOptions: UIButton!
    
    @IBOutlet weak var dropDownHandle: UIButton!
    
    @IBOutlet weak var shopsCollectionView: UICollectionView!
    
    var Shops : [Shop] = []
    var selectdShop = Shop()
    var repairType : String = ""
    var carSpares = [SparePart]()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func showAllShops(_ sender: UIButton) {
        
        performSegue(withIdentifier: "ShowAllShopsOnMap", sender: self)
    }
    
    
    
    func loadCarSpares(completion: @escaping () -> Void) {
        self.carSpares.removeAll()
        User.loggedInUser.car.getAllCarSpares{ (res) in
            
            switch res
            {
                
            case .success(let retrievedSpares):
                
                self.carSpares = retrievedSpares
                completion()
            case .failure(let error):
                print("\(error)")
                completion()
            }
        }
    }
   
    @IBAction func applySort(_ sender: UIButton) {
        
        Shops = Shop.sortByDistance(shops: Shops)
        shopsCollectionView.reloadData()
    }
    
    
    @IBAction func dropDownHandle(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.sortOptions.isHidden = !self.sortOptions.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func sortOptionChanged(_ sender: UIButton) {
        let temp = dropDownHandle.currentTitle
        dropDownHandle.setTitle(sender.currentTitle, for: .normal)
        sender.setTitle(temp, for: .normal)
        sender.isHidden = !sender.isHidden
        
        
    }
    
}



extension ShopsVC: UICollectionViewDataSource , UICollectionViewDelegate
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
            return Shops.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as! ShopCollectionViewCell
            
        
        
        
            cell.delegate=self
            
            cell.setShop(shop: self.Shops[indexPath.row] , cellindex: indexPath.row)
            
            cell.setupCellappearance()
        
            if(repairType == "")
            {
                cell.OnlineBu.isHidden = false
            }
            else{
                cell.OnlineBu.isHidden = true
               
            }
            
            return cell
   
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.black.cgColor
        cell?.backgroundColor = .lightGray
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0.0
        cell?.backgroundColor = .white
        
    }
}




extension ShopsVC : ShopCellDelegate
{
    func UpdateShop(shop: Shop, cellindex: Int) {
        //only operable in AdminVC
    }
    
    func DeleteShop(cellindex: Int) {
        //only operable in AdminVC
    }
    
   
    

    func getDirections(shop : Shop) {
        self.selectdShop = shop
        self.performSegue(withIdentifier: "GoToMap", sender: self)
    }
    func shopOnline(shop : Shop) {
        loadCarSpares {
            DispatchQueue.main.async {
                self.selectdShop = shop
                self.performSegue(withIdentifier: "GoToOnlineShop", sender: self)
            }
        }
        
   
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "GoToMap")
        {
            let vc = segue
                .destination as! MapVC
            vc.selectedShop = self.selectdShop
        }else if(segue.identifier == "ShowAllShopsOnMap"){
            
            let vc = segue.destination as! MapVC
            vc.AllShops = Shops
            vc.action = "ShowAllShops"
            
        }else{
            let vc = segue.destination as! OnlineShopVC
            print(carSpares.count)
            vc.selectedOnlineShop=self.selectdShop
            vc.shopSpareParts = self.carSpares
        }
        
    }
   
}


