import SwiftUI

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.thinMaterial)
            .foregroundStyle(.black)
            .cornerRadius(15)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.8), value: configuration.isPressed)
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

                               
                                NavigationLink(destination: AuthenticationView(), label: {
                                    Text("Sign up")
                                        .padding()
                                        .background(.thinMaterial)
                                        .foregroundStyle(.black)
                                        .cornerRadius(15)
                                })
                                .offset(y: -70)



                            } else {


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
    
}
