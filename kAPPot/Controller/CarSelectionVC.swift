//
//  CarSelectionVC.swift
//  kAPPot
//
//  Created by macOS Mojave on 4/25/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit
import FirebaseFirestore


class CarSelectionVC: UIViewController {

    var carType :String = ""
    var repairType :String = ""
    
    @IBOutlet weak var selectedCar: UIImageView!
    
    var ShopReference : Shop = Shop()
    var Shops = [Shop]()
    let carLogos = ["Kia","Mercedes","Hyundai","Nissan","Chevrolet","Honda","Jeep","Proton" , "BMW"]
    
    @IBOutlet weak var ServiceButtons: UIStackView!
    @IBOutlet weak var RepairTypes: UIStackView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //////////////////////
        navigationController?.customNavBar()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        selectedCar.image = UIImage(named : User.loggedInUser.car.getCarModel())
        if(User.loggedInUser.car.getCarModel() != ""){
            ServiceButtons.isHidden = false
            
        }else{
            print("has no car")
        }
    }
    
   
    // action connected to all car logos , and each logo has a tag to differentiate between them
    
    
    
    func loadDataforView(completion: @escaping () -> Void) {
        self.Shops.removeAll()
        self.ShopReference.getAllCarShops(carType: User.loggedInUser.car.getCarModel()) { (res) in
            
            switch res
            {
                
            case .success(let retrievedShops):
               
                self.Shops = retrievedShops
                completion()
            case .failure(let error):
                print("\(error)")
                completion()
            }
        }
    }
  
    @IBAction func ChosenServiceBu(_ sender: UIButton) {
        //print(sender.title(for: .normal))

        // Rspare shops
        if( sender.tag == 4 ){
            self.ShopReference = Shop()
            self.RepairTypes.isHidden=true
            repairType = ""
            
            
            
        }
        else{
            self.ShopReference = RepairShop(repairType: sender.title(for: .normal)!)
            repairType = sender.title(for: .normal)!
        }
        self.loadDataforView {
            DispatchQueue.main.async {
                
                self.performSegue(withIdentifier: "goToShopsVC", sender: self)
            }
        }


    }
    
    @IBAction func RepairType(_ sender: UIButton) {
        self.RepairTypes.isHidden=false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue
        .destination as! ShopsVC
        
        vc.repairType = self.repairType
        vc.Shops = self.Shops
        
    }
    
}

extension CarSelectionVC : carCellDelegate , UICollectionViewDelegate , UICollectionViewDataSource
{
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carLogos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CarLogoCollectionViewCell
        
        
        cell.carLogo.image = UIImage(named : carLogos[indexPath.row])
        
        cell.setCellLogoName(logoname:carLogos[indexPath.row])
        
        cell.delegate=self
        
        
        cell.setupCellappearance()
        
        
        return cell
        
        
        
    }

    
    func LogoTapped(name : String)
    {
        
        User.loggedInUser.setUserCar(carModel: name)
       
        selectedCar.image = UIImage(named : User.loggedInUser.car.getCarModel())
        self.ServiceButtons.isHidden=false
        
    }
}

