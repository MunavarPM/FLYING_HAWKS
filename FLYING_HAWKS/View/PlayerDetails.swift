//
//  PlayerDetails.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 27/07/23.
//

import SwiftUI
import PhotosUI

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
    @Environment(\.presentationMode) private var presentationMode
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Student.name, ascending: true)])
    private var classes: FetchedResults<Student>
    
    @State private var studentImage = UIImage()
    @State private var studentName = ""
    @State private var age: Int = 0
    @State private var ageString: String = ""
    @State private var place = ""
    @State private var imagePicker: Bool = false
    @State private var succuese: Bool = false
    @State private var ShowMainTap = false
    //    @State private var photoItem: PhotosPickerItem?
    
    
    
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
                        imagePicker.toggle()
                    }, label: {
                        Text("Add Image")
                        
                    })
                    .sheet(isPresented: $imagePicker){
                        ImagePickerView(selectedImage: $studentImage)
                    }
                }
                
                
                TextField("Add Player Name", text: $studentName)
                    .disableAutocorrection(true)
                TextField("Enter your age", text: $ageString)
                    .keyboardType(.decimalPad)
                    .onChange(of: ageString) { age in
                        // Update the age variable
                        self.age = Int(ageString) ?? 0
                    }
                TextField("Player Native Place", text: $place)
                
                Button {
                    print("HEy✅")
                    addStudents()
                    succuese.toggle()
                } label: {
                    Text("SAVE DETAILS")
                        .fontWeight(.bold)
                        .frame(width: 300, height: 30, alignment: .center)
                    
                }
                .alert("Succuss ✅", isPresented: $succuese) {
                            Button("OK", role: .cancel) {
                            }
                        }
                .opacity(studentName.isEmpty && ageString.isEmpty && place.isEmpty ? 0.2 : 1)
                .disabled(studentName.isEmpty && ageString.isEmpty && place.isEmpty)
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
    private func addStudents(){
        let newStudents = Student(context: viewContext)
        newStudents.id = UUID()
        newStudents.photo = studentImage.pngData()
        newStudents.name = studentName
        if let ageValue = Int16(ageString) {
                newStudents.age = ageValue
            } else {
                // Handle the case where ageString is not a valid number
                // You can show an error message to the user or set a default value.
                newStudents.age = 0 // Set a default value, or you can show an error message to the user.
            }
        newStudents.place = place
        
        do{
            try viewContext.save()
            print("its Done✅")
        }
        catch{
            print("Error while saving Employee Data \(error.localizedDescription)")
        }
    }

}

