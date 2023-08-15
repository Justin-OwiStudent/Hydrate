//
//  StepView.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/09.
//

import SwiftUI
import Charts

struct StepView: View {
    
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
                            Chart {
                                ForEach(data) { item in
                                    LineMark(x: .value("Day", item.day), y: .value("Value", item.value),
                                             series: .value("Year", "2022"))
                                        .interpolationMethod(.catmullRom)
                                        .foregroundStyle(.blue)
                                        .symbol(by: .value("Year", "2022"))
                                        .foregroundStyle(by: .value("Year", "2022"))
                                }
                                ForEach(data2) { item in
                                    LineMark(x: .value("Day", item.day), y: .value("Value", item.value),
                                             series: .value("Year", "2021"))
                                        .interpolationMethod(.catmullRom)
                                        .foregroundStyle(.green)
                                        .symbol(by: .value("Year", "2022"))
                                        .foregroundStyle(by: .value("Year", "2022"))
                                        
                                }
                            }
                                
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
