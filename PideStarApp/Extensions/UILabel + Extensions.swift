//
//  UILabel + Extensions.swift
//  PideStarApp
//
//  Created by Mohammad Barek on 4/1/21.
//

import Foundation
import UIKit

extension UILabel {
    func applyStyle(textColor: UIColor?, font: UIFont? = nil) {
        self.textColor = textColor
        self.font = font ?? self.font
    }
}
