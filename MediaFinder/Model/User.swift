//
//  UserModel.swift
//  RegistrationApp
//
//  Created by Ziad on 1/30/20.
//  Copyright © 2020 intake4. All rights reserved.
//

import Foundation

enum Gender: String {
    case male = "Male"
    case female = "Female"
}

struct User {

    let name: String!
    let email: String!
    let password: String!
    let phone: String!
    let photo: Data!
    let gender: String!
    let address: String!
    
}

    

    





