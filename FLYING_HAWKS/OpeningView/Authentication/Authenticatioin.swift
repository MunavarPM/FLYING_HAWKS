


import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore



protocol AutheticationFromProtocol {
    var formIsValid: Bool { get }
}
@MainActor /// For publishing the UI update to another thread ( If the all func are happend in the background side at this time that all data we need to push to front side )
class AuthenticationModel: ObservableObject { ///checker
    @Published var UserSession: FirebaseAuth.User? /// user is here or not checker with firebase object
    @Published var CurrentUser: User?
    
    init() {
        self.UserSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    func signIn(withEmail email: String, password: String) async throws {
        
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.UserSession = result.user ///way to profile
            await fetchUser()
        } catch {
            print("Error in signIn \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password) /// Was user using firebase that we installed and connecting those
            self.UserSession = result.user /// we it was succues we set it as an UserSession
            let user = User(id: result.user.uid, fullname: fullname, email: email)  /// Thus details from the firebase and create our object
            let encodedUser = try Firestore.Encoder().encode(user) ///
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser) 
            //            await fetchUser()
        } catch {
            print("Debug failed in creating the user \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        
        do {
            try Auth.auth().signOut() // sign out our your from backend
            self.UserSession = nil  // wipe out user session and get back to login screen
            self.CurrentUser = nil
        } catch {
            print("Enrror in the signour\(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {  /// Help to get the current user id
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        guard let user = try? await Firestore.firestore().collection("users").document(userUID).getDocument(as: User.self) else { return }
        await MainActor.run(body: {
            CurrentUser = user
        })
    }
}