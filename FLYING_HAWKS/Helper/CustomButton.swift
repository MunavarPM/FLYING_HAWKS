//
//  StartButton.swift
//  Flying Hawks
//
//  Created by MUNAVAR PM on 13/06/23.
//

import SwiftUI

struct StartButton: View {
    let text: String
    let color: String
    @State var destination: AnyView
    @State var systemImage: String
    var body: some View {
        NavigationLink {
            AnyView(destination)
                .navigationBarHidden(true)
        } label: {
            HStack {
                Text(text)
                    .font(.body)
                Image(systemName: systemImage)
            }
            .foregroundColor(.white)
            
        }
        .frame(width: 300,height: 10)
        .padding()
        .background(Color(color))
        .cornerRadius(20)
        .overlay(
            Capsule()
                .stroke(Color.white, lineWidth: 0.50)
        )
    }
}

struct StartButton_Previews: PreviewProvider {
    static var previews: some View {
        StartButton(text: "Let's Go", color: "Color2", destination: AnyView(OpeningView()), systemImage: "arrow.forward.circle")
            .preferredColorScheme(.dark)
    }
}
