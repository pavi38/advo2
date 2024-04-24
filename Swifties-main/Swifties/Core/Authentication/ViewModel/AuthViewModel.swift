//
//  AuthViewModel.swift
//  Swifties
//
//  Created by Rosa on 2/17/24.
//
import Firebase
import Foundation
import FirebaseFirestoreSwift

// form validation protocol starter
protocol AuthenticationFormProtocol {
    var formIsValid: Bool {get}
}

//@MainActor

class AuthViewModel: ObservableObject {
    // keeps track of the seesion to keep users log in
    @Published var userSession: FirebaseAuth.User?
    // keeps track of the user that has an oppen session
    @Published var currentUser: User? //change user to non-optional
    @Published var Dependentfound: String = ""
    @Published var listofCaregiver = [User]()
    @Published var listofDependents = [User]()
    @Published var error: String?
    static var UserId: String? = "123"
    init() {
        //checks if there is a user session to keep the user log in
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
            //await fetchDependents()
        }
    }
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
            
        } catch {
            print("Debug: Fail to log in with error \(error.localizedDescription)")
        }
    }
    
    //creates a new usser and sets a session to keep the user log in
    func createUser(withEmail email: String, password: String, fullname: String, type: String) async throws {
        print ("create user..")
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullname, email: email, dependents: [], caregivers: [],phoneNum: "333", userType: type) //pavi2
            
            let encodedUser = try Firestore.Encoder().encode(user)
            
            //upload collection to firebase
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            await fetchUser()
        } catch {
            print ("Debug: Fail to create user with error \(error.localizedDescription)")
        }
    }
    
    //Sign user out and remove user data
    func signOut () {
        do {
            try Auth.auth().signOut() //signs out user in the back end
            do {
              try Auth.auth().useUserAccessGroup(nil) //removing the user from the acess group. ps
            } catch let error as NSError {
              print("Error changing user access group: %@", error)
            }
            self.userSession = nil //removes user session and returns to log in screen
            self.currentUser = nil //removes user data
            self.listofDependents = []
            self.listofCaregiver = []
            AuthViewModel.UserId = ""
            
            Dependentfound = "he"
        } catch {
            print("Debug: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
    }
    
    //gathers data from current user from Firebase ir order to populate the profile view
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        AuthViewModel.UserId = uid
        do {
          try Auth.auth().useUserAccessGroup("com.Swifties.shareUser") //adding the user state to the acess group. ps
        } catch let error as NSError {
          print("Error changing user access group: %@", error)
        }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { print("Could not retreive user"); return}
        
        self.currentUser = try? snapshot.data(as: User.self)
        await fetchDependents()
        await fetchCaregiver()
        print("Debug: Current user is \(String(describing: self.currentUser))")
    }
    
    func fetchDependents() async  {
        self.Dependentfound = ""
        guard let uid = currentUser?.id else {return}
        let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument()
        let updateduser = try? snapshot?.data(as: User.self)
        //var listofDependentsIDS = currentUser!.dependents
        var listofDependentsIDS = updateduser!.dependents
        self.listofDependents = []
        for id in listofDependentsIDS {
            guard let snapshot = try?  await Firestore.firestore().collection("users").document(id).getDocument() else {
                self.error = "not added"; return}
            
            let dependent = (try? snapshot.data(as: User.self))  //fyt
            self.listofDependents.append(dependent!)
            
        }
        self.error = "added"
    }
    
    func fetchCaregiver() async {
        
        let listofCaregiverIDS = self.currentUser!.caregivers
        //if listofCaregiverIDS.isEmpty {return}
        self.listofCaregiver = []
        for id in listofCaregiverIDS {
            guard let snapshot = try? await Firestore.firestore().collection("users").document(id).getDocument() else { print("Could not retreive user"); return}
            
            let caregiver = try? snapshot.data(as: User.self)
            self.listofCaregiver.append(caregiver!)
        }
        
    }
    
    func addDependent(dependentUID: String) { //ps1
        if(dependentUID == ""){return}
        guard let uid = currentUser?.id else {return}
        
        let Caregiverdoc = Firestore.firestore().collection("users").document(uid) //database entry for the caregiver

        let dependentdoc =  Firestore.firestore().collection("users").document(dependentUID)
        dependentdoc.getDocument { (document, error) in
            if document!.exists {
                print("Document data exist")
                Caregiverdoc.updateData(["dependents":  FieldValue.arrayUnion([dependentUID])])
                dependentdoc.updateData(["caregivers": FieldValue.arrayUnion([uid])])
                self.Dependentfound = "Dependent added Sucessfully"
                  } else {
                     print("Document does not exist")
                      self.Dependentfound = "Dependent not Found"
                  }
            }
        Task.init{
            try await Task.sleep(nanoseconds: 2_000_000_000)
            await fetchDependents()
        }
        //database entry for the dependent
        

        
    }
    func removeDependent(dependentUID: String) { //ps1
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let Caregiverdoc = Firestore.firestore().collection("users").document(uid)
        let dependentdoc = Firestore.firestore().collection("users").document(dependentUID)
        
        Caregiverdoc.updateData(["dependents":  FieldValue.arrayRemove([dependentUID])])
        dependentdoc.updateData(["caregivers": FieldValue.arrayRemove([uid])])
    }
    func printa(x: String){
        print("sdsds",x)
    }
}
