//
//  MentorDetailsView.swift
//  Flying Hawks
//
//  Created by MUNAVAR PM on 20/06/23.
//

import SwiftUI

struct MentorDetailsView: View {
    
    var body: some View {
        ZStack {
            Color("Color1").ignoresSafeArea(.all)
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Bio")
                        .underline()
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding()
                    Text("Hero Sub-Junior, Junior and Elite League \nSub Junior and Junior National Football Championships \nFc kerala player in 2020 \nReprest the state team in 2019")
                        .font(.headline)
                }
                Image("4E7BF5E3-C915-4205-A87D-720932F59C5E_1_201_a")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(30)
                    .padding()
                Button(action: {
                    print("Calling the Mentor")
                }, label: {
                    Image(systemName: "phone.connection.fill")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: 100)
                        .background(Color("Color2"))
                        .clipShape(Capsule())
                    
                })
                Text("Available on 5:00 pm to 7:00 pm")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                
            }
        }
    }
}

struct MentorDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MentorDetailsView()
            .preferredColorScheme(.dark)
    }
}
