//
//  ShopUpdate&DeletionVC.swift
//  kAPPot
//
//  Created by YasserOsama on 6/21/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

class ShopUpdate_DeletionVC: UIViewController {

    var retrievedShops = [Shop]()
    
    @IBOutlet weak var shopsCollectionsView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as! ShopCollectionViewCell
        
        
        
        
        cell.delegate=self
        
        cell.setShop(shop: retrievedShops[indexPath.row] , cellindex: indexPath.row)
        
        cell.setupCellappearance()
        
        
        return cell
        
        
    }
}




extension ShopUpdate_DeletionVC : ShopCellDelegate
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
