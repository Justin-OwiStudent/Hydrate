//
//  HydrateApp.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/03.
//

//import SwiftUI
//import Firebase
//import FirebaseCore
//import FirebaseAuth

//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        print("Firebase configuration successfull")
//        return true
//    }
//}
//
//@main
//struct HydrateApp: App {
//    // ... Other properties ...
//
//    // Function to upload step count data to Firebase
//    private func uploadStepCountToFirebase(stepCount: Double) {
//        let db = Firestore.firestore()
//        let collectionName = "Steps"
//
//        // Call the CreateStepData closure with the Firestore instance, collection name, and step count
//        StepViewModel.CreateStepData(db, collectionName, stepCount)
//        print("Steps data saved to DB")
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .onAppear {
//                    // Configure Firebase
//                    FirebaseApp.configure()
//
//                    // Request HealthKit authorization and save step count data when the ContentView appears
//                    let healthKitManager = HealthKit()
//                    healthKitManager.requestAuth { success, error in
//                        if success {
//                            // Authorization was successful
//                            print("HealthKit authorization granted.")
//                            healthKitManager.fetchDailySteps { stepCount, error in
//                                if let error = error {
//                                    print("Error fetching step count: \(error.localizedDescription)")
//                                } else if let stepCount = stepCount {
//                                    // Save step count to Firebase
//                                    uploadStepCountToFirebase(stepCount: stepCount)
//                                }
//                            }
//                        } else if let error = error {
//                            // Authorization failed
//                            print("HealthKit authorization denied: \(error.localizedDescription)")
//                        }
//                    }
//                }
//        }
//    }
//}

//
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        print("Firebase configuration successfull")
//        return true
//    }
//}
//
////doen n function wat die db update elke keer wat die app toe maak, of logout ?
//
//@main
//struct HydrateApp: App {
//    //register app deligate to firbase
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//
//    @ObservedObject var manager: HealthKit = HealthKit()
//
//    @State var isNotAuthenticated = true
//
//    @State var authHandler: NSObjectProtocol? = nil
//
//    @StateObject var StepsViewModel = StepViewModel()
//
//
//    init() {
//        // Initialize Firebase
//
//        // Request HealthKit authorization and save step count data on app launch
//        let healthKitManager = HealthKit()
//        healthKitManager.requestAuth { success, error in
//            if success {
//                // Authorization was successful
//                print("HealthKit authorization granted.")
//                healthKitManager.fetchDailySteps { stepCount, error in
//                    if let error = error {
//                        print("Error fetching step count: \(error.localizedDescription)")
//                    } else if let stepCount = stepCount {
//                        // Save step count to Firebase using the Create closure
//                        let db = Firestore.firestore()
//                        let collectionName = "Steps"
//
//                        // Call the CreateStepData closure with the Firestore instance, collection name, and step count
//                        StepViewModel.CreateStepData(db, collectionName, stepCount)
//                        print("Steps data saved to DB")
//                    }
//                }
//            } else if let error = error {
//                // Authorization failed
//                print("HealthKit authorization denied: \(error.localizedDescription)")
//            }
//        }
//    }
//
//
//
//
//
//
//
//
//    var body: some Scene {
//        WindowGroup {
//
//            ContentView()
//
//        }
//    }
//
//
//
//}




// if statement wat check of daar n collection is met dieselfde datum, as nie doen n ane if wat n nuwe entry maak

//
//  HydrateApp.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/03.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

//@main
//struct HydrateApp: App {
//    // ... Other properties ...
//
//    // Function to upload step count data to Firebase
//    private func uploadStepCountToFirebase(stepCount: Double) {
//        let db = Firestore.firestore()
//        let collectionName = "Steps"
//
//        // Call the CreateStepData closure with the Firestore instance, collection name, and step count
//        StepViewModel.CreateStepData(db, collectionName, stepCount)
//        print("Steps data saved to DB")
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .onAppear {
//                    // Configure Firebase
//                    FirebaseApp.configure()
//
//                    // Request HealthKit authorization and save step count data when the ContentView appears
//                    let healthKitManager = HealthKit()
//                    healthKitManager.requestAuth { success, error in
//                        if success {
//                            // Authorization was successful
//                            print("HealthKit authorization granted.")
//                            healthKitManager.fetchDailySteps { stepCount, error in
//                                if let error = error {
//                                    print("Error fetching step count: \(error.localizedDescription)")
//                                } else if let stepCount = stepCount {
//                                    // Save step count to Firebase
//                                    uploadStepCountToFirebase(stepCount: stepCount)
//                                }
//                            }
//                        } else if let error = error {
//                            // Authorization failed
//                            print("HealthKit authorization denied: \(error.localizedDescription)")
//                        }
//                    }
//                }
//        }
//    }
//}


//doen n function wat die db update elke keer wat die app toe maak, of logout ?

@main
struct HydrateApp: App {
    @ObservedObject var manager: HealthKit = HealthKit()

    @State var isNotAuthenticated = true

    @State var authHandler: NSObjectProtocol? = nil

    @StateObject var StepsViewModel = StepViewModel()


    init() {
        // Initialize Firebase]
        FirebaseApp.configure()
        print("hey the app was intialised")

        // Request HealthKit authorization and save step count data on app launch
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    // Call the CreateStepData function here
//                    let collectionName = "Steps"
//                    let stepCount: Double = 1000 // Replace with your step count
//                    StepViewModel.CreateStepData(collectionName: collectionName, stepCount: stepCount)
                    let healthKitManager = HealthKit()
                            healthKitManager.requestAuth { success, error in
                                if success {
                                    // Authorization was successful
                                    print("HealthKit authorization granted.")
                                    healthKitManager.fetchDailySteps { stepCount, error in
                                        if let error = error {
                                            print("Error fetching step count: \(error.localizedDescription)")
                                        } else if let stepCount = stepCount {
                                            // Save step count to Firebase using the Create closure
                                            let db = Firestore.firestore()
                                            let collectionName = "Steps"
                    
//                                             Call the CreateStepData closure with the Firestore instance, collection name, and step count
                                            StepViewModel.CreateStepData(collectionName: collectionName, stepCount: stepCount)
                                            print("Steps data saved to DB")
                                        }
                                    }
                                } else if let error = error {
                                    // Authorization failed
                                    print("HealthKit authorization denied: \(error.localizedDescription)")
                                }
                            }
                            let db = Firestore.firestore()
                            let collectionName = "Steps"
                    
                             
                            StepViewModel.CreateStepData(collectionName: collectionName, stepCount: 000)
                    
                            print("This is the end of the initialisation")
                }

        }
    }



}




// if statement wat check of daar n collection is met dieselfde datum, as nie doen n ane if wat n nuwe entry maak

