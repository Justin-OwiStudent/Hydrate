//
//  TodaysDetailsView.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/23.
//

import SwiftUI

struct TodaysDetailsView: View {
    
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
            VStack{
                ScrollView{
                    HStack{
                        VStack(alignment: .leading, spacing: 6){
                            Image(systemName: "flame")
                                .resizable()
                                .frame(width: 40, height: 50)
                            
                            HStack{
                                Text(String(userVM.userData?.steps ?? 0)).bold()
                                    .font(.title)
                                
                                Text("Steps")
                                    .font(.caption)
                            }
                            
                            Text("Walked")
                                .font(.caption)
                            
                            
                            
                        }
                        .frame(width: 165, height: 180)
                        .background(.white)
                        .cornerRadius(15)
                        
                        
                        VStack(alignment: .leading, spacing: 6){
                            Image(systemName: "flame")
                                .resizable()
                                .frame(width: 40, height: 50)
                            
                            HStack{
                                Text(String(userVM.userData?.calories ?? 0)).bold()
                                    .font(.title)
                                
                                Text("Calories")
                                    .font(.caption)
                            }
                            
                            Text("Burned")
                                .font(.caption)
                            
                        }
                        .frame(width: 165, height: 180)
                        .background(.white)
                        .cornerRadius(15)
                    }
                    
                    HStack{
                        Text("Overall Progress")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding()
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Text("7 Days")
                                .fontWeight(.bold)
                                .frame(width: 80, height: 30)
                                .background(.thinMaterial)
                                .cornerRadius(15)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            Text("1 Month")
                                .fontWeight(.bold)
                                .frame(width: 80, height: 30)
                                .background(.thinMaterial)
                                .cornerRadius(15)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            Text("6 Month")
                                .fontWeight(.bold)
                                .frame(width: 80, height: 30)
                                .background(.thinMaterial)
                                .cornerRadius(15)
                        }
                        Spacer()
                    }
                    .padding()
                    

                }
                
                
                
            }
            .background(CustomColor.Background)
        
        
        
        
        
        
    } //BODY
}

struct TodaysDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TodaysDetailsView()
        }
        
    }
}
