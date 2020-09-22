//
//  DataService.swift
//  Mvvm
//
//  Created by Lalu Hilmi on 9/17/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import UIKit
import Alamofire

class ProfileService :BaseService{

    
    func fetchProfile(completion : @escaping (ProfileResponse?, Error?) -> ()){
        let endPoint = "users/me"
        Network().request(endPoint: endPoint, parameters: nil, method: .get, header: self.header, completion: completion)
    }
    
    func fetchMaterialRaws(
        storeId: String,
        page   : Int = 1,
        completion : @escaping (MaterialRawResponse?, Error?) -> ()){
       
        //    let pageString = String(pa)
        
        let endPoint = "raw-materials?storeId="+storeId+"&page="
        Network().request(endPoint: endPoint, parameters: nil, method: .get, header: self.header, completion: completion)
    }
    
}

class ProfileResponse: Decodable {
    var data: Profile?
}

class MaterialRawResponse: Decodable{
    var data: [MaterialRaw]?
}

class Link: Decodable{
    
}
