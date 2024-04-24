//
//  AddCareGiverView.swift
//  Swifties
//
//  Created by Pavneet Cheema on 4/17/24.
//

import SwiftUI

import SwiftUI
import FirebaseFirestore

struct AddCareGiverView: View {
    @State private var caregiverPhoneNumber = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    //    // Firestore reference
    //    private let db = Firestore.firestore()
    //    private let usersCollection = "users"
    
    var body: some View {
        if let user = viewModel.currentUser {
            VStack {
                InputView(text: $caregiverPhoneNumber, title:"Enter Dependent ID", placeholder: "Enter number")
                    .autocapitalization(.none)
                
                Spacer()
                
                Button("Add Dependent") {
                    Task {
                        viewModel.printa(x: caregiverPhoneNumber)
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
            }
        } else {
            Text("there was an error finding the user profiile info please try again later!")
        }
        
    }
    
    
    struct UpdateUserView_Previews: PreviewProvider {
        static var previews: some View {
            AddCareGiverView()
        }
    }
}
