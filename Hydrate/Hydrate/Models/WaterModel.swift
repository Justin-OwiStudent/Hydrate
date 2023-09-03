//
//  WaterModel.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/09/02.
//

import SwiftUI
import Foundation


struct Water: Identifiable, Codable {
    var id = UUID()
    var docId: String = ""
    var title: String
    var amount: String
    var date: String
    
    enum CodingKeys:String, CodingKey{
        case docId, title, amount, date
    }
}
