//
//  ViewModel.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/09/02.
//

import Foundation
import Firebase
import FirebaseFirestore
import HealthKit

class ViewModel: ObservableObject {
    let db = Firestore.firestore()

    let healthStore = HKHealthStore()
    
    var waterIntake: Double = 0
    var stepsCount: Double = 0
    var calorieCount: Double = 0
    
    func createUserInDB(username: String, email: String, userId: String) {
            db.collection("users")
                .document(userId)
                .setData([
                    "username": username,
                    "email": email,
                    "steps": "",
                    "calories": "",
                    "water": ""
                ]) { err in
                    if let err = err {
                        print("There was an error writing the document: \(err)")
                    } else {
                        print("Document was writed successfully")
                    }
                }
        }
    

    
    
    
    init() {
            // Check access to user data
            if(HKHealthStore.isHealthDataAvailable()) {
                // This will be all the activity stats
                let steps = HKQuantityType(.stepCount)
                let water = HKQuantityType(.dietaryWater)
                let calories = HKQuantityType(.activeEnergyBurned)
                    
                // HealthTypes we want access to
                let healthTypes: Set = [steps, water, calories]
                
                let writeTypes: Set<HKSampleType> = [HKSampleType.quantityType(forIdentifier: .dietaryWater)!]
                
                Task {
                    do {
                        try await healthStore.requestAuthorization(toShare: writeTypes, read: healthTypes)
    
                        fetchSteps()
                        fetchWater()
                        fetchCalories()
                    } catch {
                        print("Error fetching data")
                    }
                }
            }
        }
    
        func fetchSteps() {
            let steps = HKQuantityType(.stepCount)
    
            let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
    
            let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) {_, res, err in
                guard let quantity = res?.sumQuantity(), err == nil else {
                    print("Error fetching")
                    return
                }
    
                let stepCount = quantity.doubleValue(for: .count())
    
                self.stepsCount = stepCount
            }
    
            healthStore.execute(query)
        }
    
    
   
        func fetchWater() {
            let water = HKQuantityType(.dietaryWater)
    
            let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
    
            let query = HKStatisticsQuery(quantityType: water, quantitySamplePredicate: predicate) {_, res, err in
                guard let quantity = res?.sumQuantity(), err == nil else {
                    print("Error fetching")
                    return
                }
    
                let waterAmount = quantity.doubleValue(for: .liter())
    
                self.waterIntake = waterAmount
            }
    
            healthStore.execute(query)
        }
    
    func saveWaterIntake(amountInMilliliters: Double, date: Date) {
        let healthStore = HKHealthStore()

        // Create a quantity sample for water intake
        let waterType = HKQuantityType.quantityType(forIdentifier: .dietaryWater)!
        let waterAmount = HKQuantity(unit: .liter(), doubleValue: amountInMilliliters)
        let waterSample = HKQuantitySample(type: waterType, quantity: waterAmount, start: date, end: date)

        // Save the water intake data
        healthStore.save(waterSample) { (success, error) in
            if success {
                // Water intake data saved successfully
                self.updateWaterIntake()
            } else {
                // Error occurred while saving data, handle accordingly
            }
        }
    }

    
    func fetchCalories() {
        let calories = HKQuantityType(.activeEnergyBurned)
        
        let  predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
        
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) {_, res, err in
            guard let quantity = res?.sumQuantity(), err == nil else {
                print("error fetching todays calories: \(err?.localizedDescription ?? "")")
                return
            }
            
            let calorieAmount = quantity.doubleValue(for: .kilocalorie())
          
            self.calorieCount = calorieAmount
            
        }
        
        //execute our query for the functionality to work
        healthStore.execute(query)
        
    }
    
