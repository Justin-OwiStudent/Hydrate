//
//  StepsViewModel.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/22.
//

import Foundation
import Firebase
import FirebaseFirestore


class StepViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    let Colname = "Steps"
        
    //list of items
    @Published var StepsList = [Step]()
    
    func getAllStepData() {
        
//        StepsList.append(HealthActivity(title: "Todays Steps", amount: "2000", image: "", date: ""))
//        StepsList.append(HealthActivity(title: "Todays Steps", amount: "2000", image: "", date: ""))
        //get all step activities
        db.collection(Colname).getDocuments {snapshot, err in
            
            if err == nil {
                DispatchQueue.main.async {
                    self.StepsList = snapshot!.documents.map{d in
                        return Step(
                            docId: d.documentID,
                            title: d["title"] as? String ?? "None - cant find title",
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
    
    
    func CreateStepData(DailySteps: Step){
        
        var ref: DocumentReference? = nil
        ref = db.collection(Colname).addDocument(data: [
            "title": DailySteps.title,
            "amount": DailySteps.amount,
            "image": DailySteps.image,
            "date": DailySteps.date,
        ]) { err in
            if let err = err{
                print("Error adding Steps entry: \(err.localizedDescription)")
            } else {
                print("Added new steps entry")
                
                self.StepsList.append(
                    Step(docId: ref?.documentID ?? "", title: DailySteps.title, amount: DailySteps.amount, image: DailySteps.image, date: DailySteps.date))
            }
            
        }
        
    }
    
}
