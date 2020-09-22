//
//  TextFieldExt.swift
//  Mvvm
//
//  Created by laluheri on 9/19/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
          self.layer.masksToBounds = false
          self.layer.shadowRadius = 1.7
          self.layer.shadowColor = UIColor.blue.cgColor
          self.layer.shadowOffset = CGSize(width: 1, height: 0.3)
          self.layer.shadowOpacity = 1.0
     }
}
