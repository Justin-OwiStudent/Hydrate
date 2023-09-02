//
//  HealthKit.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/16.
//

import Foundation
import HealthKit
import SwiftUI


//manage healthKit info
class HealthKit: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    //array with tracked health activity data
    @Published var activities: [HealthActivity] = []
    @Published var StepsActivity: [Step] = []
    @Published var CaloriesActivity: [Calorie] = []
    @Published var WaterActivity: [Water] = []
    
    
//    init(){
//
//        //check if we have access
//      requestAuth()
//
//    }
    
    
    func requestAuth(completion: @escaping (Bool, Error?) -> Void) {
        if HKHealthStore.isHealthDataAvailable() {
            // Define the health types you want to read
            let steps = HKQuantityType(.stepCount)
            let calories = HKQuantityType(.activeEnergyBurned)
            
            let healthTypes: Set = [steps, calories]
            
            Task {
                do {
                    try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
                    print("HealthKit Auth Approved")
                    
                    // TODO: Execute a fetch of each stat
                    fetchDailySteps { success, error in
                        if let error = error {
                            print("Error fetching daily steps: \(error.localizedDescription)")
                            completion(false, error)
                        } else {
                            // Successfully fetched daily steps
//                            fetchDailyCalories { success, error in
//                                if let error = error {
//                                    print("Error fetching daily calories: \(error.localizedDescription)")
//                                    completion(false, error)
//                                } else {
//                                    // Successfully fetched daily calories
//                                    completion(true, nil)
//                                }
//                            }
                        }
                    }
                    
                } catch  {
                    print("Error retrieving HealthKit")
                    completion(false, error)
                }
            }
        }
    }

    
//    func requestAuth() {
//        if(HKHealthStore.isHealthDataAvailable()) {
//
//            //get the health stats we want to use
//            let steps = HKQuantityType(.stepCount)
//            let calories = HKQuantityType(.activeEnergyBurned)
//
//            let healthTypes: Set = [steps, calories]
//
//            Task {
//                do {
//                    try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
//                    print("HealthKit Auth Apporoved")
//
//
//                    //TODO: execute a fetch of each stat
//                    fetchDailySteps()
//                    fetchDailyCalories()
//
//                } catch  {
//                    print("Error retreiving HealthKit")
//                }
//            }
//
//        }
//    }
    
    
    
    
    
    // fetch steps
//    func fetchDailySteps() {
//
//        let steps = HKQuantityType(.stepCount)
//
//
//        let  predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
//
//        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) {
//            _, result, error in
//
//            guard let quantity = result?.sumQuantity(), error == nil else {
//                print("error fetching todays steps: \(error?.localizedDescription ?? "")")
//                return
//            }
//
//            let stepCount = quantity.doubleValue(for: .count())
//            print("Total steps: \(stepCount)")
//
//            self.StepsActivity.append(Step(docId: "", title: "Daily steps", amount: "\(stepCount.rounded(.towardZero))", image: "figure.walk.diamond",  date: ""))
//        }
//
//        //execute our query for the functionality to work
//        healthStore.execute(query)
//
//    }
    
    func fetchDailySteps(completion: @escaping (Double?, Error?) -> Void) {
        let stepCount = HKQuantityType(.stepCount)
        
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
        
        let query = HKStatisticsQuery(quantityType: stepCount, quantitySamplePredicate: predicate) {
            _, result, error in
            
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("Error fetching today's steps: \(error?.localizedDescription ?? "")")
                completion(nil, error)
                return
            }
            
            let stepCount = quantity.doubleValue(for: .count())
            print("Total steps: \(stepCount)")
            
            completion(stepCount, nil)
        }
        
        // Execute our query for the functionality to work
        healthStore.execute(query)
    }

    
     
    
    
    
    
    
    func fetchDailyCalories() {
        
        let calories = HKQuantityType(.activeEnergyBurned)
        
        let  predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
        
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) {
            _, result, error in
            
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("error fetching todays calories: \(error?.localizedDescription ?? "")")
                return
            }
            
            let calorieTotal = quantity.doubleValue(for: .kilocalorie())
            print("Total Calories: \(calorieTotal)")
            
            self.CaloriesActivity.append(Calorie(docId: "", title: "Calories Burnt", amount: "\(calorieTotal.rounded(.towardZero))", image: "flame", date: ""))
            
        }
        
        //execute our query for the functionality to work
        healthStore.execute(query)
        
    }
    
    
    func fetchDailyWater() {
        
        let water = HKQuantityType(.dietaryWater)
        
        let  predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
        
        let query = HKStatisticsQuery(quantityType: water, quantitySamplePredicate: predicate) {
            _, result, error in
            
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("error fetching todays water: \(error?.localizedDescription ?? "")")
                return
            }
            
            let waterTotal = quantity.doubleValue(for: .count())
            print("Total Calories: \(waterTotal)")
            
            self.WaterActivity.append(Water(docId: "", title: "Water Intake", amount: "\(waterTotal.rounded(.towardZero))", date: ""))
            
        }
        
        //execute our query for the functionality to work
        healthStore.execute(query)
        
    }
    
    
    
    
    
}
