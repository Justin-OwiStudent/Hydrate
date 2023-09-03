//
//  UserData.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/09/03.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    var username: String
    var email: String
    var water: Double
    var steps: Double
    var calories: Double
    var signUpDate = Date.now
}
