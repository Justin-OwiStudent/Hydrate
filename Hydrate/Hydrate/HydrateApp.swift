import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

//doen n function wat die db update elke keer wat die app toe maak, of logout ?

@main
struct HydrateApp: App {
    @ObservedObject var manager: HealthKit = HealthKit()
    @StateObject var userVM = UserViewModel() // Create an instance of UserDataManager

    

    @State var isNotAuthenticated = true

    @State var authHandler: NSObjectProtocol? = nil

    @StateObject var VM = ViewModel()


    init() {
        FirebaseApp.configure()
        print("hey the app was intialised")
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .onAppear{
                        VM.updateFirebaseDocument()
                    }
            }
            .environmentObject(userVM)
          

        }
    }



}




// if statement wat check of daar n collection is met dieselfde datum, as nie doen n ane if wat n nuwe entry maak

