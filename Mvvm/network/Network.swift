//
//  Network.swift
//  Mvvm
//
//  Created by laluheri on 9/19/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import UIKit
import Alamofire

class Network{
    
    func request<T: Decodable>
                 (endPoint   : String,
                 parameters : [String : Any]?,
                 method     : HTTPMethod,
                 header     : HTTPHeaders?,
                 completion : @escaping (T?, Error?) -> ()){
        
        let url = Api.BASE_URL+endPoint
        
        Alamofire.request(url, method: method, parameters: parameters, headers: header).responseJSON(completionHandler: {
            loginResponse in
            
            
            switch loginResponse.result{
            case .success(_):
                if let statusCode = loginResponse.response?.statusCode{
                    switch statusCode {
                    
                    case 401:
                        let error: Error = ErrorResponse.unauthorized
                        completion(nil,error)
                    case 404:
                        let error: Error = ErrorResponse.pageNotFound
                        completion(nil,error)
                    case 400:
                        let error: Error = ErrorResponse.invalidEmailAndPassword
                        completion(nil,error)
                    default:
                        do{
                            if let data  = loginResponse.data{
                                let obj = try JSONDecoder().decode(T.self, from: data)
                                completion(obj,nil)
                            }
                        }catch(let error){
                            completion(nil,error)
                        }
                    }
                }
            //     completion()
            case .failure(let error):
                completion(nil,error)
            }
        })
    }
}


enum ErrorResponse: Error ,LocalizedError{
    case invalidEmailAndPassword
    case unauthorized
    case pageNotFound
    
    public var errorDescription: String? {
        switch self {
        case .invalidEmailAndPassword:
            return NSLocalizedString("Invalid Email And Password", comment: "Invalid Email and Password")
        case .pageNotFound:
            return NSLocalizedString("Page Not Found", comment: "Page Not Found")
        case .unauthorized:
            return NSLocalizedString("Unauthorized", comment: "Page Not Found")

        }
    }
}
