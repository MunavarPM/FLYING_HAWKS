//
//  onBoarding3.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 27/07/23.
//

import SwiftUI

struct onBoarding3: View {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = true
    let customColor = Color(UIColor(red: 0x00/255, green: 0xA3/255, blue: 0xB7/255, alpha: 1.0))
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Color")
                    .ignoresSafeArea(.all)
                VStack(spacing: 20) {
                    VStack {
                        Image("Oliver  Mannschaft_ 2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(30)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.99), radius: 81, x: 6, y: 8)
                            .frame(width: 330)
                    }
                    
                    Text("Oliver Kahn")
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Text("Obviously, I couldn't imagine that my career would go so well. When I first started, I wanted to play out of goal. But there was no goalkeeper, and the coach put me in goal.")
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 9)
                        .frame(maxWidth: 480)
                    VStack {
                        
                        StartButton(text: "NEXT", color: "Color2", destination: AnyView(LoginPage()), systemImage: "chevron.right")
                            .onTapGesture {
                                hasSeenOnboarding = false
                            }
                            .padding()
                        StartButton(text: "Back", color: "Color1", destination: AnyView(onBoarding2()), systemImage: "chevron.backward")
                        
                    }
                    //                    .frame(width: 360, height: 100, alignment: .center)
                }
            }
        }
        
    }
}

struct onBoarding3_Previews: PreviewProvider {
    static var previews: some View {
        onBoarding3()
    }
}
