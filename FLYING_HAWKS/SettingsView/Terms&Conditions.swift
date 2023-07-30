//
//  TermsCondition.swift
//  Flying Hawks
//
//  Created by MUNAVAR PM on 20/06/23.
//

import SwiftUI

struct TermsCondition: View {
    var body: some View {
        ZStack {
            Color("Color1").ignoresSafeArea(.all)
            Text("1.App Usage. \n\na. The Goalkeepers App is intended for personal, non-commercial use related to soccer goalkeeping. You may use the App to access information, tips, and resources for improving goalkeeping skills. \nb. You are solely responsible for your use of the App and any consequences that may arise from it. You agree to use the App in compliance with applicable laws and regulations.\nc. You may not use the App for any illegal, unauthorized, or malicious activities. Any misuse of the App or violation of these Terms may result in termination of your access to the App.\n\n 2.Intellectual Property. \n\na. The Goalkeepers App, including its content, design, logos, and trademarks, is protected by intellectual property laws and remains the property of the app developers or its licensors \nb. You may not reproduce, distribute, modify, or create derivative works of the App or its content without prior written permission from the app developers.\nc. You may use the App and its content for personal, non-commercial purposes only. Any unauthorized use or infringement of the intellectual property rights may result in legal action.\n\n 3.Privacy. \n\na. The Goalkeepers App may collect and process personal information as described in its Privacy Policy. By using the App, you consent to the collection, storage, and use of your personal information in accordance with the Privacy Policy.\nb. You are responsible for providing accurate and up-to-date information during the registration or account creation process.")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
        }
    }
}

struct TermsCondition_Previews: PreviewProvider {
    static var previews: some View {
        TermsCondition()
    }
}
