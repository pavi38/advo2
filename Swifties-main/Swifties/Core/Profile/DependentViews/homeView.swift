//
//  homeView.swift
//  Swifties
//
//  Created by Pavneet Cheema on 4/20/24.
//

import SwiftUI
private func settingsOpener(){
    if let url = URL(string: UIApplication.openSettingsURLString) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
struct homeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        if let user = viewModel.currentUser {
            NavigationView {
                VStack{
                    Text("Dependent ID")
                        .font(.system(size: 30))
                        .bold()
                        .foregroundStyle(.ablue)
                    Text(viewModel.currentUser!.id)
                    Spacer()
                        .frame(minHeight: 50, maxHeight: 200)
                    Button{
                        settingsOpener()
                    }label: {
                        HStack {
                            Text("Add Keyboard")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 40, height:48)
                    }
                    .background(Color(.ablue))
                    .cornerRadius(20)
                    .padding(.top, 14)
                }
                .navigationTitle("Home")
            }
        }

    }
}

#Preview {
    homeView()
}
