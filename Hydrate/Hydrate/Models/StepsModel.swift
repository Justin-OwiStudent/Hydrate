//
//  StepsModel.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/23.
//
import SwiftUI
import Foundation


struct Step: Identifiable, Codable {
    var id = UUID()
    var docId: String = ""
    var title: String
    var stepCount: String
    var date: String
    
    enum CodingKeys:String, CodingKey{
        case docId, title, stepCount,  date
    }
}
