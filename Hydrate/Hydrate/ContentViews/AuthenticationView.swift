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
    @State var showingLoginScreen = false
    
    @State var errorMessage = ""
    
    //login
    func LoginUser(){
        Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
         
            if(error != nil) {
                print(error?.localizedDescription ?? "login error")
                errorMessage = error?.localizedDescription ?? "something went wrong"
            }
            if(authResult != nil){
                print("logged in user" + (authResult?.user.uid ?? ""));
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
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button {
//                            do {
//                                try Auth.auth().signOut()
//                            } catch let signOutError as NSError {
//                                print("Error signing out: %@", signOutError)
//                            }
//                        } label: {
//                            Image(systemName: "pip.exit")
//                        }
//                        
//                    }
//                }
            
            VStack{
                TextField("Email", text: $email)
                    .padding()
                    .background(.white)
                    .foregroundColor(.black)
                    .frame(width: 300)
                    .cornerRadius(15)
                
                SecureField("Password", text: $password)
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
                
                
                
                NavigationLink(destination: ManView(), isActive: $showingLoginScreen) {
                    EmptyView()
                }
                
                //                NavigationLink(destination: ManView(), label: {
                //                                   Text("Main Screen")
                //                               })
                //                               .offset(y: 50)
                
                //                Image("WhiteLogo")
                //                    .resizable()
                //                    .frame(width: 100, height: 100)
                //                    .aspectRatio(contentMode: .fit)
                //                    .offset(y: -200)
                //
                //                Text("Lets get you back on track!")
                //                    .offset(y: -50)
                //                Text("use facial recognition to login")
                //                    .offset(y: -30)
                //
                //                Image("Locked")
                //                    .resizable()
                //                    .frame(width: 50, height: 50)
                //                    .aspectRatio(contentMode: .fit)
                //                    .offset(y: 30)
                //
                //                NavigationLink(destination: ManView(), label: {
                //                    Text("Main Screen")
                //                })
                //                .offset(y: 50)
            }
            
            
        }
    }
        .navigationBarBackButtonHidden(true)
    
    }
    
//    func GoToMain() {
//        NavigationView{
//            NavigationLink("GoToMain", destination: ManView())
//        }
//    }
    
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
