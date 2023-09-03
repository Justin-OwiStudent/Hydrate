//
//  UserDataManager.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/09/03.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class UserDataManager: ObservableObject {
    @Published var user: UserData?
    private var listener: ListenerRegistration?

    init() {
        fetchUserData()
    }

    func fetchUserData() {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            let userRef = db.collection("users").document(user.uid)

            listener = userRef.addSnapshotListener { (document, error) in
                if let document = document, document.exists {
                    // Parse and store user data here
                    self.user = try? document.data(as: UserData.self)
                } else {
                    print("User document does not exist")
                }
            }
        }
    }
}



