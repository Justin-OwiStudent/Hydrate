//
//  HealthActivity.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/16.
//

import SwiftUI
import Foundation

//model for info gotten from healthkit
struct HealthActivity: Identifiable, Codable {
    var id = UUID()
    let title: String
    let amount: String
    let image: String
    let date: String
    
    enum CodingKeys:String, CodingKey{
        case title, amount, image, date
    }
}
