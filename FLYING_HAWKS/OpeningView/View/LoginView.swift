//
//  LoginView.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 27/07/23.
//

import SwiftUI
import FirebaseAuth
import CoreData

struct LoginPage : View {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @State var email = ""
    @State var Password = ""
    @State private var isAlert = false
    @State private var errorMessage: String = ""
    @State private var shwoError: Bool = false
    @State var isLoading: Bool = false
    @EnvironmentObject var viewModel: AuthenticationModel

    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color("Color")
                VStack {
                    Spacer(minLength: 0)
                    HStack {
                        VStack(alignment: .leading,spacing: 12, content: {
                            Text("Welcome back,")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                            Text("please login to enjoy full features")
                                .foregroundColor(Color.white.opacity(0.5))
                        })
                        .padding()
                        Spacer(minLength: 0)
                    }
                    /// Enter Field.
                    HStack {
                        Image(systemName: "person.circle")
                            .font(.title2)
                            .foregroundColor(Color.white.opacity(0.5))
                        TextField("Email...", text: $email)
                            .autocapitalization(.none)
                        
                    }
                    .padding()
                    .background(Color.white.opacity(email == "" ? 0 : 0.12))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    HStack {
                        Image(systemName: "key")
                            .font(.title2)
                            .foregroundColor(Color.white.opacity(0.5))
                        SecureField("Password...", text: $Password)
                            .autocapitalization(.none)
                        
                    }
                    .padding()
                    .background(Color.white.opacity(Password == "" ? 0 : 0.12))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.top)
                    
                    HStack(spacing: 15) {
                        Button {
                            login()
                        } label: {
                            Text("LOGIN")
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .disabled(!formIsValid)
                                .opacity(formIsValid ? 1.0 : 0.5)
                                .padding(.vertical)
                                .frame(width: 250)
                                .background(Color("Color2"))
                                .clipShape(Capsule())
                        }
                        
                        .alert(errorMessage, isPresented: $shwoError, actions: {})
                        .alert(isPresented: $isAlert) {
                            Alert(title: Text("Error"),
                                  message: Text("Invalid email or password."), primaryButton: .cancel(Text("Try again"),action: {
                                isLoading = false
                            }), secondaryButton: .destructive(Text("Delete"),action: clearTextFields))
                        }
                        .opacity(email != "" && Password != "" ? 1 : 0.5)
                        .disabled(email != "" && Password != "" ? false : true)
                        
                    }
                    .padding(.top)
                    
                    Button {
                        resetPassword()
                    } label: {
                        Text("forget password?")
                            .foregroundColor(Color("Color2"))
                    }
                    .padding(.top,8)
                    Spacer(minLength: 0)
                    
                    HStack(spacing: 6) {
                        Text("Don't have any account?")
                            .foregroundColor(Color.white.opacity(0.6))
                        
                        NavigationLink {
                            signupView()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Signup")
                                .fontWeight(.heavy)
                                .foregroundColor(Color("Color2"))
                        }
                        
                    }
                    .padding(.vertical,45)
                }
            }
            .ignoresSafeArea(.all)
        }
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
    }
    
    func login() {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: Password) { (result, error) in
            if error != nil {
                self.isAlert = true
                print(error?.localizedDescription ?? "")
                isLoading = false
            } else {
                Task {
                    try await viewModel.signIn(withEmail: email, password: Password)
                    isLoading = false
                    isLoggedIn = true
                }
            }
        }
    }
    
    func resetPassword() {
        isLoading = true
        Task {
            do {
                try await Auth.auth().sendPasswordReset(withEmail: email)
            } catch {
                await setError(error)
            }
        }
    }
    
    func setError(_ error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            shwoError.toggle()
            isLoading = false
        })
    }
    
    func clearTextFields() {
        email = ""
        Password = ""
        isLoading = false
    }
}

extension LoginPage: AutheticationFromProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@gmail.com")
        && !Password.isEmpty
        && Password.count > 5
    }
}

extension View {
    func hAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    func vAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    func disableWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
            .preferredColorScheme(.dark)
    }
}
