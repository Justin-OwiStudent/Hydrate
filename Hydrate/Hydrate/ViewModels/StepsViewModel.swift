////
////  StepsViewModel.swift
////  Hydrate
////
////  Created by Justin Koster on 2023/08/22.
////
//
//import Foundation
//import Firebase
//import FirebaseFirestore
//
//
//class StepViewModel: ObservableObject {
//
//    let db = Firestore.firestore()
//
//    let Colname = "Steps"
//
//    //list of items
//    @Published var StepsList = [Step]()
//
//    func getAllStepData() {
//
////        StepsList.append(HealthActivity(title: "Todays Steps", amount: "2000", image: "", date: ""))
////        StepsList.append(HealthActivity(title: "Todays Steps", amount: "2000", image: "", date: ""))
//        //get all step activities
//        db.collection(Colname).getDocuments {snapshot, err in
//
//            if err == nil {
//                DispatchQueue.main.async {
//                    self.StepsList = snapshot!.documents.map{d in
//                        return Step(
//                            docId: d.documentID,
//                            title: d["title"] as? String ?? "None - cant find title",
//                            stepCount: d["stepCount"] as? String ?? "None - cant find stepCount",
//                            date: d["date"] as? String ?? "None - cant find date"
//                        )
//                    }
//                }
//            } else {
//                print(err?.localizedDescription ?? "Something went wrong while getting docs.")
//            }
//
//        }
//
//    }
//
//
//
//
////    func CreateStepData(DailySteps: Step){
////
////        var ref: DocumentReference? = nil
////        ref = db.collection(Colname).addDocument(data: [
////            "title": DailySteps.title,
////            "amount": DailySteps.amount,
////            "image": DailySteps.image,
////            "date": DailySteps.date,
////        ]) { err in
////            if let err = err{
////                print("Error adding Steps entry: \(err.localizedDescription)")
////            } else {
////                print("Added new steps entry")
////
////                self.StepsList.append(
////                    Step(docId: ref?.documentID ?? "", title: DailySteps.title, amount: DailySteps.amount, image: DailySteps.image, date: DailySteps.date))
////            }
////
////        }
////
////    }
////
//
//
//
//
//
////    static var CreateStepData: (Double) -> Void = { stepCount in
////         // Assuming you have Firebase configured and a reference to your Realtime Database
////        let ref = db.collection(Colname)
////
////         // Assuming you have a user ID or some identifier for the user
//////         let userID = "your_user_id"
////
////         // Create a dictionary to store the step count data
////         let data: [String: Any] = [
//////             "userID": userID,
////             "amount": stepCount,
////             "date": FieldValue.serverTimestamp()
////         ]
////
////         // Push the data to Firebase to generate a unique key
////         ref.childByAutoId().setValue(data) { (error, ref) in
////             if let error = error {
////                 print("Error saving step count to Firebase: \(error.localizedDescription)")
////             } else {
////                 print("Step count saved to Firebase with key: \(ref.key ?? "N/A")")
////             }
////         }
////     }
//
//
//
//
//
////    static var CreateStepData: (Firestore, String, Double) -> Void = { firestore, collectionName, stepCount in
////          // Assuming you have Firebase Firestore configured and a reference to your Firestore collection
////          let ref = firestore.collection(collectionName)
////
////          // Create a dictionary to store the step count data
////          let data: [String: Any] = [
////              "amount": stepCount,
////              "date": FieldValue.serverTimestamp()
////          ]
////
////          // Add the data to the Firestore collection
////          ref.addDocument(data: data) { error in
////              if let error = error {
////                  print("Error saving step count to Firestore: \(error.localizedDescription)")
////              } else {
////                  print("Step count saved to Firestore")
////              }
////          }
////      }
//
//    static var CreateStepData: (Firestore, String, Double) -> Void = { firestore, collectionName, stepCount  in
//        let db = Firestore.firestore()
//        let collectionName = "Steps"
//
//        // Assuming you have a user ID or some identifier for the user
////        let userID = "your_user_id"
//
//        // Create a dictionary to store the step count data
//        let data: [String: Any] = [
////            "userID": userID,
//            "stepCount": stepCount,
//            "timestamp": FieldValue.serverTimestamp()
//        ]
//
//        // Get a reference to the Firestore collection
//        let ref = db.collection(collectionName)
//
//        // Add the data to the Firestore collection
//        ref.addDocument(data: data) { error in
//            if let error = error {
//                print("Error saving step count to Firestore: \(error.localizedDescription)")
//            } else {
//                print("Step count saved to Firestore")
//            }
//        }
//    }
//}

