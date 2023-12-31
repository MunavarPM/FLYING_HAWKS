//
//  SettingsView.swift
//  Flying Hawks
//
//  Created by MUNAVAR PM on 20/06/23.
//

import SwiftUI
import Firebase


struct SettingsView: View {
//    @State private var errorMessage: String = ""
//    @State private var shwoError: Bool = false
    @State private var showAlertSignout = false
    @State private var showAlertDelectAccount = false
    @State var isLoading: Bool = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @EnvironmentObject var viewModel: AuthenticationModel
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    @Environment(\.managedObjectContext) var viewContext
    
    
    var body: some View {
        ZStack {
            Color("Color")
                .ignoresSafeArea(.all)
            List{
                ForEach(students) { student in
                    HStack(spacing: 20) {
                        
                        if let _studentImage = student.photo {
                            Image(uiImage: UIImage(data: _studentImage)!)
//                        Image(User.Mark_User.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 72, height: 72)
                                .background(Color(.systemGray3))
                                .clipShape(Circle())
                        }
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.CurrentUser?.fullname ?? User.Mark_User.fullname)
                                .font(.title3).bold()
                            Text(viewModel.CurrentUser?.email ?? User.Mark_User.email)
                                .clipShape(Rectangle())
                                .padding(1)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    .onTapGesture {
                        viewContext.delete(student)
                    }
                    
                }
                
                Section(header: Text("Privacy")) {
                    NavigationLink(destination: AccountDetailsView()) {
                        Text("Account Details")
                    }
                }
                
                Section(header: Text("Help Center")) {
                    NavigationLink(destination: MentorDetailsView()) {
                        Text("Mentor's Details")
                    }
                }
                Section(header: Text("account")) {
                    NavigationLink(destination: TermsCondition()) {
                        Text("Terms & Conditions")
                    }
                    
                    Button(action: {
                        showAlertDelectAccount = true
                    }) {
                        Text("Delect Account")
                            .foregroundColor(.red)
                            .alert(isPresented: $showAlertDelectAccount) {
                                Alert(
                                    title: Text("Are you sure you want to Delect Accoun ⚠️ ?"),
                                    primaryButton: .destructive(
                                        Text("DELECT"),
                                        action: {
                                           performDelectAccount()
                                        }
                                    ),
                                    secondaryButton: .cancel()
                                )
                            }
                    }
                    
                    Button {
                        showAlertSignout = true
                        //                        performLogout()
                    } label: {
                        Text("Logout")
                            .foregroundColor(.red)
                            .alert(isPresented: $showAlertSignout) {
                                Alert(
                                    title: Text("Are you sure you want to logout?"),
                                    primaryButton: .destructive(
                                        Text("Logout"),
                                        action: {
                                            performLogout()
                                        }
                                    ),
                                    secondaryButton: .cancel()
                                )
                            }
                    }
                }
                
            }
        }
        .task {
            if viewModel.CurrentUser != nil { return }
            await viewModel.fetchUser()
        }
        .overlay {
            LoadingView(show: $isLoading)
        }
    }
    
    func performLogout() {
        viewModel.signOut()
        //        isLoading = false
        isLoggedIn = false
    }
    
    func performDelectAccount() {
        viewModel.delectAccount()
        isLoggedIn = false
    }
    

    

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
