//
//  BaseService.swift
//  Mvvm
//
//  Created by laluheri on 9/20/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import Foundation
import Alamofire
open class BaseService {
    
    var header : HTTPHeaders?{
        let accesToken = UserDefaults.standard.string(forKey: Constant.API_TOKEN) ?? ""
        let headers = [
               "Authorization": "Bearer "+accesToken,
               "Content-Type": "application/x-www-form-urlencoded"
           ]
        return headers
    }
    
}
