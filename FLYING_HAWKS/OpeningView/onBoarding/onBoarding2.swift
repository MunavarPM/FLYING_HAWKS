//
//  onBoarding2.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 27/07/23.
//

import SwiftUI

struct onBoarding2: View {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = true
    let customColor = Color(UIColor(red: 0x00/255, green: 0xA3/255, blue: 0xB7/255, alpha: 1.0))
    let backgroundColor = Color(UIColor(red: 0x3A/255, green: 0x3A/255, blue: 0x3C/255, alpha: 1.0))
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                VStack(spacing: 15) {
                    ZStack {
                        Image("Iker Casillas _  2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(30)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.99), radius: 81, x: 6, y: 8)
                            .frame(width: 290,alignment: .center)
                    }
                    
                    
                    Text("Iker Casillas")
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Text("Beyond remembering me as a good or bad goalkeeper, I just hope that people remember me for being a good person.")
                    
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 9)
                        .frame(maxWidth: 480)
                    VStack {
                        StartButton(text: "NEXT", color: "Color2", destination: AnyView(onBoarding3()), systemImage: "chevron.right")
                            .padding()
                        StartButton(text: "Back", color: "Color1", destination: AnyView(onBoarding()), systemImage: "chevron.backward")
                        StartButton(text: "skip", color: "Color1", destination: AnyView(LoginPage()), systemImage: "chevron.right.2")
                            .onTapGesture {
                                hasSeenOnboarding = false
                            }
                    }
                    //                    .frame(width: 360, height: 100, alignment: .center)
                }
            }
            .ignoresSafeArea(.all)
        }
        
    }
    
}

struct onBoarding2_Previews: PreviewProvider {
    static var previews: some View {
        onBoarding2()
    }
}
