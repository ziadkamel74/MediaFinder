//
//  Constants.swift
//  RegistrationApp
//
//  Created by Ziad on 3/1/20.
//  Copyright © 2020 intake4. All rights reserved.
//

import Foundation
// Cells
struct Cells {
    static let mediaCell: String! = "MediaCell"
}

// Storyboards
struct Storyboards {
    static let main = "Main"
}

// ViewControllers
struct VCs {
    static let signUpVC = "SignUpVC"
    static let mapVC = "MapVC"
    static let loginVC = "LoginVC"
    static let MediaListVC = "MediaListVC"
    static let profileVC = "ProfileVC"
}

struct UserDefaultsKeys {
    static let isLoggedIn = "isLoggedIn"
    static let userLogData = "userLogData"
    static let email = "email"
    static let id = "id"
}

struct Urls {
    static let base = "https://itunes.apple.com/search?"
}

struct apiKeys {
    static let term = "term"
    static let media = "media"
}

struct apiMedia {
    static let typeIndex: [Int:String] = [0:"all", 1:"music", 2:"tvShow", 3:"movie"]
}

