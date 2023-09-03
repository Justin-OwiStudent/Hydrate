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
    @State var uid = ""
    
    @State var errorMessage = ""
    
    @StateObject var VM = ViewModel()
    
    @State private var LoginAlert = false
    @State private var SignUpAlert = false
    
    @State private var isShowingAlert = false
    
    
    //login
    func LoginUser(){
        Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
         
            if(error != nil) {
                print(error?.localizedDescription ?? "login error")
                errorMessage = error?.localizedDescription ?? "something went wrong"
            }
            if(authResult != nil){
                print("logged in user" + (authResult?.user.uid ?? ""));
                _ = authResult?.user.uid
                
                showingLoginScreen = true
                
                
                    
            }
        }
    }
    
    //signup
    func SignUpUser(){
        //check so that emial of password is not nil
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if(error != nil) {
                print(error?.localizedDescription ?? "Signup error")
                errorMessage = error?.localizedDescription ?? "something went wrong"
            }
            if(authResult != nil){
                print("Signed up user" + (authResult?.user.uid ?? ""));
                VM.createUserInDB(username: self.username, email: self.email, userId: authResult?.user.uid ?? "" )
                
                SignUpAlert = true
               
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
                
                TextField("Username", text: $username)
                    .padding()
                    .background(.white)
                    .foregroundColor(.black)
                    .frame(width: 300)
                    .cornerRadius(15)
                
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
                
                Text(errorMessage)
                    .padding()
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    SignUpUser()
                    isShowingAlert.toggle()
                }) {
                    Text("Create an account")
                        .fontWeight(.bold)
                        .frame(width: 250, height: 30)
                        .background(.thinMaterial)
                        .cornerRadius(15)
                }
                
                
                
                Button(action: {
                    LoginUser()
                    
                }) {
                    Text("Login")
                        .fontWeight(.bold)
                        .frame(width: 250, height: 30)
                        .background(.thinMaterial)
                        .cornerRadius(15)
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
                
                
                
                NavigationLink(destination: ManView(), isActive: $showingLoginScreen) {
                    EmptyView()
                }
            
            }
            
            
        }
        .alert(isPresented: $isShowingAlert) {
                    Alert(
                        title: Text("Signed Up User"),
                        message: Text("You have successfully signed up"),
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
