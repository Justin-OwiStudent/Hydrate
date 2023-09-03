//
//  UserViewModel.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/09/03.
//

import SwiftUI
import Firebase
import FirebaseFirestore

@MainActor
class UserViewModel: ObservableObject {
   
    
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    
    @Published var userDetails: User
    
    
    func getUserDetails() {
            let userId = getUserId()
            
            db.collection("users").document(userId).getDocument { [weak self] document, error in
                guard let self = self else { return }
                
                if let document = document, document.exists {
                    if let userData = try? document.data(as: User.self) {
                        self.userDetails = userData
                        print("The user data should have decoded")
                    } else {
                        print(error?.localizedDescription ?? "Problem with decoding document")
                    }
                }
            }
        }
        
        func getUserId() -> String {
            return Auth.auth().currentUser?.uid ?? "No user id found"
        }
    
    
//    func loadCurrentUser() throws {
//        self.user = try AuthenticationMana
//    }
    
//    init() {
//        fetchUsers()
//    }
    
//    func fetchCurrentUser() {
//        guard let uid =
//    }

//    func fetchUsers() {
//        // Create a reference to the "users" collection in Firestore
//        let usersRef = db.collection("users")
//
//        // Add a snapshot listener to the collection to get real-time updates
//        listener = usersRef.addSnapshotListener { (querySnapshot, error) in
//            if let error = error {
//                print("Error fetching users: \(error.localizedDescription)")
//                return
//            }
//
//            // Process the querySnapshot and update the users array
//            if let documents = querySnapshot?.documents {
//                self.users = documents.compactMap { document in
//                    do {
//                        // Parse each document into a UserData object
//                        let userData = try document.data(as: UserData.self)
//                        return userData
//                    } catch {
//                        print("Error decoding user data: \(error.localizedDescription)")
//                        return nil
//                    }
//                }
//            }
//        }
//    }

//
//    deinit {
//        // Remove the snapshot listener when the ViewModel is deallocated
//        listener?.remove()
//    }
}
