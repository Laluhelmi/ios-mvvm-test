//
//  DataViewModel.swift
//  Mvvm
//
//  Created by Lalu Hilmi on 9/18/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import UIKit

class LoginViewModel {

    
    private var service: LoginService?
    
    private var error : Error?{
        didSet{
            self.didError?(self.error)
        }
    }
    private var accesToken : String?{
        didSet{
            self.didFinishFetch?(self.accesToken)
        }
    }
    
    var didFinishFetch: ((String?) -> ())?
    var didError      : ((Error?) -> ())?
    
    init(service: LoginService) {
        self.service = service
    }
    
    func login(username: String,password: String){
        service?.login(username: username, password: password,completion: {
            (accesToken, error) in
            if let accesToken = accesToken?.access_token{
                self.accesToken = accesToken
            }
            if let error = error{
                self.error = error
            }
        })
    }
}
