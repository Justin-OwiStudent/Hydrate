////
////  StepView.swift
////  Hydrate
////
////  Created by Justin Koster on 2023/08/09.
////
//
//import SwiftUI
//import Charts
//
//struct StepView: View {
//    
//    @ObservedObject var manager: HealthKit = HealthKit()
//    
//
//    
//    var body: some View {
//        ZStack{
//            CustomColor.Background
//                .ignoresSafeArea()
//                .navigationTitle("Steps")
//            
//            
//            ScrollView {
//                VStack{
//                    
////
//                    
//                    ForEach(manager.activities) { activity in
//                        VStack(spacing: 15){
//                            HStack {
//                                Image(systemName: activity.image)
//                                    .foregroundColor(.orange)
//                                    .font(.system(size: 15))
//                                    
//
//                                Text(activity.title).bold()
//                                    .font(.system(size: 15))
//                                    .foregroundColor(.orange)
//                                   
//                            }
//                            .frame(width: 150)
//                            .offset(x: -100)
//
//
//                            Text(activity.amount).bold()
//                               .font(.system(size: 35))
//                               .foregroundColor(.black)
//                               .offset(x: -110)
//
//                        }
//                        .frame(width: 350, height: 100)
//                        .background(CustomColor.Secondary)
//                        .cornerRadius(10)
//                    }
//                    
//                   
//                    
//                    VStack{
//                        Text("Energy")
//                            .bold()
//                        
//                        VStack{
//                            ForEach(StepsViewModel.StepsList) { item in
//                                HStack {
//                                    Text(item.stepCount)
//                                }
//
//                            }
//
//                                
//                        }
//                        .onAppear{
//                            StepsViewModel.getAllStepData()
//                        }
//                        .frame(width: 300, height: 150)
//                        .background(CustomColor.Tertiary)
//                        .cornerRadius(10)
//                        
//                        HStack{
//                            VStack{
//                                Text("today")
//                                Text("50 cal")
//                            }
//                            VStack{
//                                Text("Average")
//                                Text("50 cal")
//                            }
//                        }
//                    }
//                    .frame(width: 350, height: 250)
//                    .background(CustomColor.Secondary)
//                    .cornerRadius(10)
//                    
//                }
//            }
//            
//            
//           
//           
//        }
//    }
//}
//
//struct StepView_Previews: PreviewProvider {
//    static var previews: some View {
//        StepView()
//    }
//}
