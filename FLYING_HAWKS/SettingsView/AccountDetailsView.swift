//
//  AccountDetailsView.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 27/07/23.
//

import SwiftUI

struct AccountDetailsView: View {
    @State var name: String = "Munavar"
    var body: some View {
        Text("Hello, \(name)!")
    }
}

struct AccountDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailsView()
    }
}
