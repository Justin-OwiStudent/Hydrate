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
    
    let userViewModel = UserViewModel()
    
    
//    UserDefaults(suiteName: "group.Hydrate")?.set(waterIntakeValue, forKey: "WaterIntakeValue")

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
        if HKHealthStore.isHealthDataAvailable() {
            // This will be all the activity stats
            let steps = HKQuantityType(.stepCount)
            let water = HKQuantityType(.dietaryWater)
            let calories = HKQuantityType(.activeEnergyBurned)
            
            // HealthTypes we want access to
            let healthTypes: Set = [steps, water, calories]
            
            let writeTypes: Set<HKSampleType> = [HKSampleType.quantityType(forIdentifier: .dietaryWater)!]
            
            let dispatchGroup = DispatchGroup() // Create a dispatch group
            
            Task {
                do {
                    try await healthStore.requestAuthorization(toShare: writeTypes, read: healthTypes)
                    
                    // Enter the dispatch group for each data fetch
                    dispatchGroup.enter()
                    fetchSteps()
                    
                    dispatchGroup.enter()
                    fetchWater()
                    
                    dispatchGroup.enter()
                    fetchCalories()
                    // Wait for all data fetching to complete
                    dispatchGroup.notify(queue: .main) {
                        // Now you have the initial data, you can update Firebase or perform other actions
                        // For example, call updateFirebaseDocument() here
                    }
                } catch {
                    print("Error fetching data")
                }
            }
        }
        startListeningForUpdates()
        startListeningForHealthKitUpdates()
    }


    
    func startListeningForUpdates() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User is not authenticated.")
            return
        }

        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userId)

        userRef.addSnapshotListener { [weak self] documentSnapshot, error in
            guard let self = self else { return }

            if let error = error {
                print("Error listening for updates: \(error.localizedDescription)")
                return
            }

            if let document = documentSnapshot, document.exists {
                if let data = try? document.data(as: User.self) {
                    self.userViewModel.userData = data
                }
            }
        }
    }
    func startListeningForHealthKitUpdates() {
         // Set up observers for HealthKit data changes
         let typesToObserve: Set<HKQuantityType> = [
             HKObjectType.quantityType(forIdentifier: .stepCount)!,
             HKObjectType.quantityType(forIdentifier: .dietaryWater)!,
             HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
         ]

         typesToObserve.forEach { type in
             let query = HKObserverQuery(sampleType: type, predicate: nil) { [weak self] query, completionHandler, error in
                 guard let self = self else { return }
                 
                 if let error = error {
                     print("Error observing HealthKit data changes: \(error.localizedDescription)")
                     return
                 }

                 // Handle the HealthKit data change and update Firestore
                 self.updateFirebaseDocument()
                 completionHandler()
             }

             healthStore.execute(query)
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
                    print("water intake updated succesfully")
                } else {
                    print("error updating water intake, please try again later")
                    // Error occurred while saving data, handle accordingly
                }
            }
        }
 
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
            if let sharedUserDefaults = UserDefaults(suiteName: "group.Hydrate") {
                        sharedUserDefaults.set(waterIntake, forKey: "WaterIntakeValue")
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


