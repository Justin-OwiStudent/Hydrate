//
//  ManView.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/09.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct ManView: View {
    
    @ObservedObject var manager: HealthKit = HealthKit()
    
    @State private var action: Int? = 0
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State var isNotAuthenticated = true
    
    @State var authHandler: NSObjectProtocol? = nil
    
    @State var GoToDetailView = false
    
    func GoDetail() {
        GoToDetailView = true
    }
    
    var body: some View {
        
        NavigationView{
            
            
            ZStack {
                CustomColor.Background
                    .ignoresSafeArea()
                
                VStack{
                
                
//                HStack{
//                    Text("Activity")
//                        .font(.title)
//                        .fontWeight(.bold)
//
//                    Spacer()
//                }
//                .padding()
//
                HStack {
                    VStack{
                        
                        Text("Welcome back, Justin")
                            .font(.system(size: 20))
                            .padding(10)
                        
                        
                        
                        Text("Remember to let us know that you drank some water, while your at it take a look at your steps and calories burnt")
                            .font(.system(size: 10))
                            .frame(width: 125)
                            .padding(10)
                    }
                    
                    
                    
                    Image("Yoga")
                        .resizable()
                    
                    //                        .offset(x: 60)
                    //                        .zIndex(1)
                }
                .frame(width: 335, height: 250)
                .background(CustomColor.Secondary)
                .cornerRadius(25)
                
                HStack{
                    Text("Todays Stats")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {
                        GoDetail()
                        
                    }) {
                        Text("See all")
                            .fontWeight(.bold)
                    }
                }
                .padding()
                    
                    NavigationLink(destination: TodaysDetailsView(), isActive: $GoToDetailView) {
                        EmptyView()
                    }
                
                HStack{
                    VStack{
                        Image(systemName: "flame")
                            .foregroundColor(.black)
                            .font(.system(size: 40))
                            .frame(alignment: .leading)
                            .padding()
                        
                        Text("Todays Steps")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .padding(.bottom)
                        
                        Text("2000")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                    }
                    .frame(width: 165, height: 225)
                    .background(.white)
                    .cornerRadius(15)
                    
                    Spacer()
                    
                    VStack{
                        Image(systemName: "flame")
                            .foregroundColor(.black)
                            .font(.system(size: 40))
                            .frame(alignment: .leading)
                            .padding()
                        
                        Text("Calories Burnt")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .padding(.bottom)
                        
                        
                        Text("2000")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                        
                    }
                    .frame(width: 165, height: 225, alignment: .center)
                    .background(.white)
                    .cornerRadius(15)
                    
                }
                .padding()
            
            }
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Activity")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack{
                        Image("WhiteLogo")
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                        

                      
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        do {
                            try Auth.auth().signOut()
                        } catch let signOutError as NSError {
                            print("Error signing out: %@", signOutError)
                        }
                    } label: {
                        Image(systemName: "pip.exit")
                    }
                }
            }
        }
        
//        .onAppear{
//            //check if a valid user logged on
//            self.authHandler = Auth.auth().addStateDidChangeListener { auth, user in
//                print("checking auth state")
//                if(user != nil) {
//                    isNotAuthenticated = false
//                    print("currentUser" + (user?.uid ?? ""))
//                } else {
//                    print("removing auth state checker...")
//                    isNotAuthenticated = true
//                }
//            }
//        }
//        .onDisappear{
//            //stop listening to auth
//            Auth.auth().removeStateDidChangeListener(authHandler!)
//        }
//        .fullScreenCover(isPresented: $isNotAuthenticated) {
//            AuthenticationView()
//        }
        
    }
    
    
    
    struct ManView_Previews: PreviewProvider {
        static var previews: some View {
            ManView()
        }
    }
}
