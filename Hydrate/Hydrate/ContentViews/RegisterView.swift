//
//  RegisterView.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/09/12.
//

import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @State var email = ""
    @State var password = ""
    @State var username = ""
    @State var ShowingLogin = false
    @State var uid = ""
    
    @State var errorMessage = ""
    
    @StateObject var VM = ViewModel()
    
    @State private var LoginAlert = false
    @State private var SignUpAlert = false
    
    @State private var isShowingAlert = false
    @State private var isShowingError = false
    
    
    func SignUpUser(){
        //check so that emial of password is not nil
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if(error != nil) {
                print(error?.localizedDescription ?? "Signup error")
                errorMessage = error?.localizedDescription ?? "something went wrong"
                isShowingError = true
                
            }
            if(authResult != nil){
                print("Signed up user" + (authResult?.user.uid ?? ""));
                VM.createUserInDB(username: self.username, email: self.email, userId: authResult?.user.uid ?? "" )
                
                SignUpAlert = true
                
               
            }
        }
        
    }
    var body: some View {
        ZStack {
            CustomColor.Background
                .ignoresSafeArea()
                .navigationTitle("Register")
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
                }) {
                    Text("Create an account")
                        .fontWeight(.bold)
                        .frame(width: 250, height: 30)
                        .background(.thinMaterial)
                        .cornerRadius(15)
                }
                .alert(isPresented: $isShowingAlert) {
                            Alert(
                                title: Text("Signed Up User"),
                                message: Text("You have successfully signed up"),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                
                Button(action: {
                    ShowingLogin.toggle()
                }) {
                    Text("Already have an account?")
                        .fontWeight(.bold)
                        .frame(width: 250, height: 30)
                        .cornerRadius(15)
                }
                
            
                NavigationLink(destination: AuthenticationView(), isActive: $ShowingLogin) {
                    EmptyView()
                }
            
            }
            .alert(isPresented: $isShowingError) {
                        Alert(
                            title: Text("Sign up error"),
                            message: Text("An error occured when signing up, please try again later."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
            
            
        }
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            RegisterView()
        }
        
    }
}
