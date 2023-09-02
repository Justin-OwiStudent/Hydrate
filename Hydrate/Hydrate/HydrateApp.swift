import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

//doen n function wat die db update elke keer wat die app toe maak, of logout ?

@main
struct HydrateApp: App {
    @ObservedObject var manager: HealthKit = HealthKit()

    @State var isNotAuthenticated = true

    @State var authHandler: NSObjectProtocol? = nil

    @StateObject var VM = ViewModel()


    init() {
        // Initialize Firebase
        FirebaseApp.configure()
        print("hey the app was intialised")

        // Request HealthKit authorization and save step count data on app launch
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    
                    VM.updateFirebaseDocument()
                    // Call the CreateStepData function here
//                    let collectionName = "Steps"
//                    let stepCount: Double = 1000 // Replace with your step count
//                    StepViewModel.CreateStepData(collectionName: collectionName, stepCount: stepCount)
//                    let healthKitManager = HealthKit()
//                            healthKitManager.requestAuth { success, error in
//                                if success {
//                                    // Authorization was successful
//                                    print("HealthKit authorization granted.")
//                                    healthKitManager.fetchDailySteps { stepCount, error in
//                                        if let error = error {
//                                            print("Error fetching step count: \(error.localizedDescription)")
//                                        } else if let stepCount = stepCount {
//                                            // Save step count to Firebase using the Create closure
//                                            let db = Firestore.firestore()
//                                            let collectionName = "Steps"
//
////                                             Call the CreateStepData closure with the Firestore instance, collection name, and step count
//                                            StepViewModel.CreateStepData(collectionName: collectionName, stepCount: stepCount)
//                                            print("Steps data saved to DB")
//                                        }
//                                    }
//                                } else if let error = error {
//                                    // Authorization failed
//                                    print("HealthKit authorization denied: \(error.localizedDescription)")
//                                }
//                            }
//                            let db = Firestore.firestore()
//                            let collectionName = "Steps"
//
//
//                            StepViewModel.CreateStepData(collectionName: collectionName, stepCount: 000)
//
//                            print("This is the end of the initialisation")
                }

        }
    }



}




// if statement wat check of daar n collection is met dieselfde datum, as nie doen n ane if wat n nuwe entry maak

