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
        Page(name: "Water is important!", description: "Always forgetting how much water you’ve had? Well look no further, each time you chug a glass tell us so we can keep track of you hydration!", ImageUrl: "Water", tag: 1),
        Page(name: "With you, every step of the way.", description: "Want to know how active you have been today? Well lucky for you, we have a built in step counter, we can calculate so you don’t have to!", ImageUrl: "Walking", tag: 2),
    ]
}
