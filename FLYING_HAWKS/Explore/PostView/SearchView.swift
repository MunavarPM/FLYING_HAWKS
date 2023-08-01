//
//  SearchView.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 01/08/23.
//

import SwiftUI
import FirebaseFirestore

struct SearchView: View {
    @State private var fetchedUser: [User] = []
    @State private var searchText: String = ""
    var body: some View {
        
        List {
            ForEach(fetchedUser) { user in
                NavigationLink {
                    ReusableView(user: user)
                } label: {
                    Text(user.fullname)
                        .font(.callout)
                        .hAlign(.leading)
                }
            }
        }
        .searchable(text: $searchText)
        .listStyle(.plain)
        .navigationTitle("Search User")
        .navigationBarTitleDisplayMode(.inline)
        .onSubmit(of: .search, {
            Task {
                await searchUser()
            }
        })
        .onChange(of: searchText, perform: { newValue in
            if newValue.isEmpty {
                fetchedUser = []
            }
        })
    }
    
    func searchUser() async {
        do {
            let queryLowerCase = searchText.lowercased()
            let queryUpperCase = searchText.uppercased()
            
            let documents = try await Firestore.firestore().collection("users")
                .whereField("fullname", isGreaterThanOrEqualTo: queryUpperCase)
                .whereField("fullname", isLessThanOrEqualTo: "\(queryLowerCase)\u{f8ff}")
                .getDocuments()
            
            let users = try documents.documents.compactMap { doc -> User? in
                try doc.data(as: User.self)
            }
            ///UI update in main Thread
            await MainActor.run(body: {
                fetchedUser = users
            })
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .preferredColorScheme(.dark)
    }
}
