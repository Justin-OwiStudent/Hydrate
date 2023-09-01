//
//  BioAuthView.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/17.
//

import SwiftUI

struct BioAuthView: View {
    @StateObject var authManager = BioAuthManager()
    
    var body: some View {
        if(authManager.isAuthenticated){
            ContentView()
        } else {
            VStack{
                Text("Biometric authentication")
                    .padding()
                    .foregroundColor(.black)
                
                Button(action: {
                    //todo: bio auth
                    if(authManager.biometricType == .none){
                        
                    } else {
                        Task.init{
                            await
                            authManager.authenticateWithBiometrics()
                        }
                        
                    }
                }) {
                    HStack{
                        //change button UI based on device capabilities
                        if(authManager.biometricType == .faceID){
                            Image(systemName: "faceid")
                            Text("Login with FaceID")
                        } else if(authManager.biometricType == .touchID){
                            Image(systemName: "touchid")
                            Text("Login with touchid")
                        } else {
                            Image(systemName: "ellipsis.rectangle")
                            Text("Login with credentials")
                        }
                        
                        
                    }
                    .padding()
                    .padding(.horizontal)
                    .background(.white)
                    .cornerRadius(30)
                    .shadow(radius: 5)
                }
                .foregroundColor(.black)
                .alert(isPresented: $authManager.showAlert){
                    Alert(title: Text("Error"), message: Text(authManager.errorMessage), dismissButton: .default(Text("OK")))
                }
            }

        }
               
    
    }
}

struct BioAuthView_Previews: PreviewProvider {
    static var previews: some View {
        BioAuthView()
    }
}
