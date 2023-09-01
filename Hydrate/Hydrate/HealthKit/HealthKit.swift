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
    
    
    init(){
        
        //check if we have access
        if(HKHealthStore.isHealthDataAvailable()) {
            
            //get the health stats we want to use
            let steps = HKQuantityType(.stepCount)
            let calories = HKQuantityType(.activeEnergyBurned)
            
            let healthTypes: Set = [steps, calories]
            
            Task {
                do {
                    try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
                    print("HealthKit Auth Apporoved")
                    
                    
                    //TODO: execute a fetch of each stat
                    fetchDailySteps()
                    fetchDailyCalories()
                    
                } catch  {
                    print("Error retreiving HealthKit")
                }
            }
            
        }
        
    }
    
    // fetch steps
    func fetchDailySteps() {
        
        let steps = HKQuantityType(.stepCount)
        
        let  predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
        
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) {
            _, result, error in
            
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("error fetching todays steps: \(error?.localizedDescription ?? "")")
                return
            }
            
            let stepCount = quantity.doubleValue(for: .count())
            print("Total steps: \(stepCount)")
            
            self.StepsActivity.append(Step(docId: "", title: "Daily steps", amount: "\(stepCount.rounded(.towardZero))", image: "figure.walk.diamond",  date: ""))
        }
        
        //execute our query for the functionality to work
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
    
    
    
    
    
}
