
import Foundation
import Firebase
import FirebaseFirestore
import HealthKit
import WidgetKit


class ViewModel: ObservableObject {
    let db = Firestore.firestore()

    let healthStore = HKHealthStore()
    
    var waterIntake: Double = 0
    var stepsCount: Double = 0
    var calorieCount: Double = 0
    
    let userViewModel = UserViewModel()
    
    private var updateTimer: Timer?

    


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
      
        if HKHealthStore.isHealthDataAvailable() {
            
            let steps = HKQuantityType(.stepCount)
            let water = HKQuantityType(.dietaryWater)
            let calories = HKQuantityType(.activeEnergyBurned)
            
           
            let healthTypes: Set = [steps, water, calories]
            
            let writeTypes: Set<HKSampleType> = [HKSampleType.quantityType(forIdentifier: .dietaryWater)!]
            
            let dispatchGroup = DispatchGroup()
            
            Task {
                do {
                    try await healthStore.requestAuthorization(toShare: writeTypes, read: healthTypes)
                    
                  
                    dispatchGroup.enter()
                    fetchSteps()
                    
                    dispatchGroup.enter()
                    fetchWater()
                    
                    dispatchGroup.enter()
                    fetchCalories()
                    
                    
                  
                    dispatchGroup.notify(queue: .main) {
                        
                        
//                        self.updateWaterIntake()
                        
                        self.startListeningForUpdates()
                        self.startListeningForHealthKitUpdates()
                        
                        self.startObservingHealthKitChanges()

                    }
                } catch {
                    print("Error fetching data")
                }
            }
        }
        
    }

    func startObservingHealthKitChanges() {
        // Create and configure a timer to periodically check for HealthKit updates
        updateTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            guard let self = self else {
                return // Ensure self is non-nil
            }

            self.fetchSteps()
            self.fetchWater()
            self.fetchCalories()
            
            // Update Firebase document and other necessary tasks here...
            self.updateFirebaseDocument()
        }
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

       
        guard let waterType = HKQuantityType.quantityType(forIdentifier: .dietaryWater) else {
            print("Error: HKQuantityType for dietaryWater is not available.")
            return
        }

        guard HKHealthStore.isHealthDataAvailable() else {
            print("Error: HealthKit data is not available on this device.")
            return
        }

       
        healthStore.requestAuthorization(toShare: [waterType], read: nil) { (success, error) in
            if success {
                
                let waterAmount = HKQuantity(unit: .liter(), doubleValue: amountInMilliliters)
                let waterSample = HKQuantitySample(type: waterType, quantity: waterAmount, start: date, end: date)

               
                healthStore.save(waterSample) { (saveSuccess, saveError) in
                    if saveSuccess {
                        
                        self.updateWaterIntake()
                        print("Water intake updated successfully")
                    } else {
                        if let saveError = saveError {
                            print("Error saving water intake: \(saveError.localizedDescription)")
                        } else {
                            print("Unknown error saving water intake")
                        }
                       
                    }
                }
            } else {
                if let error = error {
                    print("Authorization error: \(error.localizedDescription)")
                } else {
                    print("Unknown authorization error")
                }
           
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
            WidgetCenter.shared.reloadAllTimelines()

          }
    
    
        func updateFirebaseDocument() {
              guard let userId = Auth.auth().currentUser?.uid else {
                  print("User is not authenticated.")
                  return
              }
      
              let db = Firestore.firestore()
              let userRef = db.collection("users").document(userId)
//              print("--------------\(stepsCount)")
      
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


