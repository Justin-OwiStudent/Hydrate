////
////  AuthModel.swift
////  Hydrate
////
////  Created by Justin Koster on 2023/09/03.
////
//
//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//
//class AuthViewModel: ObservableObject {
//    let db = Firestore.firestore()
//    let auth = Auth.auth(
//   
////    @Published var userDetails: User?
//    
//    func getUserDetails() {
//            let userId = getUserId()
//            
//            db.collection("users").document(userId).getDocument { [weak self] document, error in
//                guard let self = self else { return }
//                
//                if let document = document, document.exists {
//                    if let userData = try? document.data(as: User.self) {
//                        self.userDetails = userData
//                        print("The user data should have decoded")
//                    } else {
//                        print(error?.localizedDescription ?? "Problem with decoding document")
//                    }
//                }
//            }
//        }
//        
//        func getUserId() -> String {
//            return Auth.auth().currentUser?.uid ?? "No user id found"
//        }
//    
//
//    
//}
