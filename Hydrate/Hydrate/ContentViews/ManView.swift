//
//  ManView.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/09.
//

import SwiftUI

struct ManView: View {
    
    @ObservedObject var manager: HealthKit = HealthKit()
    
    @State private var action: Int? = 0
    
    //    struct GrowingButton: ButtonStyle {
    //        func makeBody(configuration: Configuration) -> some View {
    //            configuration.label
    //                .padding()
    //                .background(CustomColor.Primary)
    //                .foregroundStyle(.white)
    //                .clipShape(Capsule())
    //                .scaleEffect(configuration.isPressed ? 1.2 : 1)
    //                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    //                .offset(y: -70)
    //        }
    //    }
    
    var body: some View {
        
        
        //        Color(UIColor.green)
        //            .ignoresSafeArea()
        
        
        
            ZStack {
                CustomColor.Background
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden(true)
                VStack {
                    Image("WhiteLogo")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                        .offset(y: -100)
                    
                    
                    
                    VStack {
                        Text("Welcome Back /username")
                            .font(.system(size: 25))
                            .multilineTextAlignment(.center)
                        Text("Remember to let us know that you drank some water, while your at it take a look at your steps and calories burnt")
                            .multilineTextAlignment(.center)
                        
                    }
                    .frame(width: 300, height: 100)
                    .offset(y: -100)
                    
                    
                    
                    
                    HStack{
                        VStack{
                            
                            Text("Todays Cups")
                                .foregroundColor(.white)
                        }
                        .frame(width: 150,height: 150)
                        .background(CustomColor.Primary)
                        .cornerRadius(10)
                        
                        VStack(){
                            ForEach(manager.activities) {activity in
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack{
                                        
                                        Image(systemName: activity.image)
                                            .foregroundColor(.orange)
                                            .font(.system(size: 10))
                                            .frame(alignment: .leading)
                                        
                                        Text(activity.title).bold()
                                            .foregroundColor(.orange)
                                            .font(.system(size: 12))
                                            .frame(alignment: .leading)
                                        
                                        
                                    }
                                    Text(activity.amount)
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                        .font(.system(size: 20))
                                        .frame(alignment: .leading)
                                    
                                }
                                .frame(width: 150)
                                .cornerRadius(10)
                                .frame(width: 150)
                                .padding(10)
                                .background(.white)
                                
                                
                            }
                            
                            
                            
                            
                            
                            
                        }
                        .frame(width: 150,height: 150)
                        .cornerRadius(10)
                    }
                    
                    HStack{
//                                            NavigationLink(destination: WaterView(), tag: 1, selection: $action) {
//
//                                            }
//                                            NavigationLink(destination: StepView(), tag: 2, selection: $action) {
//
//                                            }
                        
                        VStack{
                            NavigationLink("Water", destination: WaterView())
                                .foregroundColor(.white)
                            //                        Button("Next", action: nil)
                            //                            .onTapGesture {
                            //                                .buttonStyle(GrowingButton())
                            //                                self.action = 1
                            //                            }
                            
                            //                        Button(.buttonStyle(GrowingButton()))
                            //                            .onTapGesture {
                            //
                            //                                self.action = 1
                            //                            }
                            
                            //
                            //                        Text("Water")
                            //                            .onTapGesture {
                            //                                self.action = 1
                            //                            }
                        }
                        .frame(width: 150,height: 100)
                        .background(CustomColor.Primary)
                        .cornerRadius(10)
                        
                        VStack{
                            NavigationLink("Steps", destination: StepView())
                                .foregroundColor(.white)
                            
                            //                        Text("Steps")
                            //                            .foregroundColor(.white)
                        }
                        .frame(width: 150,height: 100)
                        .background(CustomColor.Primary)
                        .cornerRadius(10)
                        
                    }
                    
                    
                    
                }
                
                
                
            }
        
        
        
        
        
        
        
        
        
    }
    
    
    
    struct ManView_Previews: PreviewProvider {
        static var previews: some View {
            ManView()
        }
    }
}
