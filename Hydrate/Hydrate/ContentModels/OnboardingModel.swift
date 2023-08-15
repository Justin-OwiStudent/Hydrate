//
//  OnboardingModel.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/10.
//

import Foundation


struct Page: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var description: String
    var ImageUrl: String
    var tag: Int
    
    static var samplePage = Page(name: "eitile example", description: "just some description here", ImageUrl: "WhiteLogo", tag: 0)
    
    static var samplePages: [Page] = [
        Page(name: "Welcome yo Hydrate", description: "We offer you a way to keep track of your health, quick and easy", ImageUrl: "WhiteLogo", tag: 0),
        Page(name: "Water", description: "Keep track of your water intake by telling us how much water you have drank", ImageUrl: "WhiteLogo", tag: 1),
        Page(name: "Steps", description: "Keep track of your daily steps, calories and distance travelled, all day every day", ImageUrl: "WhiteLogo", tag: 2),
    ]
}
