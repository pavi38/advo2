//
//  User.swift
//  swiftiesBoard
//
//  Created by Pavneet Cheema on 4/23/24.
//

import Foundation

struct Dependent: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String
    let dependents: [String] //uid of all the dependents linked to the user ps1
    let caregivers : [String] //uid of all the caregiver linked to the user ps1
    let phoneNum: String
    let userType: String //pavi2
    
    var initialis: String {
        let formatter = PersonNameComponentsFormatter()
        
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            
            return formatter.string(from: components)
        }
        
        return ""
    }
}

extension Dependent {
    static var MOCK_USER = Dependent(id: NSUUID().uuidString, fullName: "some user", email:"someuser@mail.com",dependents: [], caregivers: [],phoneNum: "9999999999", userType: "dependent")
}
