//
//  UIViewController+ShowAlert.swift
//  MediaFinder
//
//  Created by Ziad on 4/17/20.
//  Copyright © 2020 intake4. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
