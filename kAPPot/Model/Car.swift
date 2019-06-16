//
//  Car.swift
//  kAPPot
//
//  Created by macOS Mojave on 6/7/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import FirebaseFirestore

class Car {
    private var carModel : String = ""
    private var CarSpares : [SparePart] = []
    
    func setCarModel(carModel : String) {
        self.carModel = carModel
    }
    func getCarModel() -> String {
        return self.carModel
    }
    func getAllCarSpares(car : String , completion: @escaping (Result<[SparePart],Error>) -> ())
    {
        var temp : [SparePart] = []
        let basicQuery = Firestore.firestore().collection("car_spares")
        basicQuery.addSnapshotListener { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let spares = snapshot else { return }
            for spare in spares.documents {
                
                if spare.documentID=="\(self.carModel)"{
                    let arr = spare.data()
                    guard let spareParts = arr["spares"] as? [[String : Any]] else{ return }
                    spareParts.forEach({ (carSpare) in
                        temp.append(SparePart.convertToSparePart(JsonSpare: carSpare))
                    })
                }
            }
            // print(temp)
            completion(.success(temp))
        }
        
    }
}
