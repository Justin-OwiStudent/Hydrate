//
//  Tabs.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/29.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case house
    case gearshape
    case person
}

struct Tabs: View {
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    var body: some View {
        VStack{
            
            HStack{
                       
                       ForEach(Tab.allCases, id: \.rawValue) { tab in
       
       
                           Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                               .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                               .foregroundColor(selectedTab == tab ? .red : .gray)
                               .font(system(size: 22))
                               .onTapGesture(perform:
                                   withAnimation(.easeIn(duration: 0.1)) {
                                   selectedTab == tab
                                   }
                               )
       
       
       
                       }
       
                   }
                   .frame(height: 60)
                   .background(.thinMaterial)
                   .cornerRadius(10)
                   .padding()
                   
               }
        }
    }


struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs(selectedTab: .constant(.house))
    }
}
