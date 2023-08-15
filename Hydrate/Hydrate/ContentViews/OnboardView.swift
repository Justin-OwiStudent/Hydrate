//
//  OnboardView.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/10.
//

import SwiftUI

struct OnboardView: View {
    var page: Page
    
    var body: some View {
        ZStack{
            CustomColor.Background
                .ignoresSafeArea()
            
            
            VStack(spacing: 20){
                Image("\(page.ImageUrl)")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .scaledToFit()
                    .padding()
                   
                   
                
                Text(page.name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                Text(page.description)
                    .font(.subheadline)
                    .frame(width: 300)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct OnboardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardView(page: Page.samplePage)
    }
}