//
//  StepsViewModel.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/22.
//


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
                            stepCount: d["stepCount"] as? String ?? "None - cant find stepCount",
                            date: d["date"] as? String ?? "None - cant find date"
                        )
                    }
                }
            } else {
                print(err?.localizedDescription ?? "Something went wrong while getting docs.")
            }

        }

    }




    static func CreateStepData(collectionName: String, stepCount: Double) {
        let db = Firestore.firestore()
        let uuidString = UUID().uuidString
        // Create a dictionary to store the step count data
        let data: [String: Any] = [
            "id": uuidString,
            "stepCount": stepCount,
            "timestamp": Date()
        ]

        db
            .collection("Steps")
            .document()
            .setData(data) { err in
                if let err = err {
                    print("error creating steps \(err.localizedDescription)")
                } else {
                    print("Document saved")
                }
            }
    }

}


//  StepsViewModel.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/22.
//

//
//  StepsViewModel.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/22.
//

//import Foundation
//import Firebase
//import FirebaseFirestore
//import HealthKit
//
//
//class StepViewModel: ObservableObject {
//
//    // Instance of HealthStore
//    let healthStore = HKHealthStore()
//
//    var waterIntake: Double = 0
//    var stepsCount: Double = 0
//
//    init() {
//        // Check access to user data
//        if(HKHealthStore.isHealthDataAvailable()) {
//            // This will be all the activity stats
//            let steps = HKQuantityType(.stepCount)
//            let water = HKQuantityType(.dietaryWater)
//
//            // HealthTypes we want access to
//            let healthTypes: Set = [steps, water]
//
//            Task {
//                do {
//                    try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
//
//                    fetchSteps()
//                    fetchWater()
//                } catch {
//                    print("Error fetching data")
//                }
//            }
//        }
//    }
//
//    func fetchSteps() {
//        let steps = HKQuantityType(.stepCount)
//
//        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
//
//        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) {_, res, err in
//            guard let quantity = res?.sumQuantity(), err == nil else {
//                print("Error fetching")
//                return
//            }
//
//            let stepCount = quantity.doubleValue(for: .count())
//
//            self.stepsCount = stepCount
//        }
//
//        healthStore.execute(query)
//    }
//
//    func fetchWater() {
//        let water = HKQuantityType(.dietaryWater)
//
//        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
//
//        let query = HKStatisticsQuery(quantityType: water, quantitySamplePredicate: predicate) {_, res, err in
//            guard let quantity = res?.sumQuantity(), err == nil else {
//                print("Error fetching")
//                return
//            }
//
//            let waterAmount = quantity.doubleValue(for: .liter())
//
//            self.waterIntake = waterAmount
//        }
//
//        healthStore.execute(query)
//    }
//
//    func updateFirebaseDocument() {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("User is not authenticated.")
//            return
//        }
//
//        print(stepsCount)
//        print(waterIntake)
//
////        userRef.updateData([
////            "steps": ste
////            "time": Date()
////        ]) { error in
////            if let error = error {
////                print("Error updating Firebase document: \(error.localizedDescription)")
////            } else {
////                print("Firebase document updated successfully.")
////            }
////        }
//    }
//
//
//
//
//
//
//}


