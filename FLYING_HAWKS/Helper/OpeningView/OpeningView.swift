//
//  OpeningView.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 27/07/23.
//

import SwiftUI

struct OpeningView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Color")
                VStack(spacing: 20) {
                    Text("Flying Hawks...")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(.system(size: 45)).bold()
                        .shimmering()
                    Text("Lets Build the future Hawks 🦅")
                        .foregroundColor(.white)
                        .shimmering()
                    
                    HStack {
                        // Navigate to the onBoarding() view.
                        NavigationLink {
                            tabView()
                                .navigationBarBackButtonHidden(true)
                            
                        } label: {
                            HStack {
                                Text("Let's start")
                                
                                Image(systemName: "arrow.right.circle")
                                    .imageScale(.large)
                            }
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color.white, lineWidth: 1.25)
                            )
                            
                        }
                        .padding(.vertical, 20)
                        
                    }
                    .frame(width: 160, height: 100, alignment: .center)
                }
                
            }
            .ignoresSafeArea(.all)
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

struct OpeningView_Previews: PreviewProvider {
    static var previews: some View {
        OpeningView()
    }
}
