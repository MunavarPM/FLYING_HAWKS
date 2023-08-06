//
//  Post.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 28/07/23.
//

import SwiftUI
import FirebaseFirestoreSwift

/// Post model
struct Post: Identifiable, Codable,Equatable, Hashable {
    @DocumentID var id: String?
    var text: String
    var imageURL: URL?
    var imageReferenceID: String = ""
    var publishedDate: Date = Date()
    var reactedIDs: [String] = []
    var dislikedIDs: [String] = []
    /// User info
    var userName: String
    var userID: String
    var userProfileURL: URL
    
    enum CodingKeys: CodingKey {
        case id
        case text
        case imageURL
        case imageReferenceID
        case publishedDate
        case reactedIDs
        case dislikedIDs
        case userName
        case userID
        case userProfileURL
    }   
}
