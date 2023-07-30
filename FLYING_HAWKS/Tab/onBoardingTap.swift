//
//  onBoardingTap.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 27/07/23.
//

import SwiftUI

struct tabView: View {
    @State private var selection = 0
        
        var body: some View {
            ZStack {
                TabView(selection: $selection) {
                    onBoarding()
                        .tabItem {
                            Label("", systemImage: "1.circle")
                        }
                        .tag(0)
                        .onAppear {
                            // Code to be executed when onBoarding appears
                            print("onBoarding appeared")
                        }
                    
                    onBoarding2()
                        .tabItem {
                            Label("", systemImage: "2.circle")
                        }
                        .tag(1)
                    
                    onBoarding3()
                        .tabItem {
                            Label("", systemImage: "3.circle")
                        }
                        .tag(2)
                }
                
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .edgesIgnoringSafeArea(.vertical)
            }
            .ignoresSafeArea(.all)
        }
        
    }

struct tabView_Previews: PreviewProvider {
    static var previews: some View {
        tabView()
    }
}
