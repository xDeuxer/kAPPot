//
//  ShopUpdate&DeletionVC.swift
//  kAPPot
//
//  Created by YasserOsama on 6/21/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

class ShopUpdate_DeletionVC: UIViewController {

    var selectedShop = Shop()
    var retrievedShops = [Shop]()
    var selectedCar :String = ""
    var shopType :String = ""
    var cellSelected : Int = 0
    
    @IBOutlet weak var shopsCollectionsView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        shopsCollectionsView.reloadData()
    }
    

}


extension ShopUpdate_DeletionVC: UICollectionViewDataSource , UICollectionViewDelegate
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return retrievedShops.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCellA", for: indexPath) as! ShopCollectionViewCell
        
        
        
        
        cell.delegate=self
        
        cell.setShop(shop: retrievedShops[indexPath.row] , cellindex: indexPath.row)
        
        cell.setupCellappearance()
        
        
        return cell
        
        
    }
}




extension ShopUpdate_DeletionVC : ShopCellDelegate
{
    func UpdateShop(shop: Shop, cellindex: Int) {
        
        selectedShop = shop
        cellSelected = cellindex
        self.performSegue(withIdentifier: "Update", sender: self )
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ShopAdditionVC
        vc.updateShop(shop: selectedShop, cellindex: cellSelected, shopType: shopType)
        
    }
    
    func DeleteShop(cellindex: Int) {
        
        User.loggedInUser.deleteShopFromCar(cartype: selectedCar,shops: retrievedShops ,index: cellindex, shopType: shopType)
        retrievedShops.remove(at: cellindex)
        shopsCollectionsView.reloadData()
    }
    
    func getDirections(shop: Shop) {
        // only operable in ShopsVC
    }
    
    func shopOnline(shop: Shop) {
        // only operable in ShopsVC
    }
    
    
    
}
