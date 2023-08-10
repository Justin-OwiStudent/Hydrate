//
//  AuthenticationView.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/10.
//

import SwiftUI

struct AuthenticationView: View {
    var body: some View {
        NavigationView{
        ZStack {
            CustomColor.Background
                .ignoresSafeArea()
            VStack{
                Image("WhiteLogo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
                    .offset(y: -200)
                
                Text("Lets get you back on track!")
                    .offset(y: -50)
                Text("use facial recognition to login")
                    .offset(y: -30)
                
                Image("Locked")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .offset(y: 30)
                
                NavigationLink(destination: ManView(), label: {
                    Text("Main Screen")
                })
                .offset(y: 50)
            }
            
            
        }
    }
    }
    
    func GoToMain() {
        NavigationView{
            NavigationLink("GoToMain", destination: ManView())
        }
    }
    
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
