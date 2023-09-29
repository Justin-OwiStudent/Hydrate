//
//  WaterView.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/09.
//

import SwiftUI
import FirebaseAuth

struct WaterView: View {
    @EnvironmentObject var userVM: UserViewModel
    
    @StateObject var VM = ViewModel()
    
    @State private var amountText = ""
    
    @State private var isShowingAlert = false
    
    @State private var shouldAnimate = false
    
    @State private var shouldMoveLeft = false

    
    var body: some View {
        ZStack {
            CustomColor.Background
                .ignoresSafeArea()
            
                
                VStack{
                    
                    VStack{
                        Image(systemName: "drop.circle")
                                  .resizable()
                                  .foregroundColor(CustomColor.Primary)
                                  .frame(width: 150, height: 150)
                                  .padding()
                                  .rotationEffect(Angle(degrees: shouldMoveLeft ? 30 : -30)) // Rotate left or right
                                  .animation(.linear(duration: 1.0)) // Linear animation

                                  // Toggle the shouldRotate state when the animation completes
                                  .onAppear {
                                      Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                                          withAnimation {
                                              shouldMoveLeft.toggle()
                                          }
                                      }
                                  }
                        
                        Text("Everytime you drink some water, add the amount you drank so we can keep your stats up to date!")
                            .multilineTextAlignment(.center)
                            .frame(width: 250)
                            .padding()
                    }
                    .background(.thinMaterial)
                    .cornerRadius(15)
                    
                   
                    
                    Text("Today's water intake").bold()
                        .padding()
                        .font(.caption)
                    
                    
                    
                    Text(String(userVM.userData?.water.rounded(.down) ?? 0) + "ml").bold()
                        .font(.title)
                    
                    TextField("Enter amount in milliliters", text: $amountText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                    
                    Button(action: {
                        // Parse and save the input amount to HealthKit
                        if let amount = Double(amountText) {
                            VM.saveWaterIntake(amountInMilliliters: amount, date: Date())
                        }
                        isShowingAlert.toggle()
                    }) {
                        Text("Save Water Intake")
                            .padding()
                            .background(.thinMaterial)
                            .foregroundStyle(.black)
                            .cornerRadius(15)
                    }
                    
                }
                
               
               
            
            .alert(isPresented: $isShowingAlert) {
                        Alert(
                            title: Text("Water Added"),
                            message: Text("You have successfully added water."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
        }
        .navigationTitle("Your Water")
        .background(CustomColor.Background)
        .ignoresSafeArea()
        
        
        
    }
}

struct WaterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            WaterView()
        }
        
    }
}
