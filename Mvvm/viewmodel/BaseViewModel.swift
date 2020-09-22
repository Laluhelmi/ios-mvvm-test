//
//  BaseViewModel.swift
//  Mvvm
//
//  Created by laluheri on 9/20/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import Foundation

open class BaseViewModel {
    
     var error : Error?{
          didSet{
              self.didError?(self.error)
          }
      }
      
      var didFinishFetch: (() -> ())?
      var didError      : ((Error?) -> ())?
}
