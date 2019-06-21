//
//  UserOrderVC.swift
//  kAPPot
//
//  Created by YasserOsama on 6/20/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

class UserOrderVC: UIViewController {

    
    @IBOutlet weak var OrderCollectionView: UICollectionView!
    var userOrder : Order = Order()
    
    @IBOutlet weak var TotalPRice: UILabel!
    
    @IBOutlet weak var deliveryDate: UILabel!
    @IBOutlet weak var deliveryArea: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userOrder = User.loggedInUser.order
        deliveryDate.text="\(String(describing: userOrder.deliveryDate))"
        deliveryArea.text = "\(userOrder.address)"
        TotalPRice.text = "\(userOrder.totalPrice)"
        OrderCollectionView.reloadData()
    }
    
    
}
extension UserOrderVC : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ((userOrder.orderItems.count))
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orderItem", for: indexPath) as! CartItemCollectionViewCell
        
        cell.delegate = self
        
        cell.setCartItem(spare: (userOrder.orderItems[indexPath.row]) , cellindex:  indexPath.row)
        
        return cell
    }
}
extension UserOrderVC : CartItemCellDelegate
{
    func UpdateCart(price: Int, itemQuantity: Int, cellindex: Int) {
        // only callable in cartVC
    }
    
    func Removeitem(itemIndex: Int) {
        // only callable in cartVC
    }
    
    
    
    
}


    
        



