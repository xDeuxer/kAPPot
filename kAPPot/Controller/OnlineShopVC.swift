//
//  OnlineShopVC.swift
//  kAPPot
//
//  Created by YasserOsama on 6/12/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

class OnlineShopVC: UIViewController {

    @IBOutlet weak var PhoneNos: UILabel!
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var shopImage: UIImageView!
    ///////////////////////////////////
    
    
    
    var selectedOnlineShop = Shop()
    var shopSpareParts = [SparePart]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadShopData()
        // Do any additional setup after loading the view.
    }
    
    func loadShopData(){
        self.shopName.text=selectedOnlineShop.getShopName()
        self.PhoneNos.text="\(selectedOnlineShop.getTelephoneNo())"
        self.shopImage.image = UIImage(named :"\(User.loggedInUser.car.getCarModel())")
    }
    
    @IBAction func getDirections(_ sender: UIButton) {
        self.performSegue(withIdentifier: "GoToMapFromOnlineShop", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
            let vc = segue
                .destination as! MapVC
            vc.selectedShop = self.selectedOnlineShop
    }

}
extension OnlineShopVC : UICollectionViewDelegate , UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print (shopSpareParts.count)
        return shopSpareParts.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sparePart", for: indexPath) as! SparePartCollectionViewCell
        
        
        
        cell.setSparePart(sparepart: shopSpareParts[indexPath.row] , cellindex: indexPath.row)
        
        cell.delegate=self
        
       
        
        cell.setupCellappearance()
        
        
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
extension OnlineShopVC : sparePartCellDelegate
{
    func addSpareToCart(sparePart : SparePart) {
        //
        let spareItem = item(spareName : sparePart.getName() , img_url : sparePart.getImgUrl() , price : sparePart.getPrice())
        if(!User.loggedInUser.cart.items.contains(spareItem)) { User.loggedInUser.cart.items.append(spareItem) }
        User.loggedInUser.cart.updateUserCart()
    }
    
    
}
