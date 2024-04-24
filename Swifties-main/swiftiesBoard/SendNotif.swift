//
//  SendNotif.swift
//  swiftiesBoard
//
//  Created by Pavneet Cheema on 3/28/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
//import Swifties


class SendNotif{
    //var UserName: String
    var currentDependent: Dependent?
    //var user: FirebaseAuth.User?
    init(){
        fetchfromKeychain()
        Task{
            await fetchUser()
        }
        
//
    }
    func fetchfromKeychain(){
        do {
          try FirebaseManager.shared.auth.useUserAccessGroup("com.Swifties.shareUser") //adding the user state to the acess group. ps
        } catch let error as NSError {
          print("Error changing user access group: %@", error)
        }
        print("fetched from keychain")

    }
    func fetchUser() async{
        guard let dependentId = FirebaseManager.shared.auth.currentUser?.uid else {return}
        guard let snapshot = try? await FirebaseManager.shared.firestore.collection("users").document(dependentId).getDocument() else { print("Could not retreive user"); return}
        self.currentDependent = try? snapshot.data(as: Dependent.self)
    }
    func getUserName() async -> String {
        let userName = currentDependent!.fullName
        return userName
    }
    func handleSend(notif: String) {
        //var currentUser
        //var vm = test()
        //let caregiverID = "Ib7H5MCd3BZGDULQYLPM3fYv80m2"
        //let uid = currentDependent?.uid
        guard let dependentId = FirebaseManager.shared.auth.currentUser?.uid else {return} //uid from which the message wass sent
        //let snapshot = FirebaseManager.shared.firestore.collection("users").document(dependentId).getDocument()
//        Task{
//            guard let snapshot = try? await FirebaseManager.shared.firestore.collection("users").document(dependentId).getDocument() else { print("Could not retreive user"); return}
//            currentUser = try? snapshot.data()
//        }
        print(currentDependent!.caregivers)
        for caregiverID in currentDependent!.caregivers {
            let document = Firestore.firestore().collection("notifications").document(caregiverID).collection(dependentId).document() //table for the sensitive info notification
            
            let NotifData = ["Caregiver ID": caregiverID, "Dependent ID": dependentId, "PLI": notif]
            document.setData(NotifData)
        }
        print("user uid is",dependentId)
        //print(vm.currentUser.uid)
    }
}
