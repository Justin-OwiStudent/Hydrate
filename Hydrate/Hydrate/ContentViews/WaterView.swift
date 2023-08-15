//
//  WaterView.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/09.
//

import SwiftUI

struct WaterView: View {
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
                            Text("Your cups")
                            HStack{
                                
                            }
                            
                            Button("DRINK") {
                                
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
