//
//  Amertueur.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 27/07/23.
//

import SwiftUI

import SwiftUI
import AVKit

struct VideoFetchingAmerteur: View {
    var body: some View {
        NavigationStack {
                ScrollView {
                    VStack {
                        VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: "B-1", withExtension: "mov")!))
                            .frame(height: 500)
                        
                            VStack {
                                Text("🔘. Work with your teammates. Practice communicating with your defenders and midfielders so that you can work together to defend the goal.\n 🔘. Practice different types of saves. Practice diving saves, low saves, and high saves. This will help you to be prepared for any type of shot.\n🔘. Watch videos of professional goalkeepers. Watch videos of professional goalkeepers and learn from their techniques. Get feedback from your coach.\n🔘. Ask your coach for feedback on your performance so that you can improve.!")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                    }
                }
            }
            .navigationTitle("TIPS FRO AMERTEUR.")
        }
    }
}


struct VideoFetchingAmerteur_Previews: PreviewProvider {
    static var previews: some View {
        VideoFetchingAmerteur()
            .preferredColorScheme(.dark)
    }
}

