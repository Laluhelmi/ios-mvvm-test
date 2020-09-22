//
//  LoginService.swift
//  Mvvm
//
//  Created by laluheri on 9/19/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import Foundation
import Alamofire

class LoginService : BaseService{
    
    
    func login(username: String,password: String,completion : @escaping (AccesToken?, Error?) -> ()){
        
        let endPoint = "oauth/token"
        let parameters = [
            "username"       : username,
            "password"       : password,
            "grant_type"     : PasswordGrandType.GRAND_TYPE,
            "client_id"      : PasswordGrandType.CLIENT_ID,
            "client_secret"  : PasswordGrandType.CLIENT_SECRET
            ]
            as [String : Any]
        
        Network().request(endPoint: endPoint, parameters: parameters, method: HTTPMethod.post, header: nil, completion: completion)
    }

}

class AccesToken: Decodable{
    var access_token : String?
    var error : Bool?
    var message : String?
}


