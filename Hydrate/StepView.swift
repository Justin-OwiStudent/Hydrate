//
//  StepView.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/09.
//

import SwiftUI

struct StepView: View {
    var body: some View {
        ZStack{
            CustomColor.Background
                .ignoresSafeArea()
            
            VStack{
                
                VStack{
                    Text("Steps")
                        .bold()
                    Text("1500 Steps")
                    
                }
                .frame(width: 350, height: 100)
                .background(CustomColor.Secondary)
                .cornerRadius(10)
                
                VStack{
                    Text("Average Steps per month")
                        .bold()
                }
                .frame(width: 350, height: 100)
                .background(CustomColor.Secondary)
                .cornerRadius(10)
                
                VStack{
                    Text("Energy")
                        .bold()
                    
                    VStack{
                        Text("Graph here")
                            
                    }
                    .frame(width: 300, height: 150)
                    .background(CustomColor.Tertiary)
                    .cornerRadius(10)
                    
                    HStack{
                        VStack{
                            Text("today")
                            Text("50 cal")
                        }
                        VStack{
                            Text("Average")
                            Text("50 cal")
                        }
                    }
                }
                .frame(width: 350, height: 250)
                .background(CustomColor.Secondary)
                .cornerRadius(10)
                
            }
            
            
           
           
        }
    }
}

struct StepView_Previews: PreviewProvider {
    static var previews: some View {
        StepView()
    }
}
