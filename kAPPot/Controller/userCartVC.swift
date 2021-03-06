//
//  userCartVC.swift
//  kAPPot
//
//  Created by YasserOsama on 6/14/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

class userCartVC: UIViewController {
    func showAlert(message : String , title : String) {
        let alertController = UIAlertController(title: title , message:"\(message)", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }

    @IBOutlet weak var cart: UICollectionView!
    @IBOutlet weak var cartPrice: UILabel!
    
    var totalPrice : Int = 0    
    var userCart : Cart = Cart()
    
    @IBOutlet weak var cartCollectionView: UICollectionView!
    
    @IBOutlet weak var checkOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkOut.isHidden = false
       
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        totalPrice = 0
        userCart = User.loggedInUser.cart
        userCart.items.forEach { (cartItem) in
            totalPrice += cartItem.getPrice()*cartItem.getQuantity()
        }
        cartPrice.text = "\(totalPrice)"
        cartCollectionView.reloadData()
        print("appeared")
    }
    
    
    @IBAction func placeOrder(_ sender: UIButton) {
        User.loggedInUser.order.createOrder()
        User.loggedInUser.order.setTotalPrice(totalPrice : self.totalPrice)
        User.loggedInUser.cart.items.removeAll()
        User.loggedInUser.cart.updateUserCart()
        showAlert(message: "Order placed Successfully" , title: "Success")
        
        cart.reloadData()
    }
    

}
extension userCartVC : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ((userCart.items.count))
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartItem", for: indexPath) as! CartItemCollectionViewCell
        
        cell.delegate = self
        
        cell.setCartItem(spare: (userCart.items[indexPath.row]) , cellindex:  indexPath.row)
        
        return cell
    }
    
}
extension userCartVC : CartItemCellDelegate
{
    func UpdateCart(price: Int , itemQuantity : Int , cellindex : Int) {
        totalPrice += price
        User.loggedInUser.cart.items[cellindex].quantity = itemQuantity
        User.loggedInUser.cart.updateUserCart()
        cartPrice.text = "\(totalPrice)"
    }
    
    func Removeitem(itemIndex : Int) {
        // remove sparepart
        User.loggedInUser.cart.items.remove(at: itemIndex)
        User.loggedInUser.cart.updateUserCart()
        cart.reloadData()
    }
    
    
}
