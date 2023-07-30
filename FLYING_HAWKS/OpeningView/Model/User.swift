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
    static var Mark_User = User(id: NSUUID().uuidString, fullname: "Munavar BinShareef", email: "munavar@gmail.com")
}
