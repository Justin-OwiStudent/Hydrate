//
//  AuthenticationView.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/10.
//

import SwiftUI
import FirebaseAuth

struct AuthenticationView: View {
    
    @State var email = ""
    @State var password = ""
    @State var username = ""
    @State var showingLoginScreen = false
    @State var showingRegister = false
    @State var uid = ""
    
    @State var errorMessage = ""
    
    @StateObject var VM = ViewModel()
    
    @State private var LoginAlert = false
    @State private var SignUpAlert = false
    
    @State private var isShowingAlert = false
    @State private var isShowingError = false
    
    
    //login
    func LoginUser(){
        Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
         
            if(error != nil) {
                print(error?.localizedDescription ?? "login error")
                errorMessage = error?.localizedDescription ?? "something went wrong"
                isShowingError = true
            }
            if(authResult != nil){
                print("logged in user" + (authResult?.user.uid ?? ""));
                _ = authResult?.user.uid
                
                LoginAlert = true
                showingLoginScreen = true
            }
        }
    }
    
  
    

    
    var body: some View {
        
        
        NavigationView{
        ZStack {
            CustomColor.Background
                .ignoresSafeArea()
                .navigationTitle("Log In")
                .navigationBarBackButtonHidden(true)
            
            VStack{
            
                
                TextField("Email", text: $email)
                    .padding()
                    .background(.white)
                    .foregroundColor(.black)
                    .frame(width: 300)
                    .cornerRadius(15)
                
                TextField("Password", text: $password)
                    .padding()
                    .background(.white)
                    .frame(width: 300)
                    .cornerRadius(15)
                    .foregroundColor(.black)
                
//                Text(errorMessage)
//                    .padding()
//                    .foregroundColor(.red)
//                    .multilineTextAlignment(.center)
                
               
                
                
                
                Button(action: {
                    LoginUser()
                }) {
                    Text("Login")
                        .fontWeight(.bold)
                        .frame(width: 250, height: 30)
                        .background(.thinMaterial)
                        .cornerRadius(15)
                }
                
                
                Button(action: {
                    showingRegister.toggle()
                }) {
                    Text("Create an account")
                        .fontWeight(.bold)
                        .frame(width: 250, height: 30)
                        .cornerRadius(15)
                }
                
                
                
                NavigationLink(destination: ManView(), isActive: $showingLoginScreen) {
                    EmptyView()
                }
                
                NavigationLink(destination: RegisterView(), isActive: $showingRegister) {
                    EmptyView()
                }
            
            }
            .alert(isPresented: $LoginAlert) {
                Alert(title: Text("Logged in!"),
                      message: Text("Logged in successfully"),
                      primaryButton: .default(Text("OK")) {
                          // Code to execute when the OK button is tapped
                          self.LoginAlert = false // Close the alert
                      },
                      secondaryButton: .cancel(Text("Cancel"))
                )
            }
            
            
        }
        .alert(isPresented: $isShowingError) {
                    Alert(
                        title: Text("Error loging in"),
                        message: Text(errorMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
    }
        .navigationBarBackButtonHidden(true)
    
    }

    
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
