//
//  notificationView.swift
//  Swifties
//
//  Created by Pavneet Cheema on 4/19/24.
//

import SwiftUI

struct notificationView: View {
    
    @ObservedObject var nm: notificationViewModel
    @State var tempuser: User?
    
    var body: some View {
        ScrollView{
            ForEach(nm.ListOfNotif){ notif  in
                VStack{
                    Text("Sensitive Infromation shared:")
                        .foregroundColor(.white)
                    Text(notif.pli)
                        .foregroundStyle(.advoRed)
                }
                .padding(.leading,35)
                .padding(.trailing,35)
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
            }.navigationTitle(tempuser!.fullName)
                .navigationBarTitleDisplayMode(.inline)
                .padding(20)
        }
    }
}

//#Preview {
//    notificationView()
//}
