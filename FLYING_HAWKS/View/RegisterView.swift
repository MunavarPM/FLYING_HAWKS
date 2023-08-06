//
//  signupView.swift
//  Flying Hawks
//
//  Created by MUNAVAR PM on 16/06/23.
//

import SwiftUI

struct signupView: View {
    var body: some View {
        NavigationStack {
            Viewsignup()
        }
        .preferredColorScheme(.dark)
        .animation(.easeInOut(duration: 2))
    }
}

struct signupView_Previews: PreviewProvider {
    static var previews: some View {
        signupView()
    }
}

struct Viewsignup : View {
    
    @State var fullname = ""
    @State var email = ""
    @State var password = ""
    @State var conformPassword = ""
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @State var isLoading: Bool = false
    @State private var errorMessage: String = ""
    @State private var shwoError: Bool = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthenticationModel
    
    var body: some View {
        ZStack {
            Color("Color")
            
            VStack {
                /// heading.
                Spacer(minLength: 0)
                HStack {
                    VStack(alignment: .leading,spacing: 12, content: {
                        Text("Welcome to Flying Hawks")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                        Text("Create an account and let's build the future Hawks 🦅")
                            .foregroundColor(Color.white.opacity(0.5))
                        
                    })
                    .padding()
                    Spacer(minLength: 0)
                }
                /// Enter Field.
                HStack{
                    Image(systemName: "person.circle")
                        .font(.title2)
                        .foregroundColor(Color.white.opacity(0.5))
                    TextField("name", text: $fullname)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                }
                .padding()
                .background(Color.white.opacity(fullname == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                HStack{
                    Image(systemName: "envelope.fill")
                        .font(.title2)
                        .foregroundColor(Color.white.opacity(0.5))
                    TextField("Email",text: $email)
                        .autocapitalization(.none)
                    
                }
                .padding()
                
                .opacity(!formIsValid ? 1.0 : 0.5)
                .disabled(formIsValid)
                .background(Color.white.opacity(email == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
                .onTapGesture {
                    print("\(formIsValid)")
                }
                
                HStack {
                    Image(systemName: "key")
                        .font(.title2)
                        .foregroundColor(Color.white.opacity(0.5))
                    SecureField("Password",text: $password)
                        .autocapitalization(.none)
                    
                }
                .padding()
                .background(Color.white.opacity(password == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
                
                HStack {
                    Image(systemName: "key")
                        .font(.title2)
                        .foregroundColor(Color.white.opacity(0.5))
                    SecureField("conform password",text: $conformPassword)
                        .autocapitalization(.none)
                    if !password.isEmpty && !conformPassword.isEmpty {
                        if password == conformPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                    
                }
                .padding()
                .background(Color.white.opacity(conformPassword == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
                
                /// Button Field.
                HStack {
                    Button {
                        if password == conformPassword{
                            register()
                        }
                    } label: {
                        Text("Register")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: 250)
                            .background(Color("Color2"))
                            .clipShape(Capsule())
                    }
                    .alert(errorMessage, isPresented: $shwoError, actions: {})
                    .overlay(content: {
                        LoadingView(show: $isLoading)
                    })
                    .opacity(fullname != "" && password != "" && email != "" && conformPassword != "" ? 1 : 0.5)
                }
                .padding(.top,8)
                Spacer(minLength: 0)
                
                HStack(spacing : 6) {
                    Text("Have an account?")
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Login")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("Color2"))
                    }
                }
                .padding(.vertical,45)
            }
        }
        .ignoresSafeArea(.all)
    }
    
    func register() {
        
        /// Linking the firebase when tap the button
        Task {
            do {
                isLoading = true
                try await viewModel.createUser(withEmail: email, password:password, fullname: fullname)
                isLoggedIn = true
                isLoading = false
            } catch {
                await setError(error)
            }
        }
    }
    
    func uploadUserDataToFirebase(){
        
    }
    
    func setError(_ error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            shwoError.toggle()
        })
    }

}
extension Viewsignup: AutheticationFromProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@gmail.com")
        && !password.isEmpty
        && password.count > 5
        && password == conformPassword
        && !fullname.isEmpty
    }
}
