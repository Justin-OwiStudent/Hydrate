//
//  CaloriesViewModel.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/23.
//

import Foundation
import Firebase
import FirebaseFirestore

class CaloriesViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
        
    //list of items
    @Published var CalorieList = [Calorie]()
    
    func getAllStepData() {

        db.collection("Calories").getDocuments {snapshot, err in
            
            if err == nil {
                DispatchQueue.main.async {
                    self.CalorieList = snapshot!.documents.map{d in
                        return Calorie(title: d["title"] as? String ?? "None - cant find title",
                                              amount: d["amount"] as? String ?? "None - cant find amount",
                                              image: d["image"] as? String ?? "None - cant find image",
                                              date: d["date"] as? String ?? "None - cant find date"
                        )
                    }
                }
            } else {
                print(err?.localizedDescription ?? "Something went wrong while getting docs.")
            }
            
        }
        
    }
}
