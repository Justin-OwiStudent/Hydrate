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
//    @EnvironmentObject var userViewModel: UserViewModel
    
    @ObservedObject var manager: HealthKit = HealthKit()
    
    @State private var action: Int? = 0
    @State private var WelcomeText = false
    
    //    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State var isNotAuthenticated = true
    
    @State var authHandler: NSObjectProtocol? = nil
    
    @State var GoToDetailView = false
    
    func GoDetail() {
        GoToDetailView = true
    }
    
    //    private func fetchCurrentUser() {
    //        guard let uid = userViewModel.shared.auth.currentUser?.uid else {
    //            return }
    //
    //        userViewModel.shared.firstore.collection
    //    }
    
    var body: some View {
        
        
        
        
        ZStack(alignment: .top) {
            CustomColor.Background
                .ignoresSafeArea()
            
            VStack{
                HStack {
                    VStack{
                        
                        Text("Welcome back!")
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
        .navigationTitle("Activity")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Image(systemName: "gear")
                    .font(.headline)
                
                
                
                
                
                
                
            }
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

