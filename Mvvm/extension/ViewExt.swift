//
//  ViewExt.swift
//  Mvvm
//
//  Created by laluheri on 9/21/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    func addShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.5
    }
}
