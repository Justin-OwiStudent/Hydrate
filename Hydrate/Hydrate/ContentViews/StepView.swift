//
//  StepView.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/09.
//

import SwiftUI
import Charts

struct StepView: View {
    
    @ObservedObject var manager: HealthKit = HealthKit()
    
    @StateObject var StepsViewModel = StepViewModel()
    
    struct Value: Identifiable {
        var id = UUID()
        var day: String
        var value: Double
    }

    let data = [
        Value(day: "Jun 1", value: 200),
        Value(day: "Jun 2", value: 96),
        Value(day: "Jun 3", value: 312),
        Value(day: "Jun 4", value: 256),
        Value(day: "Jun 5", value: 505),
    ]
    
    let data2 = [
        Value(day: "Jun 1", value: 151),
        Value(day: "Jun 2", value: 192),
        Value(day: "Jun 3", value: 176),
        Value(day: "Jun 4", value: 158),
        Value(day: "Jun 5", value: 401),
    ]
    
    var body: some View {
        ZStack{
            CustomColor.Background
                .ignoresSafeArea()
                .navigationTitle("Steps")
            
            
            ScrollView {
                VStack{
                    
//                    VStack(spacing: 15) {
//
//                            HStack {
//                                Image(systemName: "flame")
//                                    .foregroundColor(.orange)
//                                    .font(.system(size: 15))
//
//
//
//
//                                Text("Calories Burnt").bold()
//                                    .font(.system(size: 15))
//                                    .foregroundColor(.orange)
//
//                            }
//                            .frame(width: 150)
//                            .offset(x: -100)
//
//
//
//                            Text("2000").bold()
//                                .font(.system(size: 35))
//                                .foregroundColor(.black)
//                                .offset(x: -110)
//
//
//
//                    }
//                    .frame(width: 350, height: 100)
//                    .background(CustomColor.Secondary)
//                    .cornerRadius(10)
                    
                    
                    ForEach(manager.activities) { activity in
                        VStack(spacing: 15){
                            HStack {
                                Image(systemName: activity.image)
                                    .foregroundColor(.orange)
                                    .font(.system(size: 15))
                                    

                                Text(activity.title).bold()
                                    .font(.system(size: 15))
                                    .foregroundColor(.orange)
                                   
                            }
                            .frame(width: 150)
                            .offset(x: -100)


                            Text(activity.amount).bold()
                               .font(.system(size: 35))
                               .foregroundColor(.black)
                               .offset(x: -110)

                        }
                        .frame(width: 350, height: 100)
                        .background(CustomColor.Secondary)
                        .cornerRadius(10)
                    }
                    
                    
//                    VStack{
//                        Text("Average Steps per month")
//                            .bold()
//                    }
//                    .frame(width: 350, height: 100)
//                    .background(CustomColor.Secondary)
//                    .cornerRadius(10)
                    
                    VStack{
                        Text("Energy")
                            .bold()
                        
                        VStack{
                            ForEach(StepsViewModel.StepsList) { item in
                                HStack {
                                    Text(item.amount)
                                }

                            }
                            Button(action: {
                                StepsViewModel.CreateStepData(DailySteps: Step(title: "testing", amount: "2000", image: "flame", date: ""))
                            }){
                                Text("adding steps...")
                            }
//                            Chart {
//                                ForEach(StepsViewModel.StepsList) { item in
//                                    LineMark(x: .value("Steps", item.amount), y: .value("Day", item.amount),
//                                             series: .value("Year", "2022"))
//                                        .interpolationMethod(.catmullRom)
//                                        .foregroundStyle(.blue)
//                                        .symbol(by: .value("Year", "2022"))
//                                        .foregroundStyle(by: .value("Year", "2022"))
//                                }
////                                ForEach(data2) { item in
////                                    LineMark(x: .value("Day", item.day), y: .value("Value", item.value),
////                                             series: .value("Year", "2021"))
////                                        .interpolationMethod(.catmullRom)
////                                        .foregroundStyle(.green)
////                                        .symbol(by: .value("Year", "2022"))
////                                        .foregroundStyle(by: .value("Year", "2022"))
////
////                                }
//                            }
                                
                        }
                        .onAppear{
                            StepsViewModel.getAllStepData()
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
}

struct StepView_Previews: PreviewProvider {
    static var previews: some View {
        StepView()
    }
}
