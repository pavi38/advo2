//
//  ProfileView.swift
//  Swifties
//
//  Created by Rosa on 2/14/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    //@EnvironmentObject var userType: UserType
    var body: some View {
        //mainMenu()
        if let user = viewModel.currentUser {
            if user.userType == "dependent"{
                DependentMain()
            }
            else{
                mainMenu()
            }
        }
    }

}

#Preview {
    ProfileView()
}
