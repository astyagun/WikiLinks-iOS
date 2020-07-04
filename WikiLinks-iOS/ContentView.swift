//
//  ContentView.swift
//  WikiLinks - iOS
//
//  Created by Anton Styagun on 03.07.2020.
//  Copyright © 2020 Anton Styagun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var address: String = UserDefaults.standard.string(forKey: "nextcloudAddress") ?? String()
    @State private var username: String = UserDefaults.standard.string(forKey: "nextcloudUsername") ?? String()
    
    var body: some View {
        NavigationView {
            Form {
                TextField(
                    "Address",
                    text: $address,
                    onEditingChanged: { _ in
                        UserDefaults.standard.set(self.address, forKey: "nextcloudAddress")
                })
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .keyboardType(.URL)
                    .textContentType(.URL)
                
                TextField(
                    "User name",
                    text: $username,
                    onEditingChanged: { _ in
                        UserDefaults.standard.set(self.username, forKey: "nextcloudUsername")
                })
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .keyboardType(.alphabet)
                    .textContentType(.username)
            }.navigationBarTitle(Text("Nextcloud server"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
