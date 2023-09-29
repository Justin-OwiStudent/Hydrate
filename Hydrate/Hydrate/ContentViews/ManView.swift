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
    @AppStorage("isOnboardingFinished") var isOnboardingFinished: Bool = false
    
    @EnvironmentObject var userVM: UserViewModel
    
    @StateObject var VM = ViewModel()
    
    @ObservedObject var manager: HealthKit = HealthKit()
    
    @State private var action: Int? = 0
    @State private var WelcomeText = false
    
    @State private var isShowingAlert = false
    
    @State private var HasSignedOut = false
    
    @State private var shouldAnimate = false

    
    var body: some View {
        ZStack(alignment: .top) {
            CustomColor.Background
                .ignoresSafeArea()
            
            VStack{
             
                ScrollView{
                    
                    HStack {
                        VStack{
                            Text("Welcome back, \(userVM.userData?.username ?? "")!")
                                .font(.system(size: 20))
                                .padding(10)
                            
                            Text("Remember to let us know that you drank some water, while you're at it take a look at your steps and calories burnt")
                                .font(.system(size: 10))
                                .frame(width: 125)
                                .padding(10)
                        }
                        
                        Image("Yoga")
                            .resizable()
                    }
                    .frame(width: 335, height: 250)
                    .background(CustomColor.Secondary)
                    .cornerRadius(25)
                    
                    HStack{
                        Text("Today's Stats")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
//
//               
                        
                    }
                    .padding()
                    
                    HStack{
                        VStack{
                            Image(systemName: "figure.walk")
                                .foregroundColor(.black)
                                .font(.system(size: 40))
                                .frame(alignment: .leading)
                                .padding()
                            
                            Text("Today's Steps")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .padding(.bottom)
                            
                            Text(String(userVM.userData?.steps ?? 0))
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                        }
                        .frame(width: 165, height: 225)
                        .background(.white)
                        .cornerRadius(15)
                        .scaleEffect(shouldAnimate ? 1.1 : 0.9) // Apply spring animation
                        .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0))
                                              
                        
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
                            
                            
                            Text(String(userVM.userData?.calories ?? 0))
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                            
                        }
                        .frame(width: 165, height: 225)
                        .background(.white)
                        .cornerRadius(15)
                        .scaleEffect(shouldAnimate ? 1.1 : 0.9) // Apply spring animation
                        .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0))
                                  
                        
                    }
                    .padding()
                    .onAppear {
                            shouldAnimate = true // Trigger the animation when the view appears
                        }
                    
                    HStack{
                        Text("Today's Water Intake")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        NavigationLink {
                            WaterView()
                        } label: {
                            Text("Track Water")
                                .fontWeight(.bold)
                        }
                        
                    }
                    .padding()
                    
                    VStack{
                        Image(systemName: "drop.circle")
                            .foregroundColor(CustomColor.Primary)
                            .font(.system(size: 40))
                            .frame(alignment: .leading)
                            .padding()
                            
                        
                        Text("Water intake")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .padding(.bottom)
                        
                        
                        Text(String(userVM.userData?.water.rounded(.down) ?? 0) + "ml")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            
                        
                    }
                    .frame(width: 300, height: 225, alignment: .center)
                    .background(.white)
                    .cornerRadius(15)
                }
            }
            .alert(isPresented: $isShowingAlert) {
                        Alert(
                            title: Text("Signed Out"),
                            message: Text("You have Logged Out"),
                            dismissButton: .default(Text("OK"))
                        )
                    }

        }
        .navigationTitle("Activity")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading){
                Image("WhiteLogo")
                    .resizable()
                    .frame(width: 50, height: 50)
                
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                         Button(action: {
                             Task {
                                 await userVM.signOut()
                                 HasSignedOut = true
                             }
                         }) {
                             Image(systemName: "arrowshape.turn.up.backward")
                                 .font(.headline)
                                 .foregroundColor(.blue)
                         }
                     }

                     // Use the NavigationLink within the ToolbarItem
                     ToolbarItem(placement: .navigationBarTrailing) {
                         NavigationLink(destination: AuthenticationView(), isActive: $HasSignedOut) {
                             EmptyView()
                         }
                     }
           
//            ToolbarItem(placement: .navigationBarTrailing){
//
//                NavigationLink {
//                    AuthenticationView()
//
//                } label: {
//                    Image(systemName: "arrowshape.turn.up.backward")
//                        .font(.headline)
//                }
//
//
//
//            }
        }
        .onAppear {
            userVM.getUserDetails()
        }
    }
}
    
    
    
    struct ManView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationStack{
                ManView()
            }
            
               
        }
    }

