//
//  SplashScreenView.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/03.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Image("Splash")
                .resizable()
                .ignoresSafeArea(.all)
//                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
