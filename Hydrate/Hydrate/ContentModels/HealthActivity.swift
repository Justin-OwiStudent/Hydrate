//
//  HealthActivity.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/16.
//

import SwiftUI
import Foundation

//model for info gotten from healthkit
struct HealthActivity: Identifiable {
    let id = UUID()
    let title: String
    let amount: String
    let image: String
    let color: String
}
