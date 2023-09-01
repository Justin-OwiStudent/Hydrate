//
//  CustomTabBar.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/28.
//

import SwiftUI

//enum Tab: String, CaseIterable {
//    case house
//    case gearshape
//    case person
//}

struct CustomTabBar: View {
//    @Binding var selectedTab: Tab
//    private var fillImage: String {
//        selectedTab.rawValue + ".fill"
//    }
//
    
    var body: some View {
        VStack{
            Text("hehe")
            
//            HStack{
                
//                ForEach(Tab.allCases, id: \.rawValue) { tab in
//
//
//                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
//                        .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
//                        .foregroundColor(selectedTab == tab ? .red : .gray)
//                        .font(system(size: 22))
//                        .onTapGesture(perform:
//                            withAnimation(.easeIn(duration: 0.1)) {
//                            selectedTab == tab
//                            }
//                        )
//
//
//
//                }
//
//            }
//            .frame(width: nil, height: 60)
//            .background(.thinMaterial)
//            .cornerRadius(10)
//            .padding()
            
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}
