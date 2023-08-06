//
//  View.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 05/08/23.
//

import SwiftUI

struct SettingsView1: View {
    @StateObject private var settingsViewModel = SettingsViewModel()
    var body: some View {
        ZStack {
            Color("Color")
                .ignoresSafeArea(.all)
            List{
                ForEach(settingsViewModel.students) { student in
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
                            Text(settingsViewModel.CurrentUser?.fullname ?? User.Mark_User.fullname)
                                .font(.title3).bold()
                            Text(settingsViewModel.CurrentUser?.email ?? User.Mark_User.email)
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
}

struct SettingsView1_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView1()
    }
}
