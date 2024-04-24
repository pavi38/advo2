//
//  DependentMain.swift
//  Swifties
//
//  Created by Pavneet Cheema on 4/20/24.
//

import SwiftUI

struct DependentMain: View {
    @State var tuser: User?
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        TabView {
            homeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Notificaions")
            }
            ListCaregiverView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Caregiver")
            }
            SettingView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("profile")
            }
        }.accentColor(.ablue)
    }
}

#Preview {
    DependentMain()
}
