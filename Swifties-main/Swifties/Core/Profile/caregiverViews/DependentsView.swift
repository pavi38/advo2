//
//  DependentsView.swift
//  Swifties
//
//  Created by Pavneet Cheema on 4/17/24.
//

import SwiftUI

struct DependentsView: View {
    
    @State var navigatetonotifview = false
    @EnvironmentObject var viewModel: AuthViewModel
    let selectnewuser: (User) -> ()
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView{

                    ForEach(viewModel.listofDependents){ user in
                        NavigationLink{
                            notificationView(nm: notificationViewModel(dependent: user), tempuser: user)
                        }label: {
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
                            
                        }
                        Divider().padding(.vertical, 8)
                    }
                }
                VStack {
                    Spacer()
                    
                    NavigationLink(destination: AddCareGiverViews()) {
                        //Image(systemName: "plus.circle.fill")
                           Text("+ Add Dependent")
                            //.resizable()
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .frame(width:250, height: 50)
                            .foregroundColor(.white)
                            .background(.advoRed)
                            .cornerRadius(40)
                            .padding(.bottom, 40)
                    }
                }
                .navigationTitle("Dependents")
            }
        }
    }
}

struct AddCareGiverViews: View {
    @State private var caregiverPhoneNumber = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var t = false
    
    //    // Firestore reference
    //    private let db = Firestore.firestore()
    //    private let usersCollection = "users"
    
    var body: some View {
        if let user = viewModel.currentUser {
            VStack {
                Text(viewModel.Dependentfound)
                    .padding(.bottom, 100)
                InputView(text: $caregiverPhoneNumber, title:"Enter Dependent ID", placeholder: "Enter number with no spaces")
                    .autocapitalization(.none)
                    .padding()
                    .padding(.bottom, 40)
                
                
                Button("Add Dependent"){
                    viewModel.addDependent(dependentUID: caregiverPhoneNumber)
                }                
                .padding()
                .foregroundColor(.white)
                .background(.advoRed)
                .cornerRadius(8)
                
                
            }
        } else {
            Text("there was an error finding the user profiile info please try again later!")
        }
        Spacer()
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