//    func getUserData() {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("User is not authenticated.")
//            return
//        }
//        let db = Firestore.firestore()
//        let userRef = db.collection("users").document(userId)
//        print("--------------\(stepsCount)")
//    }
    
    func updateWaterIntake() {
          guard let userId = Auth.auth().currentUser?.uid else {
              print("User is not authenticated.")
              return
          }
  
          let db = Firestore.firestore()
          let userRef = db.collection("users").document(userId)
          print("--------------\(waterIntake)")
  
          userRef.updateData([
              "water": waterIntake,
              "time": Date()
          ]) { error in
              if let error = error {
                  print("Error updating water document: \(error.localizedDescription)")
              } else {
                  print("water document updated successfully.")
              }
          }
      }
    
    
    func updateFirebaseDocument() {
          guard let userId = Auth.auth().currentUser?.uid else {
              print("User is not authenticated.")
              return
          }
  
          let db = Firestore.firestore()
          let userRef = db.collection("users").document(userId)
          print("--------------\(stepsCount)")
  
          userRef.updateData([
              "steps": stepsCount,
              "water": waterIntake,
              "calories": calorieCount,
              "time": Date()
          ]) { error in
              if let error = error {
                  print("Error updating Firebase document: \(error.localizedDescription)")
              } else {
                  print("Firebase document updated successfully.")
              }
          }
      }
    }


//functon as die dag kla is maak n nuwe entry in die steps collection met die stepcount en die date en user id, dan kan ek filter met die user id en dan weeklikse data wys
    
    

    
    
    





//Hier is jou viewModel: //
////  StepsViewModel.swift
////  Hydrate
////
////  Created by Justin Koster on 2023/08/22.
////
//
//import Foundation
//import Firebase
//import FirebaseFirestore
//import HealthKit
//
//
//class StepViewModel: ObservableObject {

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
//    func updateFirebaseDocument() {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("User is not authenticated.")
//            return
//        }
//
//        print(stepsCount)
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
//}





