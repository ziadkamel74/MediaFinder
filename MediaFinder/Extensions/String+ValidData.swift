//
//  String+ValidData.swift
//  MediaFinder
//
//  Created by Ziad on 4/17/20.
//  Copyright © 2020 intake4. All rights reserved.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
        return testEmail.evaluate(with: self)
    }
    var isValidPhone: Bool {
        let regularExpressionForPhone = "^\\d{3}\\d{3}\\d{5}$"
        let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
        return testPhone.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let regularExpressionForPassword = ".{8,}"
        let testPassword = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPassword)
        return testPassword.evaluate(with: self)
    }
}
