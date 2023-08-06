//
//  onBoarding.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 27/07/23.
//


import SwiftUI

struct onBoarding: View {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = true
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Color")
                    .ignoresSafeArea(.all)
                
                VStack(spacing: 15) {
                    ZStack {
                        Image("David 1")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(30)
                            .padding(.horizontal,20)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.99), radius: 81, x: 6, y: 8)
                    }
                    .frame(width: 390,height: 416)
                    
                    Text("David De Gue")
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Text("I'm lucky enough to be mentally strong, which I think is fundamental for a goalkeeper.")
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 9)
                        .frame(maxWidth: 480)
                    VStack {
                        StartButton(text: "NEXT", color: "Color2", destination: AnyView(onBoarding2()), systemImage: "chevron.right")
                        
                            .padding()
                        StartButton(text: "Back", color: "Color1", destination: AnyView(OpeningView()), systemImage: "chevron.backward")
                        
                        StartButton(text: "skip", color: "Color1", destination: AnyView(LoginPage()), systemImage: "chevron.right.2")
                            .onTapGesture {
                                hasSeenOnboarding = false
                            }
                    }
                }
            }
        }
    }
}

struct onBoarding_Previews: PreviewProvider {
    static var previews: some View {
        onBoarding()
        
    }
}
