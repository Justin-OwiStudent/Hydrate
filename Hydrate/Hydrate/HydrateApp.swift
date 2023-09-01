//
//  HydrateApp.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/03.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Firebase configuration successfull")
        return true
    }
}

//doen n function wat die db update elke keer wat die app toe maak, of logout ?

@main
struct HydrateApp: App {
    //register app deligate to firbase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State var isNotAuthenticated = true
    
    @State var authHandler: NSObjectProtocol? = nil
    
    @StateObject var StepsViewModel = StepViewModel()
    
    var body: some Scene {
        WindowGroup {
            //ifstatement for is not authed then do something
            //doen eers onboarding en dan die login(based op auth) as kla ge auth dan gan net contentview toe, if statement
            //            BioAuthView()
            
            
            ContentView()
            //                .onAppear{
            //                    //check if a valid user logged on
            //                    self.authHandler = Auth.auth().addStateDidChangeListener { auth, user in
            //                        print("checking auth state")
            //                        if(user != nil) {
            //                            isNotAuthenticated = false
            //                            print("currentUser" + (user?.uid ?? ""))
            //                        } else {
            //                            print("removing auth state checker...")
            //                            isNotAuthenticated = true
            //                        }
            //                    }
            //                }
            //                .onDisappear{
            //                    //stop listening to auth
            //                    Auth.auth().removeStateDidChangeListener(authHandler!)
            //                }
            //                .fullScreenCover(isPresented: $isNotAuthenticated) {
            //                    AuthenticationView()
            //                }
        }
    }
}
