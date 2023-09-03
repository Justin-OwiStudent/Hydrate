//
//  WaterView.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/09.
//

import SwiftUI
import FirebaseAuth

struct WaterView: View {
    
    @StateObject var VM = ViewModel()
    
    @State var amount = ""
    
    func addWater(){
        
//        VM.AddWaterIntake(amount: self.amount, userId: authResult?.user.uid ?? "" )
//        VM.createUserInDB(username: self.username, email: self.email, userId: authResult?.user.uid ?? "" )
    }
    
    
    var body: some View {
        ZStack {
            CustomColor.Background
                .ignoresSafeArea()
                .navigationTitle("Water")
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    VStack{
                        Text("Are you drinking enough water?")
                        Text("Water is a vital source to your health, make sure to drink enough daily!")
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 300, height: 150)
                    .background(CustomColor.Secondary)
                    .cornerRadius(10)
                    
                    VStack{
                        Text("Make sure you let us know that you drank some water")
                            .multilineTextAlignment(.center)
                        
                        VStack{
                            Text("how much water did you drink ?")
                            HStack{
                                TextField("amount", text: $amount)
                                    .padding()
                                    .background(.white)
                                    .frame(width: 250)
                                    .cornerRadius(15)
                                    .foregroundColor(.black)
                                    .padding()
                            }
                            
                            Button("DRINK") {
                                addWater()
                            }
                            .frame(width: 250, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .border(.black, width: 2)
                            .cornerRadius(10)
                            
                        }
                       
                        
                    }
                    .frame(width: 300, height: 300)
                    .background(CustomColor.Secondary)
                    .cornerRadius(10)
                    
                }
            }
         
        }
    }
}

struct WaterView_Previews: PreviewProvider {
    static var previews: some View {
        WaterView()
    }
}
