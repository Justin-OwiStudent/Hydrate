import Foundation
import Firebase
import FirebaseFirestore
import Combine 

class UserViewModel: ObservableObject {
    private let db = Firestore.firestore()
    
    // @Published properties to make them observable
    @Published var userLoggedIn: Bool = false
    @Published var userData: User?
    
    func getUserDetails() {
        let userId = getUserId()
        
        db.collection("users").document(userId).getDocument { [weak self] document, error in
            guard let self = self else { return }
            
            if let document = document, document.exists {
                if let data = try? document.data(as: User.self) {
                    print("The user data should have decoded")
                    print("-----------\(data)")
                    
                    // Update the userData property using self
                    self.userData = data
                } else {
                    print(error?.localizedDescription ?? "Problem with decoding document")
                }
            }
        }
    }
    
    func getUserId() -> String {
        print(" user id that will be used \(Auth.auth().currentUser?.uid ?? "")")
        return Auth.auth().currentUser?.uid ?? "No user id found"
    }
    
    func signOut() async {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func hasUserLoggedInPrev() -> Bool {
        if Auth.auth().currentUser?.uid != nil {
            // userLoggedIn = true
            print("Logged")
            return true
        } else {
            // userLoggedIn = false
            print("Not logged")
            return false
        }
    }
}
