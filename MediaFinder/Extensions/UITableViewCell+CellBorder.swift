//
//  UITableViewCell+CellBorder.swift
//  MediaFinder
//
//  Created by Ziad on 4/17/20.
//  Copyright © 2020 intake4. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    func shadowAndBorderForCell(cell: UITableViewCell){
        
        // SHADOW AND BORDER FOR CELL
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.layer.borderWidth = 2.0
        cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = true
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        cell.layer.mask?.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: 12.5)
    }
}
