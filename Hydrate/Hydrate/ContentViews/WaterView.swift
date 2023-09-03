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
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack{
                
                VStack{
                    VStack{
                        Image(systemName: "drop.circle")
                            .resizable()
                            .foregroundColor(CustomColor.Primary)
                            .frame(width: 150, height: 150)
                            .padding()
                        
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
                    
                    
                    
                    Text(String(userVM.userData?.water ?? 0) + "ml").bold()
                        .font(.title)
                    
                    
                }
                
                TextField("Enter amount in milliliters", text: $amountText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                Button(action: {
                    // Parse and save the input amount to HealthKit
                    if let amount = Double(amountText) {
                        VM.saveWaterIntake(amountInMilliliters: amount, date: Date())
                    }
                }) {
                    Text("Save Water Intake")
                        .padding()
                        .background(.thinMaterial)
                        .foregroundStyle(.black)
                        .cornerRadius(15)
                }
               
            }
        }
        .padding()
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
