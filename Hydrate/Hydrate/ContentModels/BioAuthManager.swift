//
//  BioAuthManager.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/17.
//

import Foundation
import LocalAuthentication //faceID and touch id

class BioAuthManager: ObservableObject {
    private var context = LAContext()
    private var canEvaluatePolicy = false
    @Published var biometricType: LABiometryType = .none //see which tyoe we have
    
    @Published var isAuthenticated = false
    
    @Published var showAlert = false
    @Published var errorMessage = ""
    
    init(){
        getBiometricType()
    }
    
    
    //check do i have all the requirments needed to run this auth functionality
    func getBiometricType(){
        canEvaluatePolicy =
            context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        biometricType = context.biometryType
    }
    
    func authenticateWithBiometrics() async {
        if(canEvaluatePolicy){
            
            let reason = "Login with biometric to keep data safe"
            
            do {
                let success = try await
                context.evaluatePolicy(.deviceOwnerAuthentication,
                localizedReason: reason)
                
                if(success){
                    DispatchQueue.main.async{
                        //update auth state
                        self.isAuthenticated = true
                        print("successfully authenticated")
                    }
                }
//                else {
//                    self.isAuthenticated = false
//                }
                
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async{
                    //update auth state
                    self.isAuthenticated = false
//                    self.biometricType = .none //use credentials on faceID Fail try again
                    
                    self.showAlert = true
                    self.errorMessage = error.localizedDescription
                }
            }
            
        }
    }
    
}
