//
//  PlayerDetails.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 27/07/23.
//

import SwiftUI

struct playerDetails: View {
    var body: some View {
        NavigationStack {
            playerDetailsView()
        }
        .preferredColorScheme(.dark)
    }
}

struct playerDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            playerDetails()
        }
    }
}


struct playerDetailsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @State private var studentImage = UIImage()
    @State private var studentName = ""
    @State private var age: Int = 0
    @State private var ageString: String = ""
    @State private var place = ""
    
    
    let myColor = Color(red: Double(0x1E) / 255,green: Double(0x1E) / 255,blue: Double(0x1E) / 255)

    var body: some View {
        NavigationStack {
            ZStack {
                // Headline
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [myColor, myColor, myColor]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .ignoresSafeArea()
                    
                    // Hawks
                    VStack {
                        Spacer()
                        HStack {
                            Text("Flying Hawks.")
                                .shimmering()
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .padding()
                            Spacer()
                        }
                    }
                    .alignmentGuide(.leading) { _ in
                        0 // Align the content to the leading edge
                    }
                }
            }
            .frame(height: 140)
            
            HStack {
                Spacer()
                Text("Player Details")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)
                Spacer()
            }
            
            Form {
                VStack {
                    Image(uiImage: studentImage)
                        .resizable()
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.all)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color.gray,lineWidth: 5))
                    Button(action: {
                        
                    }, label: {
                        Text("Add Image")
                    })
                }
                TextField("Add Player Name", text: $studentName)
                TextField("Enter your age", text: $ageString)
                    .onChange(of: ageString) { age in
                        // Update the age variable
                        self.age = Int(ageString) ?? 0
                    }
                TextField("Player Native Place", text: $place)
                    
                NavigationLink {
                    SwiftTabView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text("SAVE DETAILS")
                        .fontWeight(.bold)
                        .frame(width: 300, height: 30, alignment: .center)
                    
                }
                .opacity(studentName != "" && ageString != ""  && ageString != "" ? 1 : 0.5)
                .background(Color("Color2"))
                .foregroundColor(.white)
                .clipShape(Capsule())
                .buttonStyle(.bordered)
                .ignoresSafeArea(.all)
            }
        }
        
   .toolbarColorScheme(.dark, for: .navigationBar)
   .ignoresSafeArea(.all)
        
    }
}

