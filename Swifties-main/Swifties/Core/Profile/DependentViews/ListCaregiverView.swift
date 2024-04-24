//
//  ListCaregiverView.swift
//  Swifties
//
//  Created by Pavneet Cheema on 4/20/24.
//

import SwiftUI

struct ListCaregiverView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(viewModel.listofCaregiver){ user in
                    HStack{
                        Text(user.initialis)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 62, height: 62)
                            .background(Color(.systemGray3))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .padding(.trailing, 10)
                        Text(user.fullName)
                            .foregroundColor(.black)
                        Spacer()
                    }.padding(.horizontal)
                    Divider().padding(.vertical, 8)
                }
            }
            .navigationTitle("Caregivers")
        }
    }
}

#Preview {
    ListCaregiverView()
}
