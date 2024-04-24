//
//  mainMenu.swift
//  Swifties
//
//  Created by Pavneet Cheema on 4/17/24.
//

import SwiftUI

struct mainMenu: View {
    @State var tuser: User?
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        TabView {
            MessagesView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Notificaions")
            }
            DependentsView( selectnewuser: {user in self.tuser = user})
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Dependents")
            }
            SettingView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("profile")
            }
        }
    }
}


#Preview {
    mainMenu()
}