//
//import Foundation
//import HealthKit
//import Firebase
//
//class HealthManager: ObservableObject {
//    // Instance of HealthStore
//    let healthStore = HKHealthStore()
//
//    var activeEnergy: Double = 0
//    var exerciseTime: Double = 0
//    var standTime: Double = 0
//    var hr: Double = 0
//    var restinghr: Double = 0
//    var walkinghr: Double = 0
//
//
//    init() {
//        // Check access to user data
//        if(HKHealthStore.isHealthDataAvailable()) {
//            // This will be all the activity stats
//            let calories = HKQuantityType(.activeEnergyBurned)
//            let exercise = HKQuantityType(.appleExerciseTime)
//            let stand = HKQuantityType(.appleStandTime)
//
//            // This will be all the health stats - Heart Based
//            let heartRate = HKQuantityType(.heartRate)
//            let restingHR = HKQuantityType(.restingHeartRate)
//            let walkingHR = HKQuantityType(.walkingHeartRateAverage)
//
//            // HealthTypes we want access to
//            let healthTypes: Set = [calories, exercise, stand, heartRate, restingHR, walkingHR]
//
//            Task {
//                do {
//                    try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
//
//                    // Create a DispatchGroup to wait for all queries to complete
//                    let group = DispatchGroup()
//
//                    group.enter()
//                    fetchCalories {
//                        group.leave()
//                    }
//
//                    group.enter()
//                    fetchHeartRate {
//                        group.leave()
//                    }
//
//                    group.enter()
//                    fetchStandTime {
//                        group.leave()
//                    }
//
//                    group.enter()
//                    fetchExerciseTime {
//                        group.leave()
//                    }
//
//                    group.enter()
//                    fetchRestingHeartRate {
//                        group.leave()
//                    }
//
//                    group.enter()
//                    fetchWalkingHeartRateAverage {
//                        group.leave()
//                    }
//
//                    // Wait for all functions to complete
//                    group.notify(queue: .main) {
//                        // All queries have completed, now you can update Firebase
//                        self.updateFirebaseDocument()
//                    }
//                } catch {
//                    print("Error fetching data")
//                }
//            }
//        }
//    }
//
//    func fetchCalories(completion: @escaping () -> Void) {
//        let calories = HKQuantityType(.activeEnergyBurned)
//        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
//
//        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) {_, res, err in
//            guard let amount = res?.sumQuantity(), err == nil else {
//                print("Error fetching today's calories: \(err?.localizedDescription ?? "")")
//                self.activeEnergy = 0
//                completion()
//                return
//            }
//
//            print("**************** \(amount.doubleValue(for: .kilocalorie()))")
//            self.activeEnergy = amount.doubleValue(for: .kilocalorie())
//            completion()
//        }
//
//        healthStore.execute(query)
//    }
//
//    func fetchExerciseTime(completion: @escaping () -> Void) {
//        let exerciseTime = HKQuantityType(.appleExerciseTime)
//        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
//
//        let query = HKStatisticsQuery(quantityType: exerciseTime, quantitySamplePredicate: predicate) { _, result, error in
//            guard let time = result?.sumQuantity(), error == nil else {
//                print("Error fetching exercise time: \(error?.localizedDescription ?? "")")
//                self.exerciseTime = 0
//                completion()
//                return
//            }
//
//            let minutes = time.doubleValue(for: .minute())
//            print("Exercise time today (minutes): \(minutes)")
//            self.exerciseTime = minutes
//            completion()
//        }
//
//        healthStore.execute(query)
//    }
//
//    func fetchStandTime(completion: @escaping () -> Void) {
//        let standTime = HKQuantityType(.appleStandTime)
//        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
//
//        let query = HKStatisticsQuery(quantityType: standTime, quantitySamplePredicate: predicate) { _, result, error in
//            guard let time = result?.sumQuantity(), error == nil else {
//                print("Error fetching stand time: \(error?.localizedDescription ?? "")")
//                self.standTime = 0
//                completion()
//                return
//            }
//
//            let minutes = time.doubleValue(for: .minute())
//            print("Stand time today (minutes): \(minutes)")
//            self.standTime = minutes
//            completion()
//        }
//
//        healthStore.execute(query)
//    }
//
//    func fetchHeartRate(completion: @escaping () -> Void) {
//        let heartRate = HKQuantityType(.heartRate)
//        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
//
//        let query = HKStatisticsQuery(quantityType: heartRate, quantitySamplePredicate: predicate) { _, result, error in
//            guard let heartRate = result?.averageQuantity(), error == nil else {
//                print("Error fetching heart rate: \(error?.localizedDescription ?? "")")
//                self.hr = 0
//                completion()
//                return
//            }
//
//            let bpm = heartRate.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
//            print("Average heart rate today (bpm): \(bpm)")
//            self.hr = bpm
//            completion()
//        }
//
//        healthStore.execute(query)
//    }
//
//    func fetchRestingHeartRate(completion: @escaping () -> Void) {
//        let restingHR = HKQuantityType(.restingHeartRate)
//        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
//
//        let query = HKStatisticsQuery(quantityType: restingHR, quantitySamplePredicate: predicate) { _, result, error in
//            guard let heartRate = result?.averageQuantity(), error == nil else {
//                print("Error fetching resting heart rate: \(error?.localizedDescription ?? "")")
//                self.restinghr = 0
//                completion()
//                return
//            }
//
//            let bpm = heartRate.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
//            print("Average resting heart rate today (bpm): \(bpm)")
//            self.restinghr = bpm
//            completion()
//        }
//
//        healthStore.execute(query)
//    }
//
//    func fetchWalkingHeartRateAverage(completion: @escaping () -> Void) {
//        let walkingHR = HKQuantityType(.walkingHeartRateAverage)
//        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
//
//        let query = HKStatisticsQuery(quantityType: walkingHR, quantitySamplePredicate: predicate) { _, result, error in
//            guard let heartRate = result?.averageQuantity(), error == nil else {
//                print("Error fetching walking heart rate average: \(error?.localizedDescription ?? "")")
//                self.walkinghr = 0
//                completion()
//                return
//            }
//
//            let bpm = heartRate.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
//            print("Average walking heart rate today (bpm): \(bpm)")
//            self.walkinghr = bpm
//            completion()
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
//        let db = Firestore.firestore()
//        let userRef = db.collection("users").document(userId)
//        print("--------------\(activeEnergy)")
//
//        userRef.updateData([
//            "activeEnergy": activeEnergy,
//            "exerciseTime": exerciseTime,
//            "standTime": standTime,
//            "hr": hr,
//            "restinghr": restinghr,
//            "walkinghr": walkinghr,
//            "time": Date()
//        ]) { error in
//            if let error = error {
//                print("Error updating Firebase document: \(error.localizedDescription)")
//            } else {
//                print("Firebase document updated successfully.")
//            }
//        }
//    }
//}

// Instance of HealthStore
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
