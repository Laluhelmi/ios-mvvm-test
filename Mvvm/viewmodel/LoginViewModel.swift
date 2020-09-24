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
    
    
    var username: String?{
        didSet{
            self.onTextFieldType?()
        }
    }
    var password: String?{
        didSet{
            self.onTextFieldType?()
        }
    }
    
    var isButtonEnabled: Bool{
         return (self.username != "" && self.password != "")
    }
    
    var buttonAlpa :CGFloat{
        return isButtonEnabled == true ? 1.0 : 0.3
    }
    
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
    var onTextFieldType : (() -> ())?
    
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
