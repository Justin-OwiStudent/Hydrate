//
//  ContentView.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/03.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    @State private var pageIndex = 0
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        NavigationView {
        ZStack {
            CustomColor.Background
                .ignoresSafeArea()
            if showSplash {
                SplashScreenView()
                    .transition(.opacity)
                    .animation(.easeOut(duration: 1.5))
            } else {
                TabView(selection: $pageIndex){
                    ForEach(pages) { page in
                        VStack{
                            Spacer()
                            OnboardView(page: page)
                            Spacer()
                            if page == pages.last {
//                                Button("sign up", action: goToAuth)
                                NavigationLink(destination: AuthenticationView(), label: {
                                    Text("Sign up")
                                })
                                .offset(y: -70)
                                
                            } else {
                                Button("next", action: incrementPage)
                                    .offset(y: -70)
                                
                                    
                            }
                            Spacer()
                        }
                        .tag(page.tag)
                    }
                }
                .animation(.easeOut, value: pageIndex)
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .onAppear{
                    dotAppearance.currentPageIndicatorTintColor = .black
                    dotAppearance.pageIndicatorTintColor = .gray
                    
                }
            }
        } //ZStack
        .onAppear {
            DispatchQueue.main
                .asyncAfter(deadline: .now() + 3 )
            {
                withAnimation {
                    self.showSplash = false
                }
            }
        }
    }
       
    } //BODY
    func incrementPage() {
        pageIndex += 1
    }
    
    func goToZero() {
        pageIndex = 0
    }
    
    func goToAuth() {
        NavigationView{
            NavigationLink("sign up", destination: AuthenticationView())
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct CustomColor {
    static let Primary = Color("Primary")
    static let Background = Color("Background")
    static let Secondary = Color("Secondary")
    static let Tertiary = Color("Tertiary")
    // Add more here...
}
