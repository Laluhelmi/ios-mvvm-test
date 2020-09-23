//
//  DataService.swift
//  Mvvm
//
//  Created by Lalu Hilmi on 9/17/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import UIKit
import Alamofire

class DashBoardService :BaseService{

    
    func fetchProfile(completion : @escaping (ProfileResponse?, Error?) -> ()){
        let endPoint = "users/me"
        Network().request(endPoint: endPoint, parameters: nil, method: .get, header: self.header, completion: completion)
    }
    
    func fetchMaterialRaws(
        storeId: String,
        page   : Int = 1,
        completion : @escaping (MaterialRawResponse?, Error?) -> ()){
        
        let pageString = String(page)
        let endPoint = "raw-materials?storeId="+storeId+"&page="+pageString
        Network().request(endPoint: endPoint, parameters: nil, method: .get, header: self.header, completion: completion)
    }
    
    func materialRawDetail(id: String,completion : @escaping (MaterialRawDetail?, Error?) -> ()){
        
        let endPoint = "raw-materials/"+id
        Network().request(endPoint: endPoint, parameters: nil, method: .get, header: self.header, completion: completion)
    }
    
}

class ProfileResponse: Decodable {
    var data: Profile?
}

class MaterialRawDetail: Decodable {
    var data : MaterialRaw?
}

class MaterialRawResponse: Decodable{
    var data: [MaterialRaw]?
    var meta: Meta?
}

class Meta: Decodable{
    var first : Int?
    var current_page : Int?
    var last_page  : Int?
}
