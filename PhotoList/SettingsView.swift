//
//  SettingsView.swift
//  PhotoList
//
//  Created by Öznur Köse on 11.04.2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: Settings
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle("Show photos with name", isOn: $settings.nameOnly)
                }
                Section {
                    Toggle("Dark mode", isOn: $isDarkMode)
                }
            }
            .navigationTitle("Settings")
            
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
