//
//  UIViewController+TextIcons.swift
//  MediaFinder
//
//  Created by Ziad on 4/17/20.
//  Copyright © 2020 intake4. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setTextFieldIcon(textField: UITextField, image: String) {
        // setting unified frame
        let imageViewFrame = CGRect(x: 5, y: 5, width: 20, height: 20)
        // setting textfield icon
        let imageView = UIImageView()
        let icon = UIImage(named: image)
        imageView.image = icon
        imageView.frame = imageViewFrame
        textField.leftViewMode = UITextField.ViewMode.always
        textField.addSubview(imageView)
        // setting padding view
        textField.leftView = UIView(frame: imageViewFrame)
    }

}
