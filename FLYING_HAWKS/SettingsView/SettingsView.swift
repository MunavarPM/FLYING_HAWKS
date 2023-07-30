//
//  SettingsView.swift
//  Flying Hawks
//
//  Created by MUNAVAR PM on 20/06/23.
//

import SwiftUI
import Firebase


struct SettingsView: View {
    @State private var errorMessage: String = ""
    @State private var shwoError: Bool = false
    @State private var showAlertSignout = false
    @State private var showAlertDelectAccount = false
    @State var isLoading: Bool = false
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @EnvironmentObject var viewModel: AuthenticationModel
    var body: some View {
        ZStack {
            Color("Color")
                .ignoresSafeArea(.all)
            List {
                HStack(spacing: 20) {
                    Text(User.Mark_User.initials)
                        .shimmering()
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray3))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(User.Mark_User.fullname)
                            .font(.title3).bold()
                        Text(viewModel.CurrentUser?.email ?? User.Mark_User.email)
                            .clipShape(Rectangle())
                            .padding(1)
                            .font(.footnote)
                            .foregroundColor(.gray)
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
                Section("Display") {
                    
                    Toggle("Dark Mode", isOn: $isDarkMode)
                    
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
                    }
                    
                    Button {
//                        isLoading = true
                        performLogout()
                    } label: {
                        Text("Logout")
                            .foregroundColor(.red)
                    }
                }
                
//                .alert(isPresented: $showAlertSignout) {
//                    Alert(
//                        title: Text("Are you sure you want to logout?"),
//                        primaryButton: .destructive(
//                            Text("Logout"),
//                            action: {
//                                performLogout()
//                            }
//                        ),
//                        secondaryButton: .cancel()
//                    )
//                }
                .alert(isPresented: $showAlertDelectAccount) {
                    Alert(
                        title: Text("Are you sure you want to Delect Accoun ⚠️ ?"),
                        primaryButton: .destructive(
                            Text("DELECT"),
                            action: {
                                Task {
                                    do {
                                        let _ = performDelectAccount()
                                    } catch {
                                        await setError(error)
                                    }
                                }
                            }
                        ),
                        secondaryButton: .cancel()
                    )
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
        delectAccount()
        isLoggedIn = false
    }
    
    func delectAccount() {
        Task {
            do {
                guard let userUID = Auth.auth().currentUser?.uid else { return }
                //            try await Auth.auth().currentUser?.delete()
                /// Deleceting firestore user documents
                try await Firestore.firestore().collection("user").document(userUID).delete()
                /// Delecting the Auth account
                try await Auth.auth().currentUser?.delete()
            } catch {
                await setError(error)
            }
        }
    }
    
    func setError(_ error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            shwoError.toggle()
        })

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
