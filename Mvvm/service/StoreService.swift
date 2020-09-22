//
//  StoreService.swift
//  Mvvm
//
//  Created by laluheri on 9/20/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import Foundation
import Alamofire

class StoreService : BaseService{
    func fetchStoreList(completion : @escaping (StoreData?, Error?) -> ()){
        let endPoint = "stores"
        
        Network().request(endPoint: endPoint, parameters: nil, method: HTTPMethod.get, header: self.header, completion: completion)
    }
}


class StoreData: Decodable{
    var data : [Store]?
    
    private enum CodingKeys : String, CodingKey {
        case data     = "data"
    }
}
