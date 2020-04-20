//
//  UIViewController+NavBar.swift
//  MediaFinder
//
//  Created by Ziad on 4/17/20.
//  Copyright © 2020 intake4. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func removeNavBarBorders() {
        // removing the borders of the navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}
