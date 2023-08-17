//
//  ContentView.swift
//  Hydrate
//
//  Created by Justin Koster on 2023/08/03.
//

import SwiftUI

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(CustomColor.Primary)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .offset(y: -70)
    }
}

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
                                
//                                Button("Next", action: incrementPage)
//                                    .buttonStyle(GrowingButton())
                                
                            } else {
//                                Ellipse()
//                                    .fill(.white)
//                                    .frame(width: 75, height: 75)
//                                    .offset(y: -70)
                                    
//                                Button("next", action: incrementPage)
//                                    .padding(10)
//                                    .background(CustomColor.Secondary)
//                                    .frame(width: 100, height: 50)
//                                    .cornerRadius(20)
//                                    .offset(y: -70)
                                
                                Button("Next", action: incrementPage)
                                    .buttonStyle(GrowingButton())
                                    
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
                    dotAppearance.currentPageIndicatorTintColor = .systemCyan
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
