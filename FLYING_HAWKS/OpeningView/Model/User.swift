//
//  User.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 27/07/23.
//

import Foundation

struct User: Identifiable, Codable {
    
    let id: String
    let fullname: String
    let email: String
    let profileURL:URL
    
    
    var initials: String {  /// for initial like munavar ( MU )
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User {
   
    static var Mark_User = User(id:"\(String(describing: UUID(uuidString: "uknown")))", fullname: "UNKONWN", email: "UNKNOWN", profileURL:URL(string: "invalid")!)
}
